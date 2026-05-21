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
  Two skills. Zero dependencies. Eliminate the biggest hidden cost of AI coding.</em>
</p>

<br>

## Why déjà vu

The biggest hidden cost in AI coding isn't GPU hours or API bills — it's **re-thinking**.

**Same error, debugged three times.** Each time, the AI re-reads the code, re-analyzes the stack trace, re-derives the fix. The tokens burned on re-investigation dwarf the cost of the actual fix.

**Same decision, one perspective.** The AI is great at execution, not at saying "hey, what about the angle we're not seeing?" Nobody challenges the assumption until it breaks in production.

déjà vu does two things:
- **gotcha** — record debugging sessions, recall them instantly next time. No re-investigation.
- **flip** — before locking in a decision, examine it from a perspective nobody considered.

Two skills that complement each other: gotcha saves tokens on **repeated work**, flip saves you from **wrong decisions**.

---

## Install

```bash
/plugin marketplace add michea11/dejavu    # add marketplace, once
/plugin install dejavu@michea11-dejavu     # install the plugin
```

Two commands, then `/gotcha` and `/flip` are ready.

---

## gotcha — Troubleshooting Memory

### What problem it solves

You debug a CI failure. 10 rounds of conversation later, you find the root cause: the Docker base image pinned an old SHA. Next week, the same error. The AI starts from scratch — another 10 rounds. **You paid twice for the same answer.**

gotcha makes sure this only happens once.

### Usage

```bash
# After fixing a bug, save the experience
/gotcha save
# → AI scans your recent debugging session
# → Extracts: what was the symptom, what was the root cause, what fixed it
# → Presents a draft, you confirm → saved

# Next time, search instead of re-investigating
/gotcha CI killed
# → grep-searches your gotcha library in milliseconds
# → One match → injects full content, skip the debugging
# → Multiple matches → lists titles, you pick

# Manage your gotcha library
/gotcha                    # List all, newest first
/gotcha fix <slug>         # Mark as fixed (keeps record, annotates on match)
/gotcha delete <slug>      # Delete (confirms first)
```

### File Format

Every gotcha is a plain Markdown file under `.claude/gotchas/`:

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

Readable, editable, git-trackable. No black boxes.

### Design

- **Zero token cost on miss** — no index pre-injection, no background matching. Only searches when you invoke `/gotcha`
- **Non-intrusive** — you decide when to save. One gentle reminder at session end
- **Configurable** — hint level, session reminder, dedup strictness all adjustable via parameters

---

## flip — Perspective Shift

### What problem it solves

You and the AI discuss options and settle on Redis for caching. Throughout the discussion, you're in the frame of "how do we implement Redis caching?" Nobody asks "do we even need caching?" or "will a single large object blow up Redis?" **These blind spots surface in production.**

flip examines your conclusion from an angle that was missing from the discussion — before you ship.

### Usage

```bash
# Examine the latest conclusion from a missing angle
/flip
# → AI asks: what perspective was absent from this discussion?
# → Examines the conclusion from that missing angle
# → Finds a blind spot → suggests fix. No blind spot → confirms it holds

# Examine a specific conclusion
/flip "use Redis for caching"
```

### Which Angle

flip dynamically picks whatever perspective is missing from the discussion. It doesn't default to "the opposite":

| Angle | Question |
|---|---|
| Opposite | "What if we don't?" |
| Cost | "How much time/money? Worth it?" |
| Simplify | "Can we do less? Can we skip it?" |
| Time | "What would we regret 3 months from now?" |
| Newcomer | "What would confuse someone without context?" |
| Extreme | "Where does this break with unexpected usage?" |
| Scale | "What fails first at 10x volume?" |

One angle per invocation — the one most likely to reveal a blind spot.

### Design

- **Not a debate** — if the angle checks out, confirm and move on. Not contrarian for its own sake
- **Not brainstorming** — brainstorming explores possibilities, flip examines existing conclusions
- **You decide** — flip surfaces perspective, the conclusion is always yours
- **Configurable** — hint level: off / on key decisions / on every conclusion

---

## Cross-Platform

Same `SKILL.md`, one codebase, six platforms:

| Tool | Skill Directory | Version |
|---|---|---|
| Claude Code | `.claude/skills/` | Full (allowed-tools, argument-hint included) |
| OpenAI Codex CLI | `.agents/skills/` | Platform-neutral |
| Cursor | `.cursor/skills/` | Platform-neutral |
| GitHub Copilot | `.github/skills/` | Platform-neutral |
| Windsurf | `.windsurf/skills/` | Platform-neutral |
| Gemini CLI | `.gemini/skills/` | Platform-neutral |

Clone into your tools' directories. When you update skills, run `scripts/sync-skills.sh` to sync across all platforms.

---

## Why déjà vu

| | Current Approach | déjà vu |
|---|---|---|
| Save experience | Manually write CLAUDE.md / .cursorrules. People forget. | One command, AI extracts, you confirm |
| Find experience | grep manually, scroll chat history, re-ask AI | `/gotcha <keyword>`, millisecond hit |
| Decision review | Gut feeling, intuition, code review | `/flip`, systematic perspective shift |
| Token overhead | Rules files loaded in full. You pay even when not using. | Zero pre-injection. You pay only when you search |
| Dependencies | Embedding APIs, vector databases | grep + filesystem, zero external deps |

---

## Design Philosophy

- **Don't burn your tokens** — On-demand search only. No pre-injection, no background matching
- **No external dependencies** — grep + filesystem. Understandable, debuggable, zero cost
- **Don't break your flow** — You decide when to save. One gentle reminder, no nagging
- **You're in control** — We surface experience and perspective. The conclusion is always yours
