# Gotcha Skill Design Spec

## 概述

**gotcha**: 在排查问题过程中，用户主动保存"踩坑经验"，下次相似问题时快速检索复用，避免重复排查，节省 token。

不依赖外部工具，全部基于 bash（grep）和文件系统。

## 核心流程

```
出错 → 排查修复 → 用户觉得是坑 → /gotcha save → 生成草稿 → 确认保存
                                                              ↓
                                                     .claude/gotchas/*.md
                                                              ↓
下次出错 → /gotcha <关键词> → grep 匹配 → 注入完整 gotcha → 跳过排查
```

## 命令

### /gotcha save
- 模型回溯当前对话中最近一次排查过程，提取三要素：
  - **症状**: 用户最开始报什么错、看到什么异常
  - **原因**: 排查后找到的根因
  - **解法**: 最终怎么解决的
- 三要素压缩为 gotcha 草稿，展示给用户确认 → 写入文件或丢弃

### /gotcha <关键词>
- grep `.claude/gotchas/` 下所有文件
- 单匹配 → 直接注入完整内容
- 多匹配 → 列出匹配标题 + 症状一行，用户选择
- 无匹配 → 提示换词

### /gotcha
- 列出全部 gotcha 标题，按时间倒序

### /gotcha delete <slug|关键词>
- 删除指定 gotcha，需确认

### /gotcha fix <slug>
- 在文件 frontmatter 标记 `fixed: true`
- 下次匹配时标注"已标记修复，可查"

## 存储

```
.claude/gotchas/
  ci-oom-killed.md
  webpack-case-sensitive.md
  docker-login-401.md
```

slug 从标题中取英文关键词，连词符拼接。中文症状则用 `YYYY-MM-DD-NNN.md` 编号。

## 文件格式

```markdown
---
tags: [CI, OOM, node]
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

- frontmatter: `tags`、`created`、`fixed` 三个字段
- body: 症状 / 原因 / 解法三段，h1 分隔，纯口语。其他内容自由追加
- `fixed: true` 表示已修复，匹配时附加提示

## 匹配机制

两段式：

1. **bash grep 预筛** — 从用户关键词 grep 所有 gotcha 文件，零 token
2. **模型确认** — 匹配到的候选（通常 0-3 个）注入上下文，模型判断是否真匹配

无候选 → 零 token 开销。匹配了 → 只注入候选，不全量索引。

## 会话结束兜底

- 会话结束时，模型弱提醒一句："今天有没有踩坑忘了记？有的话 /gotcha save 一下"
- 不列出具体坑（不做静默追踪），不追问，不骚扰
- 主通道是用户主动 `/gotcha save`，兜底只是一个备忘提示

## 可配置项

通过 skill 参数调整，默认值固化在 `settings.json`：

| 参数 | 默认值 | 可选值 |
|---|---|---|
| `hintLevel` | `normal` | `off` 永不主动提示 / `normal` 报错且排查>2轮时提示一次 / `high` 任何报错都提示 |
| `sessionReminder` | `on` | `on` 会话结束时弱提醒 / `off` 不提醒 |
| `dedupCheck` | `normal` | `strict` 只拦完全重复 / `normal` 相似症状就提示 / `off` 不检测 |

使用:
- `/gotcha --hintLevel=off` 临时关闭主动提示
- 不传参数时使用 settings.json 中的默认值

## 边界处理

- `.claude/gotchas/` 目录不存在时，`/gotcha save` 自动创建
- 保存时检测重复：grep 已有 gotcha 的 symptoms 关键词，若高度相似，提示"已有类似 gotcha: xxx，还要保存吗？"

## 实现要点

- 零外部依赖：grep + 文件系统 + bash
- 无索引预注入：只有在用户调用 `/gotcha` 时才做检索
- 无自动匹配：没有后台 grep 或 hook 触发
- Claude 可主动提示"要不要 /gotcha 查一下？"触发条件：用户报错且排查超过 2 轮对话，每会话针对同一问题最多提示一次。只是对话行为，不是系统行为

## 边界

不覆盖：
- 机械步骤模板（属于 recipe skill，后续开发）
- 架构决策记录（属于 decision skill，后续开发）
- 通用知识（gotcha 聚焦项目特有的隐蔽坑）
