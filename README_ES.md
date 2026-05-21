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
  Dos habilidades. Cero dependencias. Elimina el mayor costo oculto de la programación con IA.</em>
</p>

<br>

## Por qué déjà vu

El mayor costo oculto en la programación con IA no son las horas de GPU ni las facturas de API — es **volver a pensar**.

**Mismo error, depurado tres veces.** Cada vez, la IA relee el código, reanaliza la traza de pila, rederiva la solución. Los tokens quemados en reinvestigación superan con creces el costo de la solución real.

**Misma decisión, una sola perspectiva.** La IA es excelente ejecutando, no diciendo "oye, ¿y el ángulo que no estamos viendo?" Nadie cuestiona la premisa hasta que se rompe en producción.

déjà vu hace dos cosas:
- **gotcha** — registra sesiones de depuración, recupéralas instantáneamente la próxima vez. Sin reinvestigación
- **flip** — antes de fijar una decisión, examínala desde una perspectiva que nadie consideró

Dos habilidades complementarias: gotcha ahorra tokens en **trabajo repetido**, flip te salva de **decisiones equivocadas**.

---

## Instalación

```bash
/plugin marketplace add michea11/dejavu    # añadir marketplace, una vez
/plugin install dejavu@michea11-dejavu     # instalar el plugin
```

Dos comandos y `/gotcha` y `/flip` están listos.

---

## gotcha — Memoria de Resolución

### Qué problema resuelve

Depuras un fallo de CI. Después de 10 rondas de conversación, encuentras la causa raíz: la imagen base de Docker fijó un SHA antiguo. La semana siguiente, el mismo error. La IA empieza de cero — otras 10 rondas. **Pagaste dos veces por la misma respuesta.**

gotcha asegura que esto solo ocurra una vez.

### Uso

```bash
# Después de arreglar un bug, guarda la experiencia
/gotcha save
# → La IA escanea tu sesión de depuración reciente
# → Extrae: cuál era el síntoma, cuál fue la causa raíz, qué lo solucionó
# → Presenta un borrador, confirmas → guardado

# La próxima vez, busca en lugar de reinvestigar
/gotcha CI killed
# → búsqueda grep en milisegundos
# → Un resultado → inyecta contenido completo, omite la depuración
# → Varios resultados → lista títulos, tú eliges

# Gestiona tu biblioteca de gotchas
/gotcha                    # Lista todos, más recientes primero
/gotcha fix <slug>         # Marca como corregido (conserva registro, anota al coincidir)
/gotcha delete <slug>      # Elimina (confirma primero)
```

### Formato de Archivo

Cada gotcha es un archivo Markdown plano bajo `.claude/gotchas/`:

```markdown
---
tags: [CI, OOM, GitHub-Actions]
created: "2026-05-21"
fixed: false
---

# 症状
CI 报 killed 但本地正常

# 原因
GitHub Actions runner 只有 7GB 内存

# 解法
NODE_OPTIONS=--max-old-space-size=4096
```

Legible, editable, rastreable con git. Sin cajas negras.

### Diseño

- **Costo token cero al fallar** — sin preinyección de índices, sin búsqueda en segundo plano. Solo busca cuando invocas `/gotcha`
- **No intrusivo** — tú decides cuándo guardar. Un recordatorio suave al final de la sesión
- **Configurable** — nivel de sugerencia, recordatorio de sesión, rigurosidad de duplicados, todo ajustable

---

## flip — Cambio de Perspectiva

### Qué problema resuelve

Tú y la IA discuten opciones y deciden usar Redis para caché. Durante la discusión, están en el marco de "cómo implementar caché Redis". Nadie pregunta "¿necesitamos caché?" o "¿un objeto grande reventará Redis?" **Estos puntos ciegos aparecen en producción.**

flip examina tu conclusión desde un ángulo que faltaba en la discusión — antes de publicar.

### Uso

```bash
# Examina la última conclusión desde un ángulo faltante
/flip
# → La IA pregunta: ¿qué perspectiva estuvo ausente en esta discusión?
# → Examina la conclusión desde ese ángulo faltante
# → Encuentra punto ciego → sugiere corrección. Sin punto ciego → confirma

# Examina una conclusión específica
/flip "usar Redis para caché"
```

### Qué Ángulo

flip elige dinámicamente la perspectiva que falta en la discusión. No usa "el opuesto" por defecto:

| Ángulo | Pregunta |
|---|---|
| Opuesto | "¿Y si no lo hacemos?" |
| Costo | "¿Cuánto tiempo/dinero? ¿Vale la pena?" |
| Simplificar | "¿Podemos hacer menos? ¿Podemos omitirlo?" |
| Tiempo | "¿De qué nos arrepentiríamos en 3 meses?" |
| Novato | "¿Qué confundiría a alguien sin contexto?" |
| Extremo | "¿Dónde se rompe con uso inesperado?" |
| Escala | "¿Qué falla primero a 10x volumen?" |

Un ángulo por invocación — el que tiene más probabilidades de revelar un punto ciego.

### Diseño

- **No es un debate** — si el ángulo confirma, sigue adelante. No es contradecir por contradecir
- **No es brainstorming** — brainstorming explora posibilidades, flip examina conclusiones existentes
- **Tú decides** — flip ofrece perspectiva, la conclusión siempre es tuya
- **Configurable** — nivel de sugerencia: apagado / en decisiones clave / en cada conclusión

---

## Multiplataforma

Mismo `SKILL.md`, una base de código, seis plataformas:

| Herramienta | Directorio de Habilidades | Versión |
|---|---|---|
| Claude Code | `.claude/skills/` | Completa (allowed-tools, argument-hint incluidos) |
| OpenAI Codex CLI | `.agents/skills/` | Neutral |
| Cursor | `.cursor/skills/` | Neutral |
| GitHub Copilot | `.github/skills/` | Neutral |
| Windsurf | `.windsurf/skills/` | Neutral |
| Gemini CLI | `.gemini/skills/` | Neutral |

Clona en los directorios de tus herramientas. Al actualizar habilidades, ejecuta `scripts/sync-skills.sh` para sincronizar todas las plataformas.

---

## Por qué déjà vu

| | Enfoque Actual | déjà vu |
|---|---|---|
| Guardar experiencia | Escribir manualmente CLAUDE.md / .cursorrules. La gente olvida | Un comando, la IA extrae, tú confirmas |
| Encontrar experiencia | grep manual, desplazarse por el historial, volver a preguntar a la IA | `/gotcha <clave>`, resultado en milisegundos |
| Revisar decisiones | Intuición, experiencia, revisión de código | `/flip`, cambio sistemático de perspectiva |
| Sobrecarga de tokens | Archivos de reglas cargados completos. Pagas incluso sin usar | Cero preinyección. Pagas solo cuando buscas |
| Dependencias | APIs de embedding, bases de datos vectoriales | grep + sistema de archivos, cero dependencias externas |

---

## Filosofía de Diseño

- **No quemes tus tokens** — Solo búsqueda bajo demanda. Sin preinyección, sin búsqueda en segundo plano
- **Sin dependencias externas** — grep + sistema de archivos. Comprensible, depurable, costo cero
- **No interrumpas tu flujo** — Tú decides cuándo guardar. Un recordatorio suave, sin insistencia
- **Tú tienes el control** — Ofrecemos experiencia y perspectiva. La conclusión siempre es tuya
