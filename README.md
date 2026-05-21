# Gotcha + Flip

重复经验复用工具集，两个 Claude Code 技能：

- **gotcha** — 踩坑记忆：排查问题后一键保存经验，下次遇到了直接查
- **flip** — 换角度审视：做设计决策时，换个缺席的视角看结论，发现盲区

## 安装

```bash
# 添加市场
/plugin marketplace add michea11/gotcha-flip

# 安装
/plugin install gotcha-flip@michea11-gotcha-flip
```

## 用法

### gotcha

| 命令 | 说明 |
|---|---|
| `/gotcha save` | 把最近一次排查过程存成 gotcha |
| `/gotcha <关键词>` | 搜索已有 gotcha |
| `/gotcha` | 列出所有 gotcha，按时间倒序 |
| `/gotcha fix <slug>` | 标记已修复 |
| `/gotcha delete <slug>` | 删除 gotcha |

### flip

| 命令 | 说明 |
|---|---|
| `/flip` | 对当前讨论的最新结论换个视角审视 |
| `/flip <结论>` | 对指定结论做审视 |

## 设计原则

- **零外部依赖** — grep + 文件系统，没有 embedding、没有向量库
- **不主动注入索引** — 只在你调用时做检索，不静默消耗 token
- **快速守卫** — 纯问答/聊天不触发，只在任务场景激活
