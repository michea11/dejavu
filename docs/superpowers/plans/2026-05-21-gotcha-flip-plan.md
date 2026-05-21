# Gotcha + Flip Skills Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement two ECC skills: gotcha (troubleshooting memory with grep-based search) and flip (perspective-shifting design review). Both zero-dependency, pure bash+filesystem, slash-command invoked.

**Architecture:** Each skill is a single `SKILL.md` file in `.claude/skills/<name>/`. gotcha uses bash (grep, mkdir, read/write) to manage `.claude/gotchas/*.md` files. flip is a pure process skill with no storage — it modifies model thinking behavior during design discussions.

**Tech Stack:** Claude Code skill system (SKILL.md + frontmatter), bash, markdown files

---

## File Structure

```
.claude/skills/
  gotcha/
    SKILL.md          # gotcha skill definition + all command logic
  flip/
    SKILL.md          # flip skill definition + all command logic
```

No other files. No config files (settings.json used for defaults). No external dependencies.

---

### Task 1: Create gotcha SKILL.md

**Files:**
- Create: `.claude/skills/gotcha/SKILL.md`

- [ ] **Step 1: Create skill directory**

```bash
mkdir -p .claude/skills/gotcha
```

- [ ] **Step 2: Write SKILL.md**

```markdown
---
name: gotcha
description: Save and search troubleshooting gotchas. Use when user encounters errors, debugs issues, or needs to recall past fixes. /gotcha save to record, /gotcha <keyword> to search, /gotcha to list all.
argument-hint: [save|search|delete|fix] [keyword|slug]
allowed-tools: [Read, Write, Bash, Grep, Glob]
---

# Gotcha

Save troubleshooting experience and quickly recall it later. Zero external dependencies — grep + filesystem only.

## Commands

### /gotcha save

When the user invokes this, look back through the current conversation for the most recent debugging/troubleshooting sequence. Extract three elements:

1. **症状**: What error/abnormal behavior did the user first report?
2. **原因**: What root cause was found after investigation?
3. **解法**: What was the final fix?

Compress these into a gotcha draft and present to the user for confirmation:

```
---
tags: [<infer 2-4 English tags from context>]
created: "<today's date YYYY-MM-DD>"
fixed: false
---

# 症状
<one-line symptom>

# 原因
<one-line root cause>

