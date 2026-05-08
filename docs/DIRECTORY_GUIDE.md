# 目录结构规范

> 本文档定义资料仓库的目录组织规则，所有贡献者请遵守。

---

## 一、内容优先级

仓库内容按以下优先级组织，重要性由高到低：

| 优先级 | 类别 | 路径 | 说明 |
|:------:|------|------|------|
| 1 | 手册与文档 | `docs/handbooks/` | 工具链配置、环境搭建、学习路线等指导性文档 |
| 2 | 八股与面经 | `docs/interview/` | 面试题、知识点整理、八股文 |
| 3 | 单片机项目 | `projects/mcu/` | STM32/电赛 等嵌入式项目源码与文档 |
| 4 | Linux 项目 | `projects/linux/` | Linux 驱动、应用、网络编程项目 |
| 5 | 学习资料 | `learning/` | 教程笔记、视频配套、书籍摘录 |
| 6 | 学校课程 | `courses/` | 课程作业、实验报告、复习资料、往年试题 |

**原则**：高优先级内容要求更高的质量和维护投入。

---

## 二、命名规范

### 2.1 文件夹命名

```
# 推荐（清晰、无空格、无特殊字符）
stm32-balancing-control/
embedded-interview-2026/
数字电路-复习资料/
2026-电赛-平衡球控制系统/

# 不推荐
STM32 Balancing Control/      # 含空格
embedded interview!!!/        # 含特殊字符
资料/                         # 过于笼统
```

### 2.2 文件命名

```
# 推荐
stm32-timer-interrupt-guide.md
2025-秋-数字电路-期末试卷.pdf
README.md                     # 每个项目/目录下应有 README

# 不推荐
新建文本文档.txt
document (1).pdf
```

### 2.3 版本标注

对于可能更新的文档，可在文件名或内容中标注版本/日期：

```
stm32-clock-tree-v1.2.md
linux-process-scheduling-2026-05.md
```

---

## 三、各目录详细规范

### 3.1 `docs/handbooks/` — 手册与文档

存放面向全体成员的**指导性文档**，质量要求最高。

内容示例：
- Git 使用指南（本仓库专用版）
- STM32 开发环境搭建（Keil / VS Code + PlatformIO）
- Linux 开发环境配置（WSL / VM / 双系统）
- 实验室设备使用手册
- 学习路线推荐（嵌入式方向、Linux 方向）

格式要求：
- 必须为 Markdown
- 包含目录（TOC）
- 步骤类文档要配图说明

### 3.2 `docs/interview/` — 八股与面经

按技术方向细分为子目录。

每个子目录下的文档示例：
- `stm32-basics.md` — GPIO、时钟、中断、DMA 等基础八股
- `freertos.md` — 任务调度、同步机制、内存管理
- `process-thread.md` — 进程与线程区别、通信方式、调度算法
- `driver-model.md` — Linux 设备模型、platform 总线、设备树

格式要求：
- Markdown 为主
- 题目建议用引用块（`>`）突出
- 答案要简洁准确，不确定的标注"待确认"

### 3.3 `projects/mcu/` — 单片机项目

每个项目一个子文件夹，内部结构：

```
projects/mcu/2026-电赛-平衡球/
├── README.md              # 项目说明：功能、硬件、软件架构
├── src/                   # 源码（Keil 工程或 VS Code 工程）
├── docs/                  # 项目文档：设计思路、调试记录
├── assets/                # 图片、视频等
└── （可选）report.md      # 比赛报告/文档
```

### 3.4 `projects/linux/` — Linux 项目

结构类似单片机项目：

```
projects/linux/char-driver-demo/
├── README.md
├── src/                   # 源码
│   ├── Makefile
│   └── *.c / *.h
├── docs/
└── assets/
```

### 3.5 `learning/` — 学习资料

按学习资源来源组织：

```
learning/stm32/
├── 正点原子-库函数教程/
│   ├── 笔记/
│   ├── 课后习题/
│   └── README.md          # 说明对应视频/书籍章节
│
├── 江科大-标准库/
└── README.md              # 汇总：各教程特点对比
```

允许存放 PDF（官方手册、教材扫描件等），但需标注版权信息。

### 3.6 `courses/` — 学校课程

按课程名称组织：

```
courses/数字电路/
├── 课件/                  # 老师下发的 PDF/PPT（如有版权风险请谨慎）
├── 笔记/
├── 实验报告/              # 模板 + 范例
├── 往年试题/
└── README.md              # 课程信息：老师、教材、考试形式
```

---

## 四、公共资源 `assets/`

### 4.1 `assets/images/`

全仓库共用的图片资源，如 Logo、公共示意图等。

各目录下也可自建 `images/` 子目录存放专属图片。

### 4.2 `assets/templates/`

文档模板：
- `project-README.md` — 项目 README 模板
- `interview-question.md` — 八股文档模板
- `experiment-report.md` — 实验报告模板

### 4.3 `assets/scripts/`

辅助脚本：
- 批量重命名
- Markdown 格式检查
- 仓库统计等

---

## 五、禁止存放的内容

❌ **个人敏感信息**：学号、身份证号、手机号、密码等  
❌ **大体积二进制文件**：> 10MB 的视频、安装包、编译产物  
❌ **版权不明的内容**：未经授权的书籍扫描件、付费课程资料  
❌ **临时/编译产物**：`*.o`、`*.exe`、`build/`、`node_modules/` 等  
❌ **个人笔记草稿**：整理完成后再提交

---

## 六、目录变更流程

如需调整目录结构（新增大类、合并子目录等）：

1. 在本地创建 `reorg/调整目录结构` 分支
2. 执行调整，确保所有内部链接同步更新
3. 在 `README.md` 和本文件中同步更新目录说明
4. 通过 squash merge 提交到 `main`
5. 在群里通知大家目录变更

---

*最后更新：2026-05-07*
