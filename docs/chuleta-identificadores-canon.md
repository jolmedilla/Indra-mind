# Chuleta del canon: estructura e identificadores

> **Para la conversación con José · 6-ago-2026** · Contra el canon en `1a69d09` (requisitos
> v0.5.1, ADR-048). No es un resumen del canon: es lo justo para orientarse, citar bien y no
> quedarse en blanco. Lo que hay que leer de verdad es
> [`veredicto-sobre-el-canon.md`](veredicto-sobre-el-canon.md).

# Parte 1 · Cómo está organizada su documentación

## El principio que lo ordena

Está escrito en la cabecera de su índice y explica todo lo demás:

> «Una fuente de verdad por tema, y al versionar se **sustituye, no se acumula**. Las
> conversaciones son desechables; **el canon vive en ficheros**.»

De ahí sale que los ADR no se editen **nunca**: si una decisión cambia, se escribe un ADR nuevo
que supersede al anterior. El registro es historia, no estado.

## Los tres estados de un documento

| Estado | Qué significa | Dónde |
|---|---|---|
| **Canónico** | **Manda**, y genera obligaciones de propagación al versionarse | `docs/`, y solo los seis de la tabla de abajo |
| **Apoyo** | Vigente e informativo: **se cita, no se obedece**. Notas de análisis y actas | `docs/apoyo/` |
| **Archivo** | Retirado. **No se cita como fuente** y no se le aplican pasadas terminológicas | `archivo/` |

Esa distinción es la que hay que tener presente: la mayor parte del volumen del repo —el corpus de
contraste, los planes territoriales, la visita al CECOES— es **apoyo**. Impresiona por cantidad,
pero no manda.

## Los seis artefactos canónicos

Solo estos generan obligación de propagación. Todo lo demás, por voluminoso que sea, no.

| Fichero | Es la fuente de verdad de | Estado |
|---|---|---|
| `requisitos-motor-cognitivo.md` | Lo que el motor debe hacer y garantizar: capacidades, invariantes, configurabilidad, presupuestos, anti-requisitos, y el banco REQ-01..61 como contrato de aceptación | **v0.5.1** |
| `decisiones.md` | El registro ADR: toda decisión firme de producto | vivo, ADR-001..048 |
| `decisiones-poc.md` | Las decisiones propias de la PoC | vivo, POC-001..005 |
| `indice-del-canon.md` | **El inventario**: la única lista válida de documentos y versiones, más la matriz de propagación | vivo, v3.28 |
| `consultoria-cognitiva-metodo-implantacion.md` | El método de implantación: superficies configurables, fases, talleres | v0.2 |
| `hoja-de-ruta.md` | El plan: crónica, fases con puertas, hitos H1–H4, equipo, deuda documental | vivo |

`CLAUDE.md` está **fuera** del grafo de propagación a propósito: no contiene versiones ni
inventario, y así no hay que actualizarlo cuando algo sube de versión.

## Las carpetas

| Carpeta | Qué hay | Estado hoy |
|---|---|---|
| `docs/` | El canon vigente, todo Markdown (ADR-014) | ✅ |
| `docs/apoyo/` | Notas de análisis y actas. Sin obligación de propagación | ✅ voluminoso |
| `banco/` | Los escenarios de aceptación, YAML, uno por fichero | ⚠️ **solo el README y 3 borradores** |
| `packs/` | La doctrina en YAML, por razonador | ❌ no existe |
| `sim/` | Fuentes simuladas: segmentos por fuente, más trazas de las sesiones de roleplay | ❌ no existe |
| `demo/` | La capa de demostración y el argumento. **No es contrato**: el contrato es el banco | parcial |
| `src/` | El código. **Solo se empieza cuando banco y packs estén validados en simulación** | ❌ no existe |
| `tools/` | `check_canon.js` (coherencia del canon) y `publicar.sh` | ✅ |
| `archivo/` | Versiones sustituidas e histórico. Nada vigente | ✅ |
| `visuales/` | 21 visuales en HTML+PDF. **Fuera de la matriz de propagación a propósito** | ✅ nuevo |

