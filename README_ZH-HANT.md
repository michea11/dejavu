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
  <em>踩過的坑，不要重排查。做過的決策，不要只看一面。<br>
  兩個技能。零依賴。一條命令記住一切。</em>
</p>

<br>

## 為什麼

AI 最大的隱性成本不是 GPU，是 **重複思考** — 每次重新排查一個已經解決過的問題，燒的都是 token 和時間。

| 場景 | 以前 | 現在 |
|---|---|---|
| 同一個錯反覆出現 | 重排 10+ 輪對話 | `/gotcha <關鍵詞>` — 秒定位 |
| 沒人反問你選的方案 | 上線後發現盲區 | `/flip` — 發佈前發現 |
| 同樣的坑踩第三次 | 每次從零開始 | 3 秒查到 |
| 總覺得哪裡不對又說不上來 | 猶豫、算了、上線 | 一條命令系統性審視 |

> **每次命中，省掉 90%+ 的重複排查 token。**

<br>

## 安裝

```bash
/plugin marketplace add michea11/dejavu    # 一次
/plugin install dejavu@michea11-dejavu     # 完成
```

兩個命令就位。

<br>

## 用法

```bash
# ── gotcha: 踩坑記憶 ──

/gotcha save
# → 回溯最近一次排查，提取症狀 + 原因 + 解法
# → 生成草稿，你確認即存到 .claude/gotchas/

/gotcha CI killed
# → grep 毫秒級搜尋你的 gotcha 庫
# → 命中一個 → 直接注入。命中多個 → 你選

/gotcha                    # → 列出全部，時間倒序
/gotcha fix <slug>         # → 標記已修復（保留記錄）
/gotcha delete <slug>      # → 刪除（先確認）
```

```bash
# ── flip: 換角度審視 ──

/flip
# → "我們還沒從什麼角度看？" → 用缺席的視角審視

/flip "用 redis 做快取"
# → 對指定結論做換角度審視
```

<br>

## 特點

- **零依賴** — grep + 檔案系統，不用 embedding、不用向量庫、不用外部 API
- **不命中零 token 開銷** — 不預注入索引，不後臺靜默匹配，只在呼叫時檢索
- **跨平台** — 同一個 SKILL.md，Claude Code / Codex / Cursor / Copilot / Windsurf / Gemini CLI 都能用
- **不打擾** — 存不存你說了算，會話結束提示一句
- **純 Markdown 儲存** — gotcha 就是 `.md` 檔案，可讀可編輯可 git 追蹤

<br>

## 跨平台

| 工具 | 技能目錄 |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

克隆即可 — 你的工具自動載入對應目錄。

<br>

## 設計

- **不主動消耗你的 token** — 只在呼叫時檢索
- **不打斷你的心流** — 存不存你來定
- **沒有魔法** — grep + 檔案系統，可理解、可除錯、零成本
- **決定權在你** — 提供經驗、提供視角，結論永遠你定
