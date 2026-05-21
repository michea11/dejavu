<p align="center">
  <a href="#中文"><img src="https://img.shields.io/badge/中文-red?style=for-the-badge" alt="中文"></a>
  <a href="#english"><img src="https://img.shields.io/badge/English-blue?style=for-the-badge" alt="English"></a>
</p>

---

# 中文

# déjà vu

> 你已经踩过的坑，不应该再花 token 重新排一遍。
> 你已经做的决策，不应该只有一个角度看。

**déjà vu** 是一个 Claude Code 插件，包含两个零依赖的技能，专门解决 AI 编码中"重复浪费"的问题。

---

## 为什么值得用

AI 编码最大的隐性成本不是 GPU，是 **重复思考**。

| 场景 | 现状 | 用 déjà vu 后 |
|---|---|---|
| CI 报了上次一样的错 | 重新排查 10 轮对话 | `/gotcha CI killed` → 直接拿到解法 |
| 设计选了方案 A，没人反问 | 上线后发现盲区 | `/flip` → 换个角度看出问题 |
| 一个坑踩了第三次 | 每次从头来 | 查 gotcha → 3 秒定位 |
| 快敲定方案时总觉得不安 | 凭直觉犹豫 | `/flip` → 系统性审视 |

**每一次命中，节省的不是几毛钱 token，是几十轮排查对话的时间和心流。**

---

## 两个技能

### gotcha — 踩坑记忆

```
排查中 → /gotcha save → 存成经验 → 下次 /gotcha <关键词> → 直接命中
```

- grep 检索，零依赖，毫秒级
- 不注入索引，不命中零 token 开销
- 会话结束弱提醒，不骚扰

### flip — 换角度审视

```
快下结论了 → /flip → 找到缺席的视角 → 发现盲区 → 趁早修正
```

- 不机械站对立面，动态选最可能发现问题的角度
- 成本、时间、新人、极端、放大…什么缺席看什么
- 关键决策时主动建议，平时不打扰

---

## 跨平台支持

同一个 SKILL.md，所有主流 AI 编码工具都能用：

| 工具 | 技能目录 |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

克隆仓库后，你的工具会自动加载对应目录的技能。Claude Code 版本保留完整功能，其他平台仅去掉平台专属字段。

---

## 安装

```bash
# 添加自托管市场（只需一次）
/plugin marketplace add michea11/dejavu

# 安装插件
/plugin install dejavu@michea11-dejavu
```

---

## 用法

```bash
# gotcha —— 踩坑记忆，grep + 文件系统，零依赖

/gotcha save              # 把最近一次排查过程存成 experience
/gotcha <关键词>           # 搜索匹配的 experience，命中则注入完整内容
/gotcha                    # 列出所有 experience，按时间倒序
/gotcha fix <slug>         # 标记已修复（不删除，下次匹配时提示）
/gotcha delete <slug>      # 删除指定 experience（会先确认）

# flip —— 换角度审视，纯过程技能，不读写文件

/flip                      # 对当前讨论的最新结论，找个缺席的视角审视
/flip "用 redis 做缓存"     # 对指定结论做审视
```

---

## 设计哲学

- **不主动消耗你的 token** — 不预注入索引，不静默后台匹配，只在调用时检索
- **不依赖外部服务** — grep + 文件系统，没有 embedding API、没有向量数据库
- **不打断你的心流** — 存不存你说了算，只在会话结束弱提醒一句
- **不替你做决定** — 只提供经验和视角，结论永远在你

---

<br>
<br>

# English

# déjà vu

> You shouldn't have to re-debug the same problem.
> You shouldn't make decisions from only one angle.

**déjà vu** is a Claude Code plugin with two zero-dependency skills purpose-built to eliminate wasteful re-thinking in AI-assisted coding.

---

## Why It Matters

The biggest hidden cost of AI coding isn't GPU — it's **re-thinking things you already figured out**.

| Scenario | Without déjà vu | With déjà vu |
|---|---|---|
| CI fails with last week's error | 10 rounds of debugging from scratch | `/gotcha CI killed` → instant fix |
| You pick option A, nobody pushes back | Find the blind spot in production | `/flip` → catch it before you ship |
| Third time hitting the same pitfall | Start over every time | Search gotcha → 3-second lookup |
| Gut says something's off about this decision | Hesitate, move on anyway | `/flip` → systematic review |

**Every hit saves not just tokens, but flow state and hours of conversation.**

---

## Two Skills

### gotcha — Troubleshooting Memory

```
Hit a bug → /gotcha save → store the fix → /gotcha <keyword> → instant recall
```

- grep-powered search, zero dependencies, millisecond response
- No index pre-injection — zero token cost on miss
- Gentle session-end reminder, never interrupts

### flip — Perspective Shift

```
About to lock in a decision → /flip → find the missing angle → catch blind spots early
```

- Never defaults to just "the opposite" — finds whatever perspective is absent
- Cost, time, newcomer, extreme, scale — whatever angle is missing
- Proactive hints at key decision points, quiet otherwise

---

## Cross-Platform

Same `SKILL.md` works across all major AI coding tools:

| Tool | Skill Directory |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

Clone once, your tool picks up the right directory. Claude Code gets the full-featured version, other platforms get the universal subset.

---

## Install

```bash
# Add self-hosted marketplace (once)
/plugin marketplace add michea11/dejavu

# Install the plugin
/plugin install dejavu@michea11-dejavu
```

---

## Usage

```bash
# gotcha — troubleshooting memory, grep + filesystem, zero deps

/gotcha save              # Save the most recent debugging session as a gotcha
/gotcha <keyword>         # Search matched gotchas, inject full content on hit
/gotcha                    # List all gotchas, newest first
/gotcha fix <slug>         # Mark as fixed (keeps record, annotates on future match)
/gotcha delete <slug>      # Delete a gotcha (confirms first)

# flip — perspective shift, pure process skill, no file I/O

/flip                      # Examine the latest conclusion from a missing angle
/flip "use redis for caching"  # Examine a specific conclusion
```

---

## Design Philosophy

- **Don't burn your tokens** — No index pre-injection, no silent background matching, search only on demand
- **No external dependencies** — grep + filesystem, no embedding APIs, no vector databases
- **Don't break your flow** — You decide what to save, one gentle reminder at session end
- **You make the call** — We surface experience and perspective, the conclusion is always yours
