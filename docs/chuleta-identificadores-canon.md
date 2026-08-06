# Chuleta de identificadores del canon

> **Para la conversación con José · 6-ago-2026** · Contra el canon en `1a69d09` (requisitos
> v0.5.1, ADR-048). No es un resumen del canon: es lo justo para citar bien y no quedarse en
> blanco. Lo que hay que leer de verdad es [`veredicto-sobre-el-canon.md`](veredicto-sobre-el-canon.md).

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
