<p align="center">
  <a href="README.md">English</a> |
  <a href="README_ZH.md">简体中文</a> |
  <a href="README_ZH-HANT.md">繁體中文</a> |
  <a href="README_JA.md">日本語</a> |
  <a href="README_KO.md">한국어</a> |
  <a href="README_ES.md">Español</a>
</p>

---

# déjà vu

> You shouldn't have to re-debug the same problem. You shouldn't make decisions from only one angle.

**déjà vu** is a Claude Code plugin with two zero-dependency skills purpose-built to eliminate wasteful re-thinking in AI-assisted coding.

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

## Design Philosophy

- **Don't burn your tokens** — No index pre-injection, no silent background matching, search only on demand
- **No external dependencies** — grep + filesystem, no embedding APIs, no vector databases
- **Don't break your flow** — You decide what to save, one gentle reminder at session end
- **You make the call** — We surface experience and perspective, the conclusion is always yours
