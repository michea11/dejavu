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
  <em>Stop re-debugging the same bug. Stop re-thinking the same decision.<br>
  Two skills. Zero dependencies. One command to remember everything.</em>
</p>

<br>

## Why

Every time your AI re-investigates a problem you already solved, you're burning **tokens, time, and flow state** — not GPU, but thinking.

| Problem | Before | After déjà vu |
|---|---|---|
| Same error keeps coming back | 10+ rounds of debugging | `/gotcha <keyword>` — instant hit |
| Nobody questions the design choice | Blind spot found in production | `/flip` — caught before you ship |
| Hitting the same pitfall again | Start from zero every time | 3-second lookup |
| Gut says something's off | Hesitate, ship anyway | Systematic review in one command |

> **Every hit saves 90%+ of the tokens you'd spend re-investigating from scratch.**

<br>

## Install

```bash
/plugin marketplace add michea11/dejavu    # once
/plugin install dejavu@michea11-dejavu     # done
```

That's it. Two slash commands ready.

<br>

## Usage

```bash
# ── gotcha: troubleshooting memory ──

/gotcha save
# → scans the last debugging session, extracts symptom + root cause + fix
# → presents a draft, you confirm → saved to .claude/gotchas/

/gotcha CI killed
# → grep-searches your gotcha library in milliseconds
# → single hit → injects the full gotcha. multiple hits → you pick.

/gotcha                    # → lists all gotchas, newest first
/gotcha fix <slug>         # → marks as fixed (keeps the record)
/gotcha delete <slug>      # → removes (asks first)
```

```bash
# ── flip: perspective shift ──

/flip
# → "What angle are we missing?" → examines from that angle

/flip "use redis for caching"
# → examines a specific conclusion from a missing perspective
```

<br>

## Features

- **Zero dependencies** — grep + filesystem. No embeddings, no vector DB, no external API
- **Zero token cost on miss** — no index pre-injection, no background matching, search only when you ask
- **Cross-platform** — same SKILL.md works across Claude Code, Codex, Cursor, Copilot, Windsurf, Gemini CLI
- **Non-intrusive** — you decide when to save. One gentle reminder at session end
- **Plain markdown storage** — gotchas are `.md` files in `.claude/gotchas/`. Readable, editable, git-trackable

<br>

## Cross-Platform

| Tool | Skill Directory |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

Clone once — your tool auto-loads the right directory.

<br>

## Design

- **Don't burn your tokens** — On-demand search only
- **Don't break your flow** — You decide. Save, or don't.
- **No magic** — grep + filesystem. Understandable, debuggable, zero cost
- **You're in control** — We surface experience and perspective. The conclusion is yours
