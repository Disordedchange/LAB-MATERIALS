# Lab Materials 资料仓库

> 面向嵌入式、Linux 方向的实验室公共资料库。
> 包含面经八股、项目资料、学习笔记、学校课程资料等。

---

## 快速开始

### 克隆仓库

```bash
git clone git@github.com:Disordedchange/LAB-MATERIALS.git
```

> 如果 IP 变动，请联系管理员获取最新地址。

### 第一次使用？

1. 阅读 [CONTRIBUTING.md](./CONTRIBUTING.md) — 了解如何正确提交资料
2. 阅读 [本手册的"目录结构"部分](#目录结构) — 知道东西该放哪
3. 开始查阅或贡献资料！

---

## 仓库内容概览

| 分类 | 路径 | 说明 |
|------|------|------|
| 📖 手册文档 | `docs/handbooks/` | 学习路线、工具链配置、环境搭建指南 |
| 📝 八股面经 | `docs/interview/` | 嵌入式/Linux/数据结构/操作系统等面试题整理 |
| 🔧 单片机项目 | `projects/mcu/` | STM32/电赛项目等源码与说明 |
| 🐧 Linux 项目 | `projects/linux/` | Linux 驱动/应用/网络编程项目 |
| 📚 学习资料 | `learning/` | 教程笔记、视频配套资料、书籍摘录 |
| 🏫 学校课程 | `courses/` | 课程作业、实验报告、复习资料、往年试题 |

---

## 目录结构

```
lab-materials/
├── README.md                 # 本文件：仓库总览与使用指南
├── CONTRIBUTING.md           # 贡献指南：如何提交资料
├── ADMIN.md                  # 管理手册：维护人员参考
├── connection-info.md        # 连接信息（IP、用户名等）
│
├── docs/                     # 文档类资料（优先级最高）
│   ├── handbooks/            # 手册与指南
│   │   ├── git-usage.md
│   │   ├── stm32-env-setup.md
│   │   ├── linux-dev-env.md
│   │   └── ...
│   │
│   └── interview/            # 八股与面经
│       ├── embedded/         # 嵌入式八股
│       │   ├── stm32-basics.md
│       │   ├── freertos.md
│       │   └── ...
│       ├── linux/            # Linux 八股
│       │   ├── process-thread.md
│       │   ├── driver-model.md
│       │   └── ...
│       ├── os-network/       # 操作系统与网络
│       ├── data-structure/   # 数据结构
│       └── algorithm/        # 算法
│
├── projects/                 # 项目源码与资料
│   ├── mcu/                  # 单片机项目
│   │   ├── 2026-电赛-平衡球/  # 示例：年份+赛事/主题命名
│   │   ├── stm32-balancing/
│   │   ├── hal-lib-examples/
│   │   └── ...
│   │
│   └── linux/                # Linux 项目
│       ├── char-driver-demo/
│       ├── socket-chat/
│       └── ...
│
├── learning/                 # 学习资料与笔记
│   ├── stm32/                # 单片机学习
│   │   ├── 正点原子-库函数/
│   │   ├── 江科大-标准库/
│   │   └── ...
│   │
│   ├── linux/                # Linux 学习
│   │   ├── 鸟哥私房菜-笔记/
│   │   ├── 宋宝华-驱动开发/
│   │   └── ...
│   │
│   └── programming/          # 通用编程
│       ├── c-pointers/
│       ├── makefile/
│       └── ...
│
├── courses/                  # 学校课程资料
│   ├── 数字电路/
│   ├── 模拟电路/
│   ├── 微机原理/
│   ├── 操作系统/
│   ├── 计算机网络/
│   └── ...
│
└── assets/                   # 公共资源
    ├── images/               # 图片资源
    ├── templates/            # 文档模板
    └── scripts/              # 辅助脚本
```

---

## 使用场景

### 查找资料

```bash
# 按目录浏览
cd docs/interview/embedded/

# 或用搜索（Git Bash / Linux / WSL）
grep -r "DMA" docs/interview/embedded/
grep -r "进程调度" docs/interview/linux/
```

### 提交新资料

详见 [CONTRIBUTING.md](./CONTRIBUTING.md)。简要流程：

```bash
git checkout main
git pull origin main
git checkout -b docs/你的资料主题
# ... 编辑文件 ...
git add .
git commit -m "docs: 新增 xxx"
git checkout main
git merge --squash docs/你的资料主题
git commit -m "docs: 新增 xxx"
git push origin main
```

### 更新已有资料

直接修改文件后，按上述流程 squash merge 提交即可。Markdown 的 diff 很清晰，大家能看到具体改了什么。

---

## 文档格式说明

### 为什么用 Markdown？

- ✅ Git 原生支持，版本历史清晰可追溯
- ✅ 纯文本，轻量、跨平台、不挑编辑器
- ✅ VS Code、Typora、Obsidian 都支持，预览美观
- ❌ Word/PDF 是二进制格式，Git 无法追踪变更，仓库体积会膨胀

### 如果你只有 Word/PDF

- **课件类 PDF**（老师下发、官方手册）：可以直接放入仓库，文件名标注清楚即可
- **笔记类 Word**：强烈建议整理为 Markdown。Typora 可以直接粘贴 Word 内容并导出 Markdown

### Markdown 快速参考

```markdown
# 一级标题
## 二级标题
**粗体**，*斜体*，`代码`

- 无序列表
- 无序列表

1. 有序列表
2. 有序列表

[链接文字](https://example.com)
![图片描述](./assets/images/xxx.png)

```c
// 代码块
int main() { return 0; }


> 引用块

| 表格 | 表头 |
|------|------|
| 内容 | 内容 |
```

---

## 仓库维护

- **管理员**：见 [ADMIN.md](./ADMIN.md)
- **服务运行环境**：台式机（Windows + OpenSSH + Git Bare）
- **备份策略**：每周自动打包备份到 `D:\GitRepos\backups\`
- **IP 地址**：`192.168.1.114`（实验室内网），如变动请关注通知

---

## 注意事项

1. **台式机需保持开机** 队友才能访问
2. **校园网内访问**：确保你的电脑与台式机在同一局域网
3. **IP 变动**：若台式机 IP 变化，需更新 remote URL：
   ```bash
   git remote set-url origin ssh://Administrator@新IP/D:/GitRepos/lab-materials.git
   ```
4. **资料版权**：上传资料请确保不侵犯版权，引用外部内容请标注来源

---

*本仓库由实验室团队共同维护，欢迎每一位同学贡献优质资料。*

*最后更新：2026-05-08*
