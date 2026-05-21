# Project Review: dejavu v1.0.0

**Reviewed**: 2026-05-21
**Scope**: 21 files, full project audit
**Decision**: APPROVE with notes

## Summary

项目结构清晰，两个技能定义（gotcha + flip）质量高。无安全漏洞。6 平台适配正确（Claude Code 保完整功能，其他平台去专属字段，副本一致）。发现 1 个可移植性问题、2 个可维护性建议。

## Findings

### CRITICAL
None.

### HIGH

**1. `sed -i ''` is macOS-only** — `skills/gotcha/SKILL.md:89`, `.claude/skills/gotcha/SKILL.md:86`
- GNU sed (Linux) expects `sed -i` without the empty string backup suffix
- Linux 用户运行 `/gotcha fix` 会报错
- Fix: 用 `perl -i -pe` 或检测 sed 版本，或直接 Read + Edit

### MEDIUM

**2. Skill 文件多目录复制，无同步机制** — 10 个 SKILL.md 副本分布在 7 个平台目录
- `skills/`（规范版）、`.claude/skills/`（Claude Code 完整版）、`.agents/`、`.cursor/`、`.github/`、`.windsurf/`、`.gemini/`（平台中立版）
- 修改一个 skill 需要同步更新 3 种版本（Claude 版 + 规范版 + 中立版）
- 建议: 加一个 `scripts/sync-skills.sh` 一键同步，README 中说明同步方式

**3. marketplace.json 与 plugin.json 的 description 不一致**
- `plugin.json`: "déjà vu for coding: gotcha 复用踩过的坑 + flip 换个角度看决策"
- `marketplace.json`: "déjà vu for coding: gotcha 踩坑记忆 + flip 换角度审视"
- 建议: 统一

### LOW

**4. 缺少 `.gitignore`**

**5. `ls -lt | awk '{print $NF}'` 文件名含空格会截断** — `skills/gotcha/SKILL.md:71`
- 文件名如果含空格，`$NF` 只取最后一段。slug 生成规则不使用空格，低风险

## Validation Results

| Check | Result |
|---|---|
| Security scan | Pass — no credentials, secrets, or injection vectors |
| YAML validity | Pass — all frontmatter and JSON files parse correctly |
| Cross-platform consistency | Pass — all 5 non-Claude platform copies identical |
| Claude Code features preserved | Pass — `.claude/skills/` retains `allowed-tools` + `argument-hint` |

## Files Reviewed (21)

All SKILL.md files (14), plugin.json, marketplace.json, README.md, LICENSE, 2 specs, 1 plan
