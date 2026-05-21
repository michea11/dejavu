#!/usr/bin/env bash
# 从 skills/ 规范版同步到所有平台目录
# skills/ = Claude Code 完整版（含 allowed-tools, argument-hint）
# .claude/skills/ = Claude Code 本地版（同规范版）
# 其他平台 = 去掉 Claude 专属字段的中立版

set -euo pipefail
cd "$(dirname "$0")/.."

echo "Syncing skills from skills/ to all platform directories..."

# Claude Code 本地版（完整复制，保留所有字段）
for skill in gotcha flip; do
  cp "skills/${skill}/SKILL.md" ".claude/skills/${skill}/SKILL.md"
  echo "  .claude/skills/${skill}/SKILL.md (full)"
done

# 其他平台（去掉 Claude 专属字段）
for platform in agents cursor github windsurf gemini; do
  for skill in gotcha flip; do
    sed "/^allowed-tools:/d; /^argument-hint:/d" \
      "skills/${skill}/SKILL.md" \
      > ".${platform}/skills/${skill}/SKILL.md"
    echo "  .${platform}/skills/${skill}/SKILL.md (neutral)"
  done
done

echo "Done. All platforms synced."