## Los itinerarios de lectura que él mismo define

Esto es lo más útil de todo, porque **José ya ha resuelto el problema de por dónde entrar** y lo
tiene escrito en el índice. Son cuatro rutas:

| Si quieres… | Lee, en este orden |
|---|---|
| **Entender el producto** | `apoyo/fundamentos-del-motor-cognitivo.md` (los porqués) → `apoyo/motor-cognitivo-explicado.md` (el sistema completo, componente a componente) → `apoyo/ejemplos-del-motor-cognitivo.md` (sobre casos) |
| **Contar qué vamos a hacer y por qué** (el recap a dirección) | `demo/argumento-demo-direccion.md`, y `hoja-de-ruta.md` para el plan y el equipo |
| **Construir, o entender cómo se construye** | `CLAUDE.md`, el índice, el `README` de `/banco`, y la sección «El viaje de un escenario» de los fundamentos |
| **Saber por qué algo es como es, o cuándo pasó** | `decisiones.md`, `decisiones-poc.md` y la crónica de `hoja-de-ruta.md` |

**Corrige lo que te dije antes**: si algún día quieres entrar el canon de verdad, no son 48 ADR —
son **tres documentos** por la primera ruta. Para mañana sigue bastando el veredicto; pero la ruta
existe y es suya, lo que la hace además una buena cosa que mencionar.

## Las reglas de gobierno que conviene conocer

Son las de su `CLAUDE.md`, y varias te sirven como argumento:

1. **Los ADR no se editan nunca.** Si una decisión cambia, ADR nuevo que supersede.
2. **Ningún hallazgo o capacidad entra al diseño sin su escenario en `/banco`.** Esta es la que
   convierte al banco en puerta y no en adorno — y la que hace que nuestra aportación sobre
   identidades tenga que llegar con su borrador de escenario.
3. **Antes de aceptar una propuesta, contrástala con los invariantes y los anti-requisitos.**
4. **Trabaja siempre con hipótesis en competencia**; si un diseño solo contempla una opción, pide
   las alternativas. (Es la razón de que sus ADR lleven sección de descartados.)
5. **Matriz de propagación:** la sesión que versiona aplica su fila en el mismo cambio; lo que no
   pueda propagarse se deja escrito como **CONSULTA**, nunca se resuelve en silencio.
6. **`node tools/check_canon.js`** antes de cerrar cualquier sesión que toque `docs/`.
7. **Una sesión, un commit** — y el push lo hace José, porque las credenciales son suyas.
8. **Pasarela de graduación:** lo que se descubre en la PoC vive en `decisiones-poc.md` y solo se
   convierte en norma por un ADR expreso que cite el POC de origen. La PoC transfiere demostración,
   **no jurisdicción** (ADR-035, 5).

## Vocabulario no negociable (su `CLAUDE.md`)

- **La escalera de objetos:** evento → **detección** → incidente (con hilos) → operación → sala.
- **«Situación» está reservada:** significa cuadro de situación o Situación Operativa (0-3), y
  nada más. **«Alarma»** es término heredado del mundo PSIM: se modela como evento **sin
  privilegio de atención**.
- Los componentes máquina se anclan a **objetos, nunca a personas**, y no guardan estado entre
  invocaciones.
- **El principio que lo ordena todo: la máquina prepara y propone; la persona decide.**
- **Alias en desuso**, no usar en texto nuevo: «el bosque» → los fundamentos del motor cognitivo;
  «la arquitectura contada» → el motor cognitivo explicado.

---

# Parte 2 · Los identificadores

## Las familias

