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

Override defaults temporarily with CLI flags: `/flip --hintLevel=off`. Without flags, the settings.json defaults are used.

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
