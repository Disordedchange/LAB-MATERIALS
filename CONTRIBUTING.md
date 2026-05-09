# 贡献指南

> 本文档面向所有向本仓库提交资料的同学。流程很简单，看一遍就会。

---

## 核心流程（Fork → PR）

```
Fork 仓库 → 克隆到本地 → 创建分支 → 修改/新增 → 提交 → Push → 提 PR
```

---

## 第一次提交

### Step 1：Fork 仓库

打开 https://github.com/dev-change/Embedded-Materials，点右上角 **Fork** 按钮。

这会创建一个属于你自己的副本（在你的 GitHub 账号下）。

### Step 2：克隆你 Fork 的仓库

```bash
git clone https://github.com/你的用户名/Embedded-Materials.git
cd Embedded-Materials
```

### Step 3：配置上游仓库（只需一次）

```bash
git remote add upstream https://github.com/dev-change/Embedded-Materials.git
```

这样你可以随时同步主仓库的最新内容。

---

## 日常提交

### Step 1：同步主仓库

每次开始前，先拉取主仓库的最新内容：

```bash
git checkout main
git pull upstream main
git push origin main
```

### Step 2：创建临时分支

```bash
git checkout -b add/你提交的内容简介
```

分支命名示例：
- `add/stm32-timer-note`
- `fix/linux-driver-typo`
- `docs/add-interview-questions`

### Step 3：修改文件

按 README 里的目录结构，把文件放到正确位置。

### Step 4：提交

```bash
git add .
git commit -m "add: 新增 STM32 定时器中断笔记"
```

Commit message 格式：
- `add:` 新增资料
- `fix:` 修正错误
- `docs:` 文档修改

### Step 5：推送到你的 Fork

```bash
git push origin add/你提交的内容简介
```

### Step 6：提 Pull Request

1. 打开 https://github.com/dev-change/Embedded-Materials
2. 你会看到提示 "Compare & pull request"，点击它
3. 填写 PR 标题和描述（说明提交了什么、为什么）
4. 点 **Create pull request**

维护人会 review，没问题就合并。

---

## 用 GitHub Desktop（更简单）

如果你不想记命令：

1. 下载安装 [GitHub Desktop](https://desktop.github.com/)
2. File → Clone repository → URL 填 `https://github.com/你的用户名/LAB-MATERIALS`
3. 改文件 → Desktop 自动检测到变化
4. 填 summary → Commit to main
5. Push origin
6. 打开浏览器提 PR

更详细的图文步骤：https://docs.github.com/cn/desktop/contributing-and-collaborating-using-github-desktop

---

## 资料规范

### 文件格式

| 优先级 | 格式 | 说明 |
|--------|------|------|
| ⭐ 首选 | `.md` | Markdown，Git 友好、diff 清晰 |
| 可选 | `.pdf` | 老师下发的课件、官方手册 |
| 可选 | 代码文件夹 | 需附带 README.md 说明 |

**不要提交 Word（.doc/.docx）**。内容请整理为 Markdown，Typora 可以直接粘贴 Word 并导出 Markdown。

### 文件存放位置

- 放在正确的分类目录下（见 README 的目录结构）
- 文件名用中文或英文，避免特殊字符
- 同一主题的资料放在同一文件夹内

### 图片

```markdown
![说明文字](./images/示意图.png)
```

- 图片统一放 `assets/images/` 或当前文档同目录的 `images/`
- 单张建议 < 1MB
- 优先 `.png` 或 `.jpg`

---

## 常见问题

### Q：我 Fork 的仓库和主仓库不同步了？

A：
```bash
git checkout main
git pull upstream main
git push origin main
```

### Q：PR 被拒绝了怎么办？

A：根据维护人的反馈修改，改完 push 到同一个分支，PR 会自动更新。

### Q：只想改几个字，不想 Fork？

A：可以直接在 GitHub 网页上编辑文件，它会自动帮你 Fork 并提 PR。

---

*最后更新：2026-05-09*