# 解法
<one-line fix>
```

If user confirms, save to `.claude/gotchas/<slug>.md`.

**Slug generation**: Derive from English tags using hyphens (e.g. `ci-oom-killed`). If the symptom is Chinese-only, slug using date: `YYYY-MM-DD-NNN`.

**Before saving**: grep existing gotcha files for similar symptom keywords. If highly similar found, warn: "已有类似 gotcha: <filename>，还要保存吗？"

**First save**: If `.claude/gotchas/` directory does not exist, create it with `mkdir -p`.

### /gotcha <keyword>

Search `.claude/gotchas/` for files matching the keyword:

```bash
grep -rli "<keyword>" .claude/gotchas/ 2>/dev/null
```

- **Single match**: Read the file and present the full gotcha content to the user
- **Multiple matches**: List each match with its filename and 症状 line, let user choose
- **No matches**: "没找到，换个关键词试试？"

For files with `fixed: true` in frontmatter, append "(已标记修复)" to the listing.

### /gotcha

List all gotchas sorted by modification time (newest first):

```bash
ls -lt .claude/gotchas/*.md 2>/dev/null | awk '{print $NF}'
```

For each file, extract and display: filename, 症状 line, `fixed` status.

### /gotcha delete <slug|keyword>

If `<slug|keyword>` matches a filename exactly, delete it. If it's a keyword, grep for matches first, let user confirm which one to delete. Always ask for confirmation before deleting:

```
确认删除 gotcha "<title>"? [y/N]
```

### /gotcha fix <slug>

Update the frontmatter of the gotcha file to set `fixed: true`:

```bash
sed -i '' 's/fixed: false/fixed: true/' .claude/gotchas/<slug>.md
```

## File Format

Every gotcha file is markdown with YAML frontmatter:

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

Frontmatter fields: `tags` (array), `created` (date string), `fixed` (boolean).
Body sections: `# 症状`, `# 原因`, `# 解法` — all plain language. Additional content can be freely appended below.

## Proactive Behaviors

### Error hint (hintLevel: normal)

When the user reports an error and troubleshooting extends beyond 2 conversation rounds, the model may suggest once per session:

> "要不要 /gotcha 查一下有没有类似的坑？"

This is conversational behavior, not a system hook. Do NOT inject any index or search automatically.

At `hintLevel: off`, never proactively suggest. At `hintLevel: high`, suggest on any error report.

### Session-end reminder (sessionReminder: on)

At session end, weakly remind:

> "今天有没有踩坑忘了记的？有的话 /gotcha save 一下"

Do not list specific gotchas. Do not track anything silently. One line, no follow-up.

At `sessionReminder: off`, skip entirely.

## Configuration

Configurable via skill parameters. Default values in settings.json:

| Parameter | Default | Options |
|---|---|---|
| `hintLevel` | `normal` | `off` / `normal` / `high` |
| `sessionReminder` | `on` | `on` / `off` |
| `dedupCheck` | `normal` | `off` / `normal` / `strict` |

## Principles

- Zero external dependencies
- No index pre-injection — search only on user command
- No automatic background matching — no hooks, no silent grep
- Gotcha focuses on project-specific hidden pitfalls, not general knowledge
```

- [ ] **Step 3: Verify SKILL.md structure**

```bash
ls -la .claude/skills/gotcha/SKILL.md && head -10 .claude/skills/gotcha/SKILL.md
```

Expected: File exists with valid YAML frontmatter.

- [ ] **Step 4: Commit**

```bash
git add .claude/skills/gotcha/SKILL.md
git commit -m "feat: add gotcha skill for troubleshooting memory"
```

---

### Task 2: Create flip SKILL.md

**Files:**
- Create: `.claude/skills/flip/SKILL.md`

- [ ] **Step 1: Create skill directory**

```bash
mkdir -p .claude/skills/flip
```

- [ ] **Step 2: Write SKILL.md**

```markdown
---
name: flip
description: Shift perspective on design decisions to find blind spots. Use when discussing architecture, choosing between approaches, making technical decisions, or finalizing designs. /flip to examine from a missing angle.
argument-hint: [conclusion]
allowed-tools: []
---

# Flip

Before finalizing a design decision, deliberately shift to a perspective that's missing from the current discussion. The goal is to find blind spots before committing — not to debate, not to brainstorm.

## Commands

### /flip

Look at the most recent conclusion or decision in the current discussion. Ask:

> "What perspective have we NOT considered in this discussion? What angle is absent?"

Then examine the conclusion from that missing angle. Do NOT default to the opposite — that's only one possible shift. Identify the most revealing absent perspective and use it.

### /flip <conclusion>

Same as above, but applied to the explicitly stated conclusion. Example: `/flip "用 redis 做缓存"`

## Perspective Selection

Dynamically identify what's missing from the current discussion. These are examples of common shifts, not a fixed checklist:

| Shift | Question |
|---|---|
| Opposite | "What if we don't do X?" |
| Cost | "How much time/money does this cost? Is it worth it?" |
| Simplify | "Can we do less? Can we not do it at all?" |
| Time | "What would we regret about this 3 months from now?" |
| Newcomer | "What would someone without context find confusing?" |
| Extreme | "Where does this break when users misuse it?" |
| Scale | "What fails first at 10x volume?" |

Pick ONE most revealing shift per invocation. Don't pile on perspectives — one sharp insight beats three shallow ones.

## Output Format

```
[从 <perspective> 的角度看]

发现: <one-line insight>

如果确实有问题: <suggested fix>
如果没问题: "这个角度看也没问题。"
```

## Proactive Behaviors

At `hintLevel: normal`, suggest /flip when:
- User says "就这样吧", "没问题了", "确定了"
- A design discussion appears to reach consensus
- A spec or design document is about to be finalized

At `hintLevel: off`, never proactively suggest. At `hintLevel: high`, suggest after any conclusion statement.

Suggestion is one line: "要不要 /flip 换个角度再看一眼？" — not a system hook, just conversational behavior.

## Configuration

| Parameter | Default | Options |
|---|---|---|
| `hintLevel` | `normal` | `off` / `normal` / `high` |

## Boundaries

- NOT a debate tool. If the conclusion holds after shifting perspective, acknowledge it and move on
- NOT brainstorming. Brainstorming explores possibilities; flip examines existing conclusions
- NOT implementation. Flip only examines — return to the original flow after

## Relationship with gotcha

```
gotcha — troubleshooting memory — "I've seen this error before"
flip   — perspective shift    — "What angle haven't we checked?"
```

Independent. Use either without the other.
```

- [ ] **Step 3: Verify SKILL.md structure**

```bash
ls -la .claude/skills/flip/SKILL.md && head -10 .claude/skills/flip/SKILL.md
```

Expected: File exists with valid YAML frontmatter.

- [ ] **Step 4: Commit**

```bash
git add .claude/skills/flip/SKILL.md
git commit -m "feat: add flip skill for perspective-shifting design review"
```

---

### Task 3: Verification

- [ ] **Step 1: Confirm skill files are in place**

```bash
find .claude/skills -name "SKILL.md" -exec echo "Found: {}" \;
```

Expected: Two SKILL.md files found.

- [ ] **Step 2: End-to-end gotcha smoke test**

In a Claude Code session:
1. Simulate an error: "我的 build 报错了 Error: Cannot find module './utils'"
2. Troubleshoot across 3+ rounds
3. Run `/gotcha save` — verify draft is generated with 症状/原因/解法
4. Confirm save — verify `.claude/gotchas/<slug>.md` is created
5. Run `/gotcha module` — verify the saved gotcha is found
6. Run `/gotcha` — verify listing includes the saved gotcha
7. Run `/gotcha fix <slug>` — verify `fixed: false` → `fixed: true`
8. Run `/gotcha delete <slug>` — verify deletion with confirmation prompt

- [ ] **Step 3: End-to-end flip smoke test**

In a Claude Code session:
1. Discuss a design decision: "我们用 redis 做缓存还是 memcached？"
2. Reach a conclusion: "用 redis"
3. Run `/flip` — verify it picks a relevant missing perspective
4. Run `/flip "用 redis 做缓存"` — verify explicit conclusion examination
5. Say "就这样吧" — verify proactive suggestion at `hintLevel: normal`

- [ ] **Step 4: Commit plan document**

```bash
git add docs/superpowers/plans/2026-05-21-gotcha-flip-plan.md
git commit -m "docs: add implementation plan for gotcha and flip skills"
```
