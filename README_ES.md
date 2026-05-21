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

> No deberías tener que depurar el mismo problema dos veces.
> No deberías tomar decisiones desde un solo ángulo.

**déjà vu** es un plugin de Claude Code con dos habilidades sin dependencias, diseñado para eliminar el desperdicio de "repensar" en la codificación con IA.

---

## Instalación

```bash
# Añadir marketplace autogestionado (solo una vez)
/plugin marketplace add michea11/dejavu

# Instalar el plugin
/plugin install dejavu@michea11-dejavu
```

---

## Uso

```bash
# gotcha — memoria de resolución de problemas, grep + sistema de archivos, cero dependencias

/gotcha save              # Guarda la última sesión de depuración como gotcha
/gotcha <palabra clave>   # Busca gotchas coincidentes, inyecta contenido al acertar
/gotcha                    # Lista todos los gotchas, más recientes primero
/gotcha fix <slug>         # Marcar como corregido (conserva registro, anota en futuras coincidencias)
/gotcha delete <slug>      # Elimina un gotcha (solicita confirmación)

# flip — cambio de perspectiva, habilidad de proceso puro, sin I/O de archivos

/flip                      # Examina la última conclusión desde un ángulo faltante
/flip "usar redis para caché"  # Examina una conclusión específica
```

---

## Por Qué Importa

El mayor costo oculto de la codificación con IA no es la GPU — es **volver a pensar lo que ya resolviste**.

| Escenario | Sin déjà vu | Con déjà vu |
|---|---|---|
| CI falla con el error de la semana pasada | 10 rondas de depuración desde cero | `/gotcha CI killed` → solución instantánea |
| Eliges la opción A, nadie objeta | Encuentras el punto ciego en producción | `/flip` → lo detectas antes de publicar |
| Tercera vez en el mismo problema | Empezar de cero cada vez | Buscar gotcha → consulta de 3 segundos |
| Algo no te cuadra de esta decisión | Dudas, sigues adelante | `/flip` → revisión sistemática |

**Cada acierto no solo ahorra tokens, sino el estado de concentración y horas de conversación.**

---

## Dos Habilidades

### gotcha — Memoria de Resolución de Problemas

```
Encuentras un bug → /gotcha save → guardas la solución → /gotcha <palabra clave> → recuerdo instantáneo
```

- Búsqueda basada en grep, cero dependencias, respuesta en milisegundos
- Sin preinyección de índices — costo cero de tokens si no hay coincidencia
- Recordatorio suave al final de la sesión, nunca interrumpe

### flip — Cambio de Perspectiva

```
A punto de decidir → /flip → encuentra el ángulo faltante → detecta puntos ciegos a tiempo
```

- Nunca se limita a "lo opuesto" — encuentra cualquier perspectiva ausente
- Costo, tiempo, recién llegado, caso extremo, escala — cualquier ángulo faltante
- Sugerencias proactivas en puntos clave de decisión, discreto el resto del tiempo

---

## Multiplataforma

El mismo `SKILL.md` funciona en todas las principales herramientas de codificación con IA:

| Herramienta | Directorio de Habilidades |
|---|---|
| Claude Code | `.claude/skills/` |
| OpenAI Codex CLI | `.agents/skills/` |
| Cursor | `.cursor/skills/` |
| GitHub Copilot | `.github/skills/` |
| Windsurf | `.windsurf/skills/` |
| Gemini CLI | `.gemini/skills/` |

Clona una vez, tu herramienta carga automáticamente el directorio correcto. Claude Code obtiene la versión completa, otras plataformas obtienen el subconjunto universal.

---

## Filosofía de Diseño

- **No quemes tus tokens** — Sin preinyección de índices, sin búsqueda silenciosa en segundo plano, solo bajo demanda
- **Sin dependencias externas** — grep + sistema de archivos, sin APIs de embeddings, sin bases de datos vectoriales
- **No interrumpas tu flujo** — Tú decides qué guardar, un recordatorio suave al final de la sesión
- **Tú tomas las decisiones** — Ofrecemos experiencia y perspectiva, la conclusión siempre es tuya
