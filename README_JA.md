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
  <em>同じバグを再デバッグしない。同じ判断を一つの視点で下さない。<br>
  二つのスキル。依存ゼロ。すべてを覚える一つのコマンド。</em>
</p>

<br>

## なぜ使うか

AI コーディング最大の隠れたコストは GPU ではなく **再思考** です — すでに解決した問題を再調査するたびに、トークンと時間を消費します。

| シナリオ | 以前 | déjà vu 導入後 |
|---|---|---|
| 同じエラーが繰り返し発生 | 10 ラウンド以上の再デバッグ | `/gotcha <キーワード>` — 即解決 |
| 誰も設計の選択を疑問視しない | 本番環境で盲点が見つかる | `/flip` — デプロイ前に発見 |
| 同じ落とし穴に 3 回目 | 毎回ゼロから | 3 秒で確認 |
| 何かがおかしいと言葉にできない | 迷ったまま進める | 1 コマンドで体系的レビュー |

> **毎回のヒットで、再調査にかかるトークンの 90% 以上を節約。**

<br>

## インストール

```bash
/plugin marketplace add michea11/dejavu    # 一度だけ
/plugin install dejavu@michea11-dejavu     # 完了
```

たった 2 つのコマンドです。

<br>

## 使い方

```bash
# ── gotcha: トラブルシューティングメモリ ──

/gotcha save
# → 直近のデバッグをスキャン、症状 + 原因 + 解決策を抽出
# → 下書きを表示、確認で .claude/gotchas/ に保存

/gotcha CI killed
# → grep でミリ秒検索。1 件ヒット → 完全注入。複数ヒット → 選択

/gotcha                    # → 全一覧、新着順
/gotcha fix <slug>         # → 修正済みにマーク（記録は保持）
/gotcha delete <slug>      # → 削除（確認あり）
```

```bash
# ── flip: 視点転換 ──

/flip
# → 「見落としている視点は？」→ 欠けた視点から検証

/flip "use redis for caching"
# → 特定の結論を欠けた視点から検証
```

<br>

## 特徴

- **依存ゼロ** — grep + ファイルシステム。埋め込み API もベクトル DB も外部 API も不要
- **ミス時にトークン消費ゼロ** — インデックス事前注入もバックグラウンドマッチもなし、オンデマンド検索のみ
- **クロスプラットフォーム** — 同じ SKILL.md が Claude Code / Codex / Cursor / Copilot / Windsurf / Gemini CLI で動作
- **邪魔にならない** — 保存するかはあなた次第。セッション終了時に一度だけ優しくリマインド
- **プレーン Markdown ストレージ** — gotcha は `.md` ファイル。可読、編集可能、git 追跡可能

<br>

## クロスプラットフォーム

| ツール | スキルディレクトリ |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

クローンするだけ — 使っているツールが自動的に適切なディレクトリを読み込みます。

<br>

## 設計理念

- **トークンを無駄にしない** — オンデマンド検索のみ
- **集中力を妨げない** — 保存するかどうかはあなた次第
- **魔法は使わない** — grep + ファイルシステム。理解可能、デバッグ可能、コストゼロ
- **あなたが主導** — 経験と視点を提供するだけ。結論は常にあなたのもの
