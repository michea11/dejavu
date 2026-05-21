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

> 你已經踩過的坑，不應該再花 token 重新排一遍。
> 你已經做的決策，不應該只有一個角度看。

**déjà vu** 是一個 Claude Code 插件，包含兩個零依賴的技能，專門解決 AI 程式碼中「重複浪費」的問題。

---

## 安裝

```bash
# 加入自託管市場（只需一次）
/plugin marketplace add michea11/dejavu

# 安裝插件
/plugin install dejavu@michea11-dejavu
```

---

## 用法

```bash
# gotcha —— 踩坑記憶，grep + 檔案系統，零依賴

/gotcha save              # 把最近一次排查過程存成 experience
/gotcha <關鍵詞>           # 搜尋匹配的 experience，命中則注入完整內容
/gotcha                    # 列出所有 experience，按時間倒序
/gotcha fix <slug>         # 標記已修復（不刪除，下次匹配時提示）
/gotcha delete <slug>      # 刪除指定 experience（會先確認）

# flip —— 換角度審視，純過程技能，不讀寫檔案

/flip                      # 對目前討論的最新結論，找個缺席的視角審視
/flip "用 redis 做快取"     # 對指定結論做審視
```

---

## 為什麼值得用

AI 程式碼最大的隱性成本不是 GPU，是 **重複思考**。

| 場景 | 現狀 | 用 déjà vu 後 |
|---|---|---|
| CI 報了上次一樣的錯 | 重新排查 10 輪對話 | `/gotcha CI killed` → 直接拿到解法 |
| 設計選了方案 A，沒人反問 | 上線後發現盲區 | `/flip` → 換個角度看出問題 |
| 一個坑踩了第三次 | 每次從頭來 | 查 gotcha → 3 秒定位 |
| 快敲定方案時總覺得不安 | 憑直覺猶豫 | `/flip` → 系統性審視 |

**每一次命中，節省的不是幾毛錢 token，是幾十輪排查對話的時間和心流。**

---

## 兩個技能

### gotcha — 踩坑記憶

```
排查中 → /gotcha save → 存成經驗 → 下次 /gotcha <關鍵詞> → 直接命中
```

- grep 檢索，零依賴，毫秒級
- 不注入索引，不命中零 token 開銷
- 會話結束弱提醒，不騷擾

### flip — 換角度審視

```
快下結論了 → /flip → 找到缺席的視角 → 發現盲區 → 趁早修正
```

- 不機械站對立面，動態選最可能發現問題的角度
- 成本、時間、新人、極端、放大…什麼缺席看什麼
- 關鍵決策時主動建議，平時不打擾

---

## 跨平台支援

同一個 SKILL.md，所有主流 AI 程式碼工具都能用：

| 工具 | 技能目錄 |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

克隆倉庫後，你的工具會自動載入對應目錄的技能。Claude Code 版本保留完整功能，其他平台僅去掉平台專屬欄位。

---

## 設計哲學

- **不主動消耗你的 token** — 不預注入索引，不靜默後台匹配，只在呼叫時檢索
- **不依賴外部服務** — grep + 檔案系統，沒有 embedding API、沒有向量資料庫
- **不打斷你的心流** — 存不存你說了算，只在會話結束弱提醒一句
- **不替你做決定** — 只提供經驗和視角，結論永遠在你
