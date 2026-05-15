@echo off
setlocal EnableDelayedExpansion

echo ==========================================
echo   Embedded-Main Auto Submit Script
echo ==========================================
echo.

REM Check if in git repo
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Not a git repo. Please run this script inside Embedded-Main folder.
    pause
    exit /b 1
)

REM Get repo info
for /f "tokens=*" %%a in ('git remote get-url origin 2^>nul') do set REMOTE_URL=%%a
for /f "tokens=*" %%a in ('git branch --show-current') do set CURRENT_BRANCH=%%a

echo [INFO] Remote: %REMOTE_URL%
echo [INFO] Branch: %CURRENT_BRANCH%
echo.

REM Check for changes
for /f %%a in ('git status --porcelain ^| find /c /v ""') do set CHANGES=%%a
if %CHANGES%==0 (
    echo [TIP] No changes detected. Nothing to commit.
    pause
    exit /b 0
)

echo [INFO] Found %CHANGES% changed file(s):
git status --short
echo.

REM Ask submit mode
echo Select submit mode:
echo   1. Fork + PR (recommended for most users)
echo   2. Direct push to main (maintainers only)
set /p SUBMIT_TYPE="Enter option (1/2): "

if "%SUBMIT_TYPE%"=="2" (
    echo.
    echo [WARN] You chose direct push. Make sure you are a maintainer.
    set /p CONFIRM="Continue? (y/n): "
    if /i not "!CONFIRM!"=="y" (
        echo [CANCEL] Operation cancelled.
        pause
        exit /b 0
    )
    set PUSH_TARGET=origin
    goto DO_COMMIT
)

REM Default: Fork + PR flow
REM Check upstream
git remote get-url upstream >nul 2>&1
if errorlevel 1 (
    echo.
    echo [TIP] Upstream not configured. Auto-configuring...
    git remote add upstream https://github.com/dev-change/Embedded-Main.git
    if errorlevel 1 (
        echo [ERROR] Failed to add upstream. Please run manually:
        echo   git remote add upstream https://github.com/dev-change/Embedded-Main.git
        pause
        exit /b 1
    )
    echo [OK] Upstream configured.
)

REM Sync upstream
echo.
echo [Step 1/5] Syncing with upstream...
git fetch upstream
if errorlevel 1 (
    echo [ERROR] Failed to fetch upstream. Check network.
    pause
    exit /b 1
)

REM Check if behind
git merge-base --is-ancestor upstream/main HEAD
if errorlevel 1 (
    echo [WARN] Your branch is behind upstream. Sync recommended:
    echo   git pull upstream main
    set /p SYNC="Auto sync now? (y/n): "
    if /i "!SYNC!"=="y" (
        git pull upstream main
        if errorlevel 1 (
            echo [ERROR] Sync failed. Conflict may exist. Resolve manually.
            pause
            exit /b 1
        )
        echo [OK] Sync complete.
    )
)

:DO_COMMIT
REM Ask for commit message
echo.
echo [Step 2/5] Enter commit message (brief description):
set /p COMMIT_MSG="Message: "

if "%COMMIT_MSG%"=="" (
    echo [ERROR] Commit message cannot be empty.
    pause
    exit /b 1
)

REM Add files
echo.
echo [Step 3/5] Adding files...
git add -A
if errorlevel 1 (
    echo [ERROR] Failed to add files.
    pause
    exit /b 1
)
echo [OK] Files staged.

REM Commit
echo.
echo [Step 4/5] Creating commit...
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
    echo [ERROR] Commit failed. Check for conflicts.
    pause
    exit /b 1
)
echo [OK] Commit created.

REM Push
if "%SUBMIT_TYPE%"=="2" (
    echo.
    echo [Step 5/5] Pushing to main...
    git push origin main
    if errorlevel 1 (
        echo [ERROR] Push failed.
        echo [HINT] Possible reasons:
        echo   1. Branch is protected, use PR instead
        echo   2. Remote has new commits, pull first
        echo   3. Network issue
        pause
        exit /b 1
    )
    echo [OK] Pushed to main!
) else (
    echo.
    echo [Step 5/5] Pushing to your Fork...
    git push origin %CURRENT_BRANCH%
    if errorlevel 1 (
        echo [ERROR] Push failed.
        echo [HINT] Possible reasons:
        echo   1. SSH/HTTPS auth not configured
        echo   2. Network issue
        echo   3. Need to Fork the repo first
        pause
        exit /b 1
    )
    echo [OK] Pushed to your Fork!
    echo.
    echo ==========================================
    echo   Next: Create Pull Request
echo ==========================================
    echo.
    echo Visit this link to create PR:
    echo   https://github.com/dev-change/Embedded-Main/compare
    echo.
    echo Or run: start https://github.com/dev-change/Embedded-Main/compare
)

echo.
echo ==========================================
echo   Done!
echo ==========================================
pause
