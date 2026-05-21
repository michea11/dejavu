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

> 같은 버그를 다시 디버깅할 필요가 없습니다.
> 한 가지 시각으로만 결정을 내리지 마세요.

**déjà vu**는 AI 코딩에서 불필요한 '재사고'를 없애기 위해 만들어진, 의존성 없는 두 개의 스킬을 담은 Claude Code 플러그인입니다.

---

## 설치

```bash
# 셀프 호스팅 마켓플레이스 추가 (최초 1회)
/plugin marketplace add michea11/dejavu

# 플러그인 설치
/plugin install dejavu@michea11-dejavu
```

---

## 사용법

```bash
# gotcha — 트러블슈팅 메모리, grep + 파일시스템, 의존성 제로

/gotcha save              # 가장 최근 디버깅 세션을 gotcha로 저장
/gotcha <키워드>           # 매칭된 gotcha 검색, 히트 시 전체 내용 주입
/gotcha                    # 모든 gotcha를 최신순으로 나열
/gotcha fix <slug>         # 수정 완료 표시 (기록 유지, 다음 매칭 시 주석)
/gotcha delete <slug>      # gotcha 삭제 (확인 후 진행)

# flip — 관점 전환, 순수 프로세스 스킬, 파일 I/O 없음

/flip                      # 최신 결론을 놓친 관점에서 검토
/flip "use redis for caching"  # 특정 결론 검토
```

---

## 왜 사용해야 하나요

AI 코딩의 가장 큰 숨은 비용은 GPU가 아닌 **이미 해결한 문제를 다시 생각하는 것**입니다.

| 시나리오 | 기존 방식 | déjà vu 사용 후 |
|---|---|---|
| 지난주와 같은 오류로 CI 실패 | 처음부터 10라운드 디버깅 | `/gotcha CI killed` → 즉시 해결 |
| 모두 동의해서 A안 선택 | 운영 환경에서 맹점 발견 | `/flip` → 배포 전 발견 |
| 같은 실수 세 번째 | 매번 처음부터 다시 시작 | gotcha 검색 → 3초 만에 확인 |
| 이 결정, 뭔가 찜찜한데 | 망설이다 그냥 진행 | `/flip` → 체계적 검토 |

**매번 절약되는 것은 토큰뿐만 아니라 몰입 상태와 수 시간의 대화입니다.**

---

## 두 가지 스킬

### gotcha — 트러블슈팅 메모리

```
버그 발견 → /gotcha save → 해결책 저장 → /gotcha <키워드> → 즉시 재현
```

- grep 기반 검색, 의존성 제로, 밀리초 응답
- 사전 인덱스 주입 없음 — 미스 시 토큰 비용 제로
- 세션 종료 시 부드러운 알림, 방해되지 않음

### flip — 관점 전환

```
결정 직전 → /flip → 놓친 관점 발견 → 맹점 조기 포착
```

- 단순한 '반대 의견'이 아닌, 부재한 관점을 찾아냄
- 비용, 시간, 신입, 극단적 사례, 확장성 — 빠진 관점이라면 무엇이든
- 주요 결정 지점에서 선제적 힌트, 그 외에는 조용히

---

## 크로스 플랫폼

동일한 `SKILL.md`가 모든 주요 AI 코딩 도구에서 작동:

| 도구 | 스킬 디렉토리 |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

한 번 클론하면 각 도구가 적절한 디렉토리를 자동으로 로드합니다. Claude Code는 전체 기능 버전, 다른 플랫폼은 공통 하위 집합 버전을 사용.

---

## 설계 철학

- **토큰을 낭비하지 않는다** — 사전 인덱스 주입 없음, 백그라운드 자동 매칭 없음, 요청 시에만 검색
- **외부 의존성 제로** — grep + 파일시스템, 임베딩 API 없음, 벡터 DB 없음
- **몰입을 방해하지 않는다** — 저장 여부는 당신이 결정, 세션 종료 시 한 번만 부드럽게 알림
- **결정은 당신이** — 경험과 관점을 제공할 뿐, 결론은 항상 당신의 것
