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
  <em>No vuelvas a depurar el mismo error. No tomes decisiones desde un solo ángulo.<br>
  Dos habilidades. Cero dependencias. Un comando para recordarlo todo.</em>
</p>

<br>

## Por qué

El mayor costo oculto de la programación con IA no es la GPU — es **volver a pensar** lo que ya resolviste.

| Escenario | Antes | Con déjà vu |
|---|---|---|
| El mismo error aparece otra vez | 10+ rondas de depuración | `/gotcha <clave>` — solución instantánea |
| Nadie discute la decisión de diseño | Punto ciego encontrado en producción | `/flip` — detectado antes de publicar |
| Tercera vez en el mismo problema | Empezar de cero | Búsqueda de 3 segundos |
| Algo no cuadra, no sabes qué | Dudas, publicas igual | Revisión sistemática con un comando |

> **Cada acierto ahorra más del 90% de los tokens que gastarías reinvestigando desde cero.**

<br>

## Instalación

```bash
/plugin marketplace add michea11/dejavu    # una vez
/plugin install dejavu@michea11-dejavu     # listo
```

Solo dos comandos.

<br>

## Uso

```bash
# ── gotcha: memoria de resolución ──

/gotcha save
# → escanea la última sesión de depuración, extrae síntoma + causa + solución
# → presenta un borrador, confirmas → guardado en .claude/gotchas/

/gotcha CI killed
# → búsqueda grep en milisegundos. Un resultado → inyecta. Varios → tú eliges.

/gotcha                    # → lista todos, más recientes primero
/gotcha fix <slug>         # → marca como corregido (conserva el registro)
/gotcha delete <slug>      # → elimina (pide confirmación)
```

```bash
# ── flip: cambio de perspectiva ──

/flip
# → "¿Qué ángulo nos falta?" → examina desde esa perspectiva ausente

/flip "usar redis para caché"
# → examina una conclusión específica desde un ángulo ausente
```

<br>

## Características

- **Cero dependencias** — grep + sistema de archivos. Sin APIs de embeddings, sin bases de datos vectoriales
- **Costo cero de tokens si no hay coincidencia** — sin preinyección de índices, sin búsqueda en segundo plano
- **Multiplataforma** — el mismo SKILL.md funciona en Claude Code / Codex / Cursor / Copilot / Windsurf / Gemini CLI
- **No intrusivo** — tú decides cuándo guardar. Un recordatorio suave al final de la sesión
- **Almacenamiento Markdown** — los gotchas son archivos `.md`. Legibles, editables, rastreables con git

<br>

## Multiplataforma

| Herramienta | Directorio de Habilidades |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

Clona una vez — tu herramienta carga automáticamente el directorio correcto.

<br>

## Filosofía

- **No quemes tus tokens** — búsqueda solo bajo demanda
- **No interrumpas tu flujo** — tú decides qué guardar
- **Sin magia** — grep + sistema de archivos. Comprensible, depurable, costo cero
- **Tú tienes el control** — ofrecemos experiencia y perspectiva, la conclusión es tuya