| Prefijo | Qué es | Dónde vive | Hasta |
|---|---|---|---|
| **C-nn** | **Capacidades** de razonamiento — qué competencias ejerce | §3 requisitos | C-21 |
| **INV-nn** | **Invariantes** — propiedades que se cumplen siempre, en todos los casos | §4 | INV-19 |
| **CFG-nn** | **Configurabilidad** — qué se cambia sin tocar código y cómo | §5 | CFG-09 |
| **PRE-nn** | **Presupuestos** de desempeño y coste — «si no se cumplen, la solución no vale aunque razone bien» | §6 | PRE-09 |
| **AR-nn** | **Anti-requisitos** — lo que el sistema NO es | §7 | AR-07 |
| **REQ-nn** | Las filas del **banco**: el contrato de aceptación | §8 | REQ-61 |
| **ADR-nnn** | Decisiones de arquitectura, con contexto y descartes | `decisiones.md` | ADR-048 |
| **POC-nnn** | Decisiones de la PoC | `decisiones-poc.md` | POC-005 |

El documento de requisitos tiene diez secciones; las 1 a 9 son **normativas**, la 10 son
pendientes y es informativa. §9 es el modelo de sala.

## Los diez que hay que poder usar activamente

| ID | En una línea | Para qué lo usas |
|---|---|---|
| **ADR-035** | Dos ámbitos: **motor cognitivo** = norma íntegra; **construcción** = libertad de quien construye. **El banco es juez único.** Y «**no hay inviabilidad sin identificador**»: toda alegación se formula contra filas del banco | **La pieza central.** Resuelve requisitos-frente-a-arquitectura y cierra el «eso no se puede» |
| **REQ-01** | Eventos convergentes de fuentes independientes, sin evento autorizado en agenda → emite detección con hipótesis en competencia, grados y evidencia trazada, antes de la detección humana de referencia | Primera fila de tu ablación |
| **REQ-02** | Los mismos eventos, **pero hay una mascletà en la agenda** → no interrumpe a nadie; registra «evento esperado» con la alternativa descartada. Métrica: **0 interrupciones en todo el banco** | Segunda fila. La que demuestra que no es un dashboard de alertas |
| **INV-01** | Ninguna acción operativa se ejecuta sin **validación humana explícita**; la autonomía es de análisis y propuesta. Tres formas declarables: individual, en bloque y **reforzada** (N firmas, ADR-042) | El invariante que lo gobierna todo |
| **INV-02** | Toda conclusión mostrada es trazable a eventos, conocimiento, **versiones** de doctrina y configuración, y políticas | Trazabilidad. Nuestro «100 % de trazabilidad» de julio |
| **INV-04 / ADR-028** | Todo juicio lleva grado de confianza explícito, y **el grado es siempre cálculo determinista**; los umbrales viven en doctrina, no en código | La frontera determinista/generativo |
| **ADR-047** | El motor publica **funciones de catálogo** cerradas; el pack instancia y rellena parámetros. El **combinador de grados** es única y obligatoria en todo despliegue | Cierra el hueco que señalábamos: el grado ya tiene dueño |
| **ADR-048** | **Política de verificación**: la doctrina puede otorgar ejecución acotada a lo que la capa generativa nombra; el resultado mueve el grado por el combinador, con techo bajo el de un discriminante. **Cero cláusulas por defecto** | La pieza a vigilar. Única vía del modelo al número |
| **CFG-04** | **Ningún cambio de doctrina se activa sin pasar el banco** y el de no-regresión, sobre el conjunto de packs activos | Por qué el banco es la puerta y no un adorno |
| **AR-06** | **No es un desarrollo a medida por caso de uso**: si un caso nuevo del mismo dominio exige programar, la implementación ha incumplido | El argumento contra «esto acaba siendo consultoría» |

## Los que puedes oír y conviene reconocer

