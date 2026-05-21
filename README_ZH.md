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
  两个技能。零依赖。一条命令记住一切。</em>
</p>

<br>

## 为什么

AI 最大的隐性成本不是 GPU，是 **重复思考** — 每次重新排查一个已经解决过的问题，烧的都是 token 和时间。

| 场景 | 以前 | 现在 |
|---|---|---|
| 同一个错反复出现 | 重排 10+ 轮对话 | `/gotcha <关键词>` — 秒定位 |
| 没人反问你选的方案 | 上线后发现盲区 | `/flip` — 发布前发现 |
| 同样的坑踩第三次 | 每次从零开始 | 3 秒查到 |
| 总觉得哪里不对又说不上来 | 犹豫、算了、上线 | 一条命令系统性审视 |

> **每次命中，省掉 90%+ 的重复排查 token。**

<br>

## 安装

```bash
/plugin marketplace add michea11/dejavu    # 一次
/plugin install dejavu@michea11-dejavu     # 完成
```

两个命令就位。

<br>

## 用法

```bash
# ── gotcha: 踩坑记忆 ──

/gotcha save
# → 回溯最近一次排查，提取症状 + 原因 + 解法
# → 生成草稿，你确认即存到 .claude/gotchas/

/gotcha CI killed
# → grep 毫秒级搜索你的 gotcha 库
# → 命中一个 → 直接注入。命中多个 → 你选

/gotcha                    # → 列出全部，时间倒序
/gotcha fix <slug>         # → 标记已修复（保留记录）
/gotcha delete <slug>      # → 删除（先确认）
```

```bash
# ── flip: 换角度审视 ──

/flip
# → "我们还没从什么角度看？" → 用缺席的视角审视

/flip "用 redis 做缓存"
# → 对指定结论做换角度审视
```

<br>

## 特点

- **零依赖** — grep + 文件系统，不用 embedding、不用向量库、不用外部 API
- **不命中零 token 开销** — 不预注入索引，不后台静默匹配，只在调用时检索
- **跨平台** — 同一个 SKILL.md，Claude Code / Codex / Cursor / Copilot / Windsurf / Gemini CLI 都能用
- **不打扰** — 存不存你说了算，会话结束提示一句
- **纯 Markdown 存储** — gotcha 就是 `.md` 文件，可读可编辑可 git 追踪

<br>

## 跨平台

| 工具 | 技能目录 |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

克隆即可 — 你的工具自动加载对应目录。

<br>

## 设计

- **不主动消耗你的 token** — 只在调用时检索
- **不打断你的心流** — 存不存你来定
- **没有魔法** — grep + 文件系统，可理解、可调试、零成本
- **决定权在你** — 提供经验、提供视角，结论永远你定
