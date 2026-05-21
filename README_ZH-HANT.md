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
  兩個技能。零依賴。把 AI 編碼中最浪費 token 的事 —— 重複思考 —— 徹底解決。</em>
</p>

<br>

## 為什麼需要 déjà vu

AI 編碼時，最大的隱性成本不是 GPU，不是 API 費用，是**重複思考**。

**同一個錯，排查一次、兩次、三次。** 每次 AI 都要重新讀程式碼、重新分析、重新推演。這個過程燒掉的 token，比修 bug 本身多得多。

**同一個決策，永遠從你給的角度看。** AI 不會主動說「這個方案可能有個盲區你沒注意到」。它擅長執行，但不擅長質疑。

déjà vu 做兩件事：
- **gotcha** — 讓你排查過一次的坑，下次直接查結果，不用重來
- **flip** — 讓你做決策時，AI 主動換個缺席的角度幫你審視

兩個技能互補：gotcha 省掉**重複勞動**的 token，flip 防止**錯誤決策**的返工。

---

## 安裝

```bash
/plugin marketplace add michea11/dejavu    # 加入市場，只需一次
/plugin install dejavu@michea11-dejavu     # 安裝外掛
```

安裝後就有 `/gotcha` 和 `/flip` 兩個命令。

---

## gotcha — 踩坑記憶

### 它解決什麼問題

你排查了一個 CI 報錯，花 10 輪對話找到原因——是 Docker base image 鎖了舊 SHA。下週同一個錯又來了，AI 從頭查起，又花 10 輪。**你付了兩遍 token，買的是同一個答案。**

gotcha 讓這種事只發生一次。

### 怎麼用

```bash
# 修完一個坑後，存下來
/gotcha save
# → AI 回溯你剛才的排查過程
# → 自動提取：症狀是什麼、根因是什麼、怎麼修的
# → 生成草稿，你確認就儲存

# 下次遇到，直接查
/gotcha CI killed
# → grep 毫秒級搜尋你的 gotcha 庫
# → 命中一個 → 直接注入完整內容，跳過排查
# → 命中多個 → 列出標題讓你選

# 管理你的 gotcha 庫
/gotcha                    # 列出全部，按時間倒序
/gotcha fix <slug>         # 標記已修復（保留記錄，下次匹配會提示）
/gotcha delete <slug>      # 刪除（會先確認）
```

### 怎麼存的

每個 gotcha 就是一個 Markdown 檔案，存在 `.claude/gotchas/` 下：

```markdown
---
tags: [CI, OOM, GitHub-Actions]
created: "2026-05-21"
fixed: false
---

# 症狀
CI 報 killed 但本地正常

# 原因
GitHub Actions runner 只有 7GB 記憶體

# 解法
NODE_OPTIONS=--max-old-space-size=4096
```

可讀、可編輯、可 git 追蹤。沒有任何黑盒。

### 設計原則

- **不命中不燒 token** — 沒有索引預注入，沒有後臺靜默匹配。只在呼叫 `/gotcha` 時才做 grep 檢索
- **不打擾你** — 存不存你說了算。會話結束時弱提醒一句「今天有沒有忘了記的坑？」
- **可設定** — 主動提示程度、會話結束提醒、重複檢測嚴格度，都可透過參數調整

---

## flip — 換角度審視

### 它解決什麼問題

你和 AI 討論方案，決定了用 Redis 做快取。整個過程你們都在「怎麼做 Redis 快取」的框架裡思考。沒人問「不做快取行不行？」「單個大物件會不會把 Redis 打爆？」**這些盲區，上線後才發現。**

flip 讓你在下結論前，刻意換個缺席的視角再看一眼。

### 怎麼用

```bash
# 對目前討論的最新結論，換個角度審視
/flip
# → AI 判斷：剛才的討論中什麼視角缺席了？
# → 從那個缺席的角度重新審視結論
# → 有盲區 → 建議修正。沒盲區 → 確認成立

# 對指定結論做審視
/flip "用 Redis 做快取"
```

### 從什麼角度看

flip 不機械站對立面。它動態判斷**目前討論中缺了什麼**：

| 角度 | 問法 |
|---|---|
| 對立面 | 「不做會怎樣？」 |
| 成本 | 「這要多花多少時間/錢？值得嗎？」 |
| 簡化 | 「能不能不做？能不能做更少？」 |
| 時間 | 「三個月後回頭看，最後悔的可能是什麼？」 |
| 新人 | 「不了解上下文的人看到這個，會疑惑什麼？」 |
| 極端 | 「使用者完全不按預期用時，哪裡會崩？」 |
| 放大 | 「如果要撐 10 倍量，哪裡先垮？」 |

每次只選**一個**最可能發現盲區的角度，不堆砌。

### 設計原則

- **不是辯論，是審視** — 換完角度看沒問題，就說沒問題。不為反對而反對
- **不是腦力激盪** — 腦力激盪是探索可能性，flip 是審視已有結論。兩者互補，不替代
- **不替你做決定** — 只提供視角和發現，結論永遠在你
- **可設定** — 主動提示程度可調：關 / 只在關鍵決策時 / 每次下結論都追問

---

## 跨平臺支援

同一個 `SKILL.md`，一套程式碼，六個平臺：

| 工具 | 技能目錄 | 版本 |
|---|---|---|
| Claude Code | `.claude/skills/` | 完整版（含 allowed-tools、argument-hint） |
| OpenAI Codex CLI | `.agents/skills/` | 平臺中立版 |
| Cursor | `.cursor/skills/` | 平臺中立版 |
| GitHub Copilot | `.github/skills/` | 平臺中立版 |
| Windsurf | `.windsurf/skills/` | 平臺中立版 |
| Gemini CLI | `.gemini/skills/` | 平臺中立版 |

複製倉庫到你用到的工具目錄下即可。修改 skill 內容時，執行 `scripts/sync-skills.sh` 一鍵同步到所有平臺。

---

## 為什麼選 déjà vu

| | 現有方案 | déjà vu |
|---|---|---|
| 存經驗 | 手動寫 CLAUDE.md / .cursorrules，人會忘會懶 | 一條命令，AI 自動提取，你確認 |
| 查經驗 | grep 自己搜、翻聊天記錄、重新問 AI | `/gotcha <關鍵詞>`，毫秒命中 |
| 決策審視 | 靠經驗、靠直覺、靠 code review | `/flip`，系統性地換角度 |
| Token 開銷 | rules 檔案全量載入，不用也燒 | 零預注入，不調不燒 |
| 依賴 | embedding API、向量資料庫 | grep + 檔案系統，零外部依賴 |

---

## 設計哲學

- **不主動消耗你的 token** — 只在呼叫時檢索，沒有預注入、沒有後臺匹配
- **不依賴外部服務** — grep + 檔案系統。可理解，可除錯，零依賴
- **不打斷你的心流** — 存不存你說了算，一條弱提醒，不追問
- **不替你做決定** — 提供經驗和視角，結論永遠在你手上
