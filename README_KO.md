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
  <em>같은 버그를 다시 디버깅하지 마세요. 같은 결정을 한 각도에서만 내리지 마세요.<br>
  두 가지 스킬. 의존성 제로. 모든 것을 기억하는 하나의 명령어.</em>
</p>

<br>

## 왜 필요한가

AI 코딩의 가장 큰 숨은 비용은 GPU가 아닌 **재사고**입니다 — 이미 해결한 문제를 다시 조사할 때마다 토큰과 시간이 소모됩니다.

| 시나리오 | 예전 | déjà vu 도입 후 |
|---|---|---|
| 같은 오류 반복 발생 | 10라운드 이상 재디버깅 | `/gotcha <키워드>` — 즉시 해결 |
| 아무도 설계 선택을 의문시하지 않음 | 운영 환경에서 맹점 발견 | `/flip` — 배포 전 발견 |
| 같은 함정에 세 번째 빠짐 | 매번 처음부터 | 3초 만에 확인 |
| 뭔가 이상한데 말로 표현 못 함 | 망설이다 그냥 진행 | 한 명령어로 체계적 검토 |

> **매번 적중할 때마다 재조사 토큰의 90% 이상을 절약합니다.**

<br>

## 설치

```bash
/plugin marketplace add michea11/dejavu    # 한 번만
/plugin install dejavu@michea11-dejavu     # 완료
```

단 두 개의 명령어입니다.

<br>

## 사용법

```bash
# ── gotcha: 트러블슈팅 메모리 ──

/gotcha save
# → 최근 디버깅 세션을 스캔, 증상 + 원인 + 해결책 추출
# → 초안 제시, 확인하면 .claude/gotchas/에 저장

/gotcha CI killed
# → grep으로 밀리초 검색. 1건 히트 → 전체 주입. 여러 건 → 선택

/gotcha                    # → 전체 목록, 최신순
/gotcha fix <slug>         # → 수정 완료 표시 (기록 유지)
/gotcha delete <slug>      # → 삭제 (확인 후)
```

```bash
# ── flip: 관점 전환 ──

/flip
# → "놓친 관점이 무엇인가?" → 부재한 관점에서 검토

/flip "use redis for caching"
# → 특정 결론을 부재한 관점에서 검토
```

<br>

## 특징

- **의존성 제로** — grep + 파일시스템. 임베딩 API도 벡터 DB도 외부 API도 불필요
- **미스 시 토큰 비용 제로** — 사전 인덱스 주입 없음, 백그라운드 매칭 없음, 요청 시에만 검색
- **크로스 플랫폼** — 동일한 SKILL.md가 Claude Code / Codex / Cursor / Copilot / Windsurf / Gemini CLI에서 작동
- **방해되지 않음** — 저장 여부는 당신이 결정. 세션 종료 시 한 번만 부드럽게 알림
- **플레인 Markdown 저장** — gotcha는 `.md` 파일. 읽기 쉽고, 편집 가능, git 추적 가능

<br>

## 크로스 플랫폼

| 도구 | 스킬 디렉토리 |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

클론만 하세요 — 사용 중인 도구가 자동으로 적절한 디렉토리를 로드합니다.

<br>

## 설계 철학

- **토큰을 낭비하지 않는다** — 요청 시에만 검색
- **몰입을 방해하지 않는다** — 저장 여부는 당신의 선택
- **마법은 없다** — grep + 파일시스템. 이해 가능, 디버그 가능, 비용 제로
- **당신이 주도한다** — 경험과 관점을 제공할 뿐, 결론은 항상 당신의 것
