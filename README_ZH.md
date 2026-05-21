<p align="center">
  <a href="README.md">English</a> |
  <a href="README_ZH.md">简体中文</a> |
  <a href="README_ZH-HANT.md">繁體中文</a> |
  <a href="README_JA.md">日本語</a> |
  <a href="README_KO.md">한국어</a> |
  <a href="README_ES.md">Español</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="License">
  <img src="https://img.shields.io/badge/platform-Claude%20Code%20%7C%20Codex%20%7C%20Cursor%20%7C%20Copilot%20%7C%20Gemini-blue" alt="Platform">
  <img src="https://img.shields.io/badge/skills-gotcha%20%2B%20flip-orange" alt="Skills">
</p>

<br>

# déjà vu

<p align="center">
  <em>踩过的坑，不要重排查。做过的决策，不要只看一面。<br>
  两个技能。零依赖。把 AI 编码中最浪费 token 的事 —— 重复思考 —— 彻底干掉。</em>
</p>

<br>

## 为什么需要 déjà vu

AI 编码时，最大的隐性成本不是 GPU，不是 API 费用，是**重复思考**。

**同一个错，排查一次、两次、三次。** 每次 AI 都要重新读代码、重新分析、重新推演。这个过程烧掉的 token，比修 bug 本身多得多。

**同一个决策，永远从你给的角度看。** AI 不会主动说"这个方案可能有个盲区你没注意到"。它擅长执行，但不擅长质疑。

déjà vu 做两件事：
- **gotcha** — 让你排查过一次的坑，下次直接查结果，不用重来
- **flip** — 让你做决策时，AI 主动换个缺席的角度帮你审视

两个技能互补：gotcha 省掉**重复劳动**的 token，flip 防止**错误决策**的返工。

---

## 安装

```bash
/plugin marketplace add michea11/dejavu    # 添加市场，只需一次
/plugin install dejavu@michea11-dejavu     # 安装插件
```

安装后就有 `/gotcha` 和 `/flip` 两个命令。

---

## gotcha — 踩坑记忆

### 它解决什么问题

你排查了一个 CI 报错，花 10 轮对话找到原因——是 Docker base image 锁了旧 SHA。下周同一个错又来了，AI 从头查起，又花 10 轮。**你付了两遍 token，买的是同一个答案。**

gotcha 让这种事只发生一次。

### 怎么用

```bash
# 修完一个坑后，存下来
/gotcha save
# → AI 回溯你刚才的排查过程
# → 自动提取：症状是什么、根因是什么、怎么修的
# → 生成草稿，你确认就保存

# 下次遇到，直接查
/gotcha CI killed
# → grep 毫秒级搜索你的 gotcha 库
# → 命中一个 → 直接注入完整内容，跳过排查
# → 命中多个 → 列出标题让你选

# 管理你的 gotcha 库
/gotcha                    # 列出全部，按时间倒序
/gotcha fix <slug>         # 标记已修复（保留记录，下次匹配会提示）
/gotcha delete <slug>      # 删除（会先确认）
```

### 怎么存的

每个 gotcha 就是一个 Markdown 文件，存在 `.claude/gotchas/` 下：

```markdown
---
tags: [CI, OOM, GitHub-Actions]
created: "2026-05-21"
fixed: false
---

# 症状
CI 报 killed 但本地正常

# 原因
GitHub Actions runner 只有 7GB 内存

# 解法
NODE_OPTIONS=--max-old-space-size=4096
```

可读、可编辑、可 git 追踪。没有任何黑盒。

### 设计原则

- **不命中不烧 token** — 没有索引预注入，没有后台静默匹配。只有在调用 `/gotcha` 时才做 grep 检索
- **不打扰你** — 存不存你说了算。会话结束时弱提醒一句"今天有没有忘了记的坑？"
- **可配置** — 主动提示程度、会话结束提醒、重复检测严格度，都可通过参数调整

---

## flip — 换角度审视

### 它解决什么问题

你和 AI 讨论方案，决定了用 Redis 做缓存。整个过程你们都在"怎么做 Redis 缓存"的框架里思考。没人问"不做缓存行不行？"、"单个大对象会不会把 Redis 打爆？" **这些盲区，上线后才发现。**

flip 让你在下结论前，刻意换个缺席的视角再看一眼。

### 怎么用

```bash
# 对当前讨论的最新结论，换个角度审视
/flip
# → AI 判断：刚才的讨论中什么视角缺席了？
# → 从那个缺席的角度重新审视结论
# → 有盲区 → 建议修正。没盲区 → 确认成立

# 对指定结论做审视
/flip "用 Redis 做缓存"
```

### 从什么角度看

flip 不机械站对立面。它动态判断**当前讨论中缺了什么**：

| 角度 | 问法 |
|---|---|
| 对立面 | "不做会怎样？" |
| 成本 | "这要多花多少时间/钱？值得吗？" |
| 简化 | "能不能不做？能不能做更少？" |
| 时间 | "三个月后回头看，最后悔的可能是什么？" |
| 新人 | "不了解上下文的人看到这个，会疑惑什么？" |
| 极端 | "用户完全不按预期用时，哪里会崩？" |
| 放大 | "如果要撑 10 倍量，哪里先垮？" |

每次只选**一个**最可能发现盲区的角度，不堆砌。

### 设计原则

- **不是辩论，是审视** — 换完角度看没问题，就说没问题。不为反对而反对
- **不是头脑风暴** — 头脑风暴是探索可能性，flip 是审视已有结论。两者互补，不替代
- **不替你做决定** — 只提供视角和发现，结论永远在你
- **可配置** — 主动提示程度可调：关 / 只在关键决策时 / 每次下结论都追问

---

## 跨平台支持

同一个 `SKILL.md`，一套代码，六个平台：

| 工具 | 技能目录 | 版本 |
|---|---|---|
| Claude Code | `.claude/skills/` | 完整版（含 allowed-tools、argument-hint） |
| OpenAI Codex CLI | `.agents/skills/` | 平台中立版 |
| Cursor | `.cursor/skills/` | 平台中立版 |
| GitHub Copilot | `.github/skills/` | 平台中立版 |
| Windsurf | `.windsurf/skills/` | 平台中立版 |
| Gemini CLI | `.gemini/skills/` | 平台中立版 |

克隆仓库到你用到的工具目录下即可。修改 skill 内容时，运行 `scripts/sync-skills.sh` 一键同步到所有平台。

---

## 为什么选 déjà vu

| | 现有方案 | déjà vu |
|---|---|---|
| 存经验 | 手动写 CLAUDE.md / .cursorrules，人会忘会懒 | 一条命令，AI 自动提取，你确认 |
| 查经验 | grep 自己搜、翻聊天记录、重新问 AI | `/gotcha <关键词>`，毫秒命中 |
| 决策审视 | 靠经验、靠直觉、靠 code review | `/flip`，系统性地换角度 |
| Token 开销 | rules 文件全量加载，不用也烧 | 零预注入，不调不烧 |
| 依赖 | embedding API、向量数据库 | grep + 文件系统，零外部依赖 |

---

## 设计哲学

- **不主动消耗你的 token** — 只在调用时检索，没有预注入、没有后台匹配
- **不依赖外部服务** — grep + 文件系统。可理解，可调试，零依赖
- **不打断你的心流** — 存不存你说了算，一条弱提醒，不追问
- **不替你做决定** — 提供经验和视角，结论永远在你手上