**Invariantes.** INV-05 reproducibilidad (el replay produce las mismas salidas en las capas deterministas) · INV-07 minimización (los datos maestros se quedan en su origen) · INV-09 degradación elegante (perder una fuente reduce cobertura y lo señala; nunca inventa) · INV-10 origen etiquetado determinista/generativo · INV-11 un hecho físico no genera duplicados hacia el operador · INV-15 quien compite no arbitra · INV-16 obligaciones de atención humana con plazo, **con independencia del grado** · INV-17 cuarentena de señales desconocidas · INV-19 biometría y analíticas sensibles **excluidas por defecto**.

**Capacidades.** C-02 desviaciones sobre baselines (estadística y **declarada**) · C-03 correlación, incluida la **negación temporal** (el evento esperado que no ocurre) · C-04 hipótesis en competencia con priores de doctrina · C-05 búsqueda activa de discriminantes antes de emitir · C-09 política de interrupción · C-12 fusión en el objeto único de su peldaño · C-16 captura de correcciones del operador · C-19 comprensión de señales · C-21 revisión post-incidente.

**Presupuestos.** PRE-02 del evento que despierta al razonador a la propuesta ante el operador (nuestro «< 60 s») · PRE-03 antelación frente a la **detección humana de referencia**, con el objetivo declarado **por caso operativo** — 20 min es el valor de diseño del caso de aglomeraciones, no una constante universal · PRE-05 invocaciones generativas acotadas y presupuestadas · PRE-06 el banco completo ejecutable acelerado.

**Anti-requisitos.** AR-01 no es un chatbot sobre los datos · AR-02 no es un dashboard de alertas por umbral · AR-03 el razonador no es un LLM puesto a decidir ni un sistema experto de la generación anterior · AR-05 no es respuesta automatizada: propone, el humano dispone · AR-07 no existe el copiloto por operador.

**ADR de vocabulario**, si sale el tema: ADR-001 escalera de objetos y el término detección · ADR-002 cuadro de situación · ADR-003 nombres de componentes y cargos · ADR-013 el ciclo de vida del incidente empieza en la calificación · ADR-015 pack (runtime) y vertical (comercial) · ADR-022 bipartición de la configuración.

**ADR del delta reciente:** ADR-040 eclipse de sala y disyunción · ADR-042 validación reforzada · ADR-043 calificación reconocida del origen · ADR-044 heurísticas de razonamiento · ADR-045 relectura del plan · ADR-046 ciudad de referencia.

## Si te dice… contesta

| Si José dice | Cita |
|---|---|
| «Tengo que llamarlo requisitos o me quitan la arquitectura» | **ADR-035**. Ya tienes la partición y es mejor: el motor es norma y es tuyo; la construcción es su libertad; el banco es juez único. Y ADR-035 (4) les prohíbe decir «no se puede» sin identificador |
| «¿No es esto un envoltorio alrededor de un LLM?» (o lo dice Paradigma) | **AR-03** + **INV-04** + **ADR-047**: lo que decide es determinista y reproducible, y el combinador de grados es único y obligatorio. **AR-02**: una alerta sin hipótesis en competencia no cumple |
| «Esto acabará siendo consultoría a medida» | **AR-06** + **CFG-01** + la métrica de **novedad de catálogo por pack** de ADR-047: el catálogo crece con la hoja de ruta del producto, no con la cartera de clientes |
| «¿Por qué solo dos escenarios de ablación?» | El núcleo lo defines tú (puerta de tu fase 1); la **instrumentación de ablación** se concentra donde está el poder discriminante. **REQ-01** y **REQ-02** prueban las dos mitades: sin la pieza, o ciego o histérico |
| «¿Y el RGPD?» | **INV-07** e **INV-19** están; lo que falta es el **mecanismo** de retención y purga — la única consulta abierta de §10. Y ahí tenemos material que el canon no tiene |
| «El banco ya está» | Las 61 filas normativas sí; `banco/instancias/` y `banco/suites/` están **vacías** y **POC-006 no existe** todavía. Sin instancias no hay juez |
