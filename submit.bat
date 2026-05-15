@echo off
chcp 936 >nul
setlocal EnableDelayedExpansion

echo ==========================================
echo   Embedded-Main 仓库一键提交脚本
echo ==========================================
echo.

REM 检查是否在 git 仓库中
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
    echo [错误] 当前目录不是 git 仓库，请进入 Embedded-Main 文件夹后运行此脚本。
    pause
    exit /b 1
)

REM 获取仓库信息
for /f "tokens=*" %%a in ('git remote get-url origin 2^>nul') do set REMOTE_URL=%%a
for /f "tokens=*" %%a in ('git branch --show-current') do set CURRENT_BRANCH=%%a

echo [信息] 远程仓库: %REMOTE_URL%
echo [信息] 当前分支: %CURRENT_BRANCH%
echo.

REM 检查是否有未提交的更改
for /f %%a in ('git status --porcelain ^| find /c /v ""') do set CHANGES=%%a
if %CHANGES%==0 (
    echo [提示] 没有检测到更改，无需提交。
    pause
    exit /b 0
)

echo [信息] 检测到 %CHANGES% 个更改文件：
git status --short
echo.

REM 询问提交方式
echo 请选择提交方式：
echo   1. 提交到 Fork 仓库并创建 PR（推荐，适合大多数人）
echo   2. 直接推送到主仓库（仅限维护人）
set /p SUBMIT_TYPE="请输入选项 (1/2): "

if "%SUBMIT_TYPE%"=="2" (
    echo.
    echo [警告] 您选择了直接推送到主仓库，请确认您是维护人。
    set /p CONFIRM="确认继续? (y/n): "
    if /i not "!CONFIRM!"=="y" (
        echo [取消] 操作已取消。
        pause
        exit /b 0
    )
    set PUSH_TARGET=origin
    goto DO_COMMIT
)

REM 默认 Fork + PR 流程
REM 检查是否配置了 upstream
git remote get-url upstream >nul 2>&1
if errorlevel 1 (
    echo.
    echo [提示] 未配置上游仓库，正在自动配置...
    git remote add upstream https://github.com/dev-change/Embedded-Main.git
    if errorlevel 1 (
        echo [错误] 配置上游仓库失败，请手动执行：
        echo   git remote add upstream https://github.com/dev-change/Embedded-Main.git
        pause
        exit /b 1
    )
    echo [成功] 上游仓库已配置。
)

REM 同步上游仓库
echo.
echo [步骤 1/5] 同步上游仓库最新代码...
git fetch upstream
if errorlevel 1 (
    echo [错误] 获取上游更新失败，请检查网络连接。
    pause
    exit /b 1
)

REM 检查是否有冲突
git merge-base --is-ancestor upstream/main HEAD
if errorlevel 1 (
    echo [警告] 您的分支落后于上游，建议先同步：
    echo   git pull upstream main
    set /p SYNC="是否自动同步? (y/n): "
    if /i "!SYNC!"=="y" (
        git pull upstream main
        if errorlevel 1 (
            echo [错误] 同步失败，可能存在冲突，请手动解决。
            pause
            exit /b 1
        )
        echo [成功] 同步完成。
    )
)

:DO_COMMIT
REM 询问 commit message
echo.
echo [步骤 2/5] 请输入提交说明（简要描述本次修改）：
set /p COMMIT_MSG="提交说明: "

if "%COMMIT_MSG%"=="" (
    echo [错误] 提交说明不能为空。
    pause
    exit /b 1
)

REM 添加所有更改
echo.
echo [步骤 3/5] 添加更改文件...
git add -A
if errorlevel 1 (
    echo [错误] 添加文件失败。
    pause
    exit /b 1
)
echo [成功] 文件已添加到暂存区。

REM 提交
echo.
echo [步骤 4/5] 创建提交...
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
    echo [错误] 提交失败，请检查是否有冲突或其他问题。
    pause
    exit /b 1
)
echo [成功] 提交已创建。

REM 推送
if "%SUBMIT_TYPE%"=="2" (
    echo.
    echo [步骤 5/5] 推送到主仓库...
    git push origin main
    if errorlevel 1 (
        echo [错误] 推送失败。
        echo [建议] 可能原因：
        echo   1. 分支受保护，需要通过 PR 合并
        echo   2. 远程有更新，需要先 pull
        echo   3. 网络问题
        pause
        exit /b 1
    )
    echo [成功] 已推送到主仓库！
) else (
    echo.
    echo [步骤 5/5] 推送到您的 Fork...
    git push origin %CURRENT_BRANCH%
    if errorlevel 1 (
        echo [错误] 推送失败。
        echo [建议] 可能原因：
        echo   1. 未配置 SSH/HTTPS 认证
        echo   2. 网络问题
        echo   3. 需要先 Fork 仓库
        pause
        exit /b 1
    )
    echo [成功] 已推送到您的 Fork！
    echo.
    echo ==========================================
    echo   下一步：创建 Pull Request
echo ==========================================
    echo.
    echo 请访问以下链接创建 PR：
    echo   https://github.com/dev-change/Embedded-Main/compare
    echo.
    echo 或者运行以下命令打开浏览器：
    echo   start https://github.com/dev-change/Embedded-Main/compare
)

echo.
echo ==========================================
echo   提交完成！
echo ==========================================
pause
