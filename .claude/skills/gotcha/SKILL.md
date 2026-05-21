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
