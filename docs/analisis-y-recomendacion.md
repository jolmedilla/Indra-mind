# Análisis del material de IndraMind y recomendación

> **Fecha:** 2026-07-15 · Redactado tras analizar la reunión con José Ruíz (vídeo +
> transcripción del 14/07), las dos conversaciones de José con Claude/Fable
> (rol-play + «Modelo de razonamiento en tres niveles — Caso València») y el WhatsApp
> posterior.
>
> Revisa y **confirma** la línea base sin sesgo de
> [`arquitectura-opinion-inicial.md`](arquitectura-opinion-inicial.md) y
> [`fontaneria-de-datos.md`](fontaneria-de-datos.md). Contexto fáctico en
> [`vision-producto.md`](vision-producto.md).
>
> **Pasada de vocabulario (2026-08-01, revisada el mismo día).** Este documento se escribió sin
> ver el registro de decisiones de José, que corría en paralelo. Se ha alineado su terminología
> con el canon vigente del repo `indramind-poc` (ADR-001, 003, 013, 015) **solo donde el canon
> es normativo**: el ámbito del **motor cognitivo**. Los nombres de piezas de **construcción**
> son nuestros y se conservan, porque ADR-035 declara ese ámbito libre. **Ninguna afirmación
> técnica se ha reescrito:** donde el canon decidió después algo distinto de lo que aquí se
> propone, el texto se conserva y se marca con **[DIVERGENCIA n]**, cuyo desarrollo está en
> [`divergencias-con-el-canon.md`](divergencias-con-el-canon.md).

## 1. Resumen ejecutivo (lo que llevaría a la reunión)

1. **El producto es viable y el mercado es real.** Nada de lo que se promete en las demos
   es «física nuclear»: es correlación multi-fuente + razonamiento lateral acotado + una
   buena capa de presentación. Un LLM actual ya hace el razonamiento; el valor está en la
   **arquitectura que lo orquesta en tiempo (casi) real y lo hace fiable, trazable y
   soberano**. **[DIVERGENCIA 3]** — el canon es más restrictivo con el papel del LLM.

2. **Mi hipótesis sin sesgo se confirma:** el bloqueo de Paradigma es el patrón de
   «arquitectura organizada alrededor de una tecnología (ontologías) en vez del dominio», y
   «empezar la casa por el tejado» (30 personas repartiendo módulos —GIS, misiones, Kafka—
   sin haber definido siquiera qué es un *incidente*).

3. **El debate ontologías/grafos tiene una respuesta limpia y defendible** (sección 3), y
   resolverla es la palanca que desbloquea el proyecto. Resumen: **sí a un modelo de datos
   canónico mínimo; no a la ontología como motor de razonamiento**.

4. **Hay una arquitectura de referencia sólida ya esbozada** (el modelo de tres niveles que
   José trabajó con Fable) que coincide casi punto por punto con mi línea base. La hago mía,
   con matices (sección 4).

5. **El camino correcto es una PoC vertical fina, estilo startup, apoyada en Claude**, sobre
   el caso de València (aglomeraciones no planificadas). Es el «plan B» que José ya intuye, y
   es exactamente lo que yo recomendaría (sección 6).

## 2. Diagnóstico de la situación de Paradigma

Lo que sabemos del enfoque actual (aún sin ver su documentación en detalle, prometida para
dentro de ~2 semanas):

- Lo lidera un ingeniero **muy bueno pero no experto en IA**, procedente de Stratio (Big Data),
  que empezó ~octubre y **rescató las ontologías de su experiencia previa**. José sospecha
  —con criterio— que es *«darle martillazos a un sistema hecho para otra cosa»*.
- El sistema está orientado a **investigación forense profunda y offline** («¿esto está
  relacionado con...?», mucho tiempo, mucha profundidad), no a **asistencia cognitiva en
  tiempo casi real**, que es lo que el producto necesita.
- 30 personas, ~6 meses, ~3 M€, **nada funcional**; equipo repartido por módulos sin foto
  global.

**Veredicto (impartial, que es el valor que aporto):** no es que las ontologías «no sirvan
para nada» —eso sería injusto y me haría perder autoridad ante un buen defensor de ontologías—.
Es que están en el **centro de gravedad equivocado** (razonamiento) y a la **escala
equivocada** (mega-ontología pesada), para un problema cuyo razonamiento es **sencillo y
lateral**, y cuya dificultad real es **integrar muchas fuentes y reaccionar rápido**. La
ineficiencia de la ontología se pagaría en un entorno que no la necesita.

## 3. El debate ontologías / grafos, resuelto (para ganar el *challenge*)

Este es **el** punto que José necesita zanjar. Postura (coincide con la de Fable en el hilo, y
es la mía):

- **La ontología NO es para el razonamiento.** El LLM ya sabe qué es un hidrante, que el humo
  precede al fuego o que hay que llamar al dueño de un almacén que arde. Construir una
  ontología pesada para «enseñarle el dominio» es resucitar un paradigma de los 80–90
  (razonamiento simbólico, árboles hechos a mano) que **los transformers ya superan**. En eso
  José, su amigo y yo coincidimos, y hay que decirlo con autoridad.

- **La ontología SÍ es para los datos**, y ahí es imprescindible —pero rebautizada para
  quitarle la carga tóxica del término: **«modelo de eventos y entidades»**. Es el contrato
  que normaliza fuentes heterogéneas (cada cámara, CAD, sensor, SOC con su esquema) en
  **eventos tipados con tiempo y geometría**. Sin eso, una regla como *«vehículo sale del
  polígono <10 min antes de la primera llama»* no se puede ejecutar de forma determinista, ni
  reproducir en *replay*, ni auditar ante un juez. **Mínima** (evento, sensor, lugar,
  vehículo, persona, caso, unidad) y a crecer; huir de la mega-ontología de 5 años.

- **El «grafo» es una capacidad, no una tecnología.** Lo que se necesita es: identidades
  resueltas entre sistemas (que «el titular de la Kangoo» y «el co-investigado de 2023» sean la
  misma persona en dos bases), relaciones tipadas, consultas de recorrido (la red de un
  sospechoso a 2–3 saltos) y **procedencia**. Eso a escala ciudad **puede correr sobre
  PostgreSQL** con buenas claves foráneas y ganarle el *benchmark* a Neo4j. La elección de
  almacén debe ser una **tarea de *benchmark* de la PoC, no un dogma previo**: la PoC de
  València puede correr entera sobre SQLite/Postgres, demostrando que la arquitectura depende
  de **funciones** (esquemas, identidad, relaciones, procedencia), no de tecnología de grafos.

- **No volcar todo al grafo** (el «proyecto de grafo» que muere a los 2 años). Regla de
  reparto: **el grafo/registro guarda identidad y relaciones estables; los sistemas de origen
  guardan los valores; la situación guarda el ahora; lo pesado o sensible se federa bajo
  demanda con puntero.** Esto además es **minimización de datos** = soberanía y RGPD *by
  design*: no replicas el padrón ni la DGT; los consultas con auditoría y el dato sigue en su
  dueño. Ese argumento «gana la reunión» con un DPD de cliente público.

**Frase para la reunión:** «No me reafirmo en *ontologías y grafos*; me reafirmo en
*esquemas, identidad, relaciones y procedencia*. Eso lo necesitamos sin discusión. Lo que
sobra es la ontología como motor de razonamiento y la mega-ontología como almacén.»

## 4. Arquitectura recomendada

La buena noticia: **ya existe una arquitectura de referencia sólida** en el documento «Modelo
de razonamiento en tres niveles» que José trabajó con Fable, y **coincide casi punto por
punto con mi línea base sin sesgo**. La adopto. Síntesis:

> Nota de ámbito: el canon retiró después «arquitectura de referencia» como **nivel intermedio
> del canon** —una capa apartable entre la norma y la libertad— y dejó dos ámbitos con nombre
> vinculante: el **motor cognitivo**, que es la norma íntegra, y la **construcción**, que es
> libertad de quien construye con el banco de escenarios como juez único (ADR-035). Lo que
> sigue pertenece, en esos términos, unas veces al motor y otras a la construcción.

### 4.1 Percepción compartida (Nivel 0) — la fontanería

Nadie razona sobre la fuente. Cada fuente se procesa **una vez** y emite **eventos tipados**
(entidad, tiempo, geometría, valor, confianza) contra el modelo de eventos mínimo. Es la
[`fontaneria-de-datos.md`](fontaneria-de-datos.md): conectores → normalización → calidad/
dedup/identidad → *streaming* → estado. **Es el 70–80% del trabajo real y donde Paradigma no
está poniendo el foco.**

### 4.2 Los tres niveles de razonamiento

| Nivel | Razona sobre | Doctrina | Origen |
|------|--------------|----------|--------|
| **1 · Razonador de dominio** | El mundo: ¿qué pasa y por qué? ¿con qué confianza? | Detección/investigación: patrones, hipótesis, discriminantes | **De fábrica, transferible entre clientes** |
| **2 · Razonador de incidente** (uno por incidente) | El incidente: ¿qué hago, cuándo aviso, qué propongo? | Respuesta: SOP, misiones, escalado, interrupción al operador | **Del cliente** (sus procedimientos) |
| **3 · Razonador de sala** (uno por sala/ciudad) | La operación: ¿qué importa ahora? ¿a quién asigno? | Mando: saliencia, arbitraje de recursos, carga del operador | **Del cliente** (sus criterios de mando) |

> Los nombres de la columna «Nivel» son los del canon (ADR-003), que rebautizó los componentes
> máquina precisamente porque «director» y «coordinador» se confundían sistemáticamente con
> personas. Los cargos humanos que les hacen espejo son el operador, el mando del incidente y
> el jefe de sala: la máquina prepara y propone, la persona decide.

Esto encaja con el modelo de fusión de datos JDL de mi baseline (L1 objeto → L2 situación →
L3 impacto → L5 interacción) y resuelve limpiamente la confusión de José: **el mapa, las
misiones y la UX las decide el razonador de sala sobre un catálogo pequeño de objetos
operativos (unidad, misión, ruta, zona, riesgo, decisión, hipótesis) — 10–12 tipos**. El
razonador de sala «no sabe qué es un dron»: puntúa relevancia por tipo, fase y rol. Por eso su
pack es el más pequeño, no el más grande (30–50 reglas cubren una sala).

### 4.3 Principios que hacen esto fiable (y vendible)

- **Escalera de atención:** percepción barata siempre encendida → *baselines* estadísticos →
  correlación determinista (CEP) → capa cognitiva (LLM) **solo ante evento candidato** →
  razonamiento multi-hipótesis solo en incidentes confirmados. **El LLM no vigila: razona
  cuando algo lo merece.** (Esto responde a la duda de José sobre coste y tiempo real.)
- **El *trigger* es una suscripción:** cada razonador de dominio declara a qué eventos se
  despierta. Sobre la misma fuente, incendios se suscribe a {humo, llama...} y accidentes a
  {ralentización...}. Añadir un razonador de dominio es **desplegar configuración, no software**.
- **Fusión:** una pizarra compartida + un correlador que agrupa por
  espacio, tiempo y entidades comunes evita incidentes duplicados. Ahí vive la conciencia
  situacional. **[DIVERGENCIA 2]** — el canon prohíbe relacionar antes de la calificación.
- **Los packs = doctrina procedimental** (no enseñar el dominio): disparadores, hipótesis,
  necesidad de información por hipótesis, expansiones de datos autorizadas + base legal, umbral
  de interrupción. Los disparadores/políticas corren en **capa determinista (auditable)**; las
  hipótesis y la narrativa, en la **capa cognitiva**.
- **Control humano y trazabilidad** desde el día uno: toda misión es propuesta; toda
  conclusión enlaza los eventos y el conocimiento que la sostienen.
- **Modelo GPS:** el sistema propone; el operador confirma; se recalcula según lo que el
  operador elige. Cada *insight* lleva su *scoring* de confianza.
- **Configuración declarativa sobre motor genérico:** los razonadores de dominio no son N motores
  distintos, son la misma maquinaria con distinta configuración (los «packs de razonamiento» /
  «pastillas de Matrix» de José). Requisitos = **pares escenario → comportamiento esperado**,
  testeables por simulación y *replay*.

## 5. Las dudas técnicas de Juanjo, afinadas

Dos matices sobre lo que planteé en la reunión, para llegar más afilado:

- **Compactación de contexto → no es (solo) «que quepa en memoria».** Mi planteamiento en la
  reunión (dimensionar cada agente para que su contexto no se compacte y no pierda lo crítico)
  apunta bien pero hay una solución **más robusta**: los razonadores deben ser **sin estado
  entre invocaciones**. Todo lo que importa (hipótesis, evidencias, confianzas, decisiones) se
  escribe como **datos estructurados** en la situación y el expediente; el contexto de cada
  invocación se **reconstruye desde ahí**, acotado y fresco. No hay conversación larga que
  compactar porque no hay conversación larga: hay estado estructurado + ventanas efímeras. Lo
  que «nunca se puede perder» vive en **campos durables del expediente**, no en una ventana de
  contexto. La jerarquía de agentes ayuda, pero la clave es **externalizar el estado**.

- **LLM propio / soberanía → válido, con matiz.** No depender de un modelo de pago que «te lo
  ponen y te lo quitan» es correcto para infra crítica y Dubai (residencia del dato, corte de
  servicio). Pero: (a) los modelos abiertos auto-hospedados (Qwen, DeepSeek, Llama) tienen
  **brecha de capacidad** frente a los frontera; (b) la arquitectura debe ser **agnóstica al
  modelo** para poder **empezar la PoC con una API frontera** (Claude) e ir a auto-hospedado en
  producción sin rediseñar. Esto conecta con el principio «evitar *lock-in* de una sola
  tecnología»: el modelo es una pieza reemplazable, no el cimiento.

## 6. La PoC recomendada (el «plan B»)

Coincido con el instinto de José: **equipo pequeño (3 personas) + Claude, julio–agosto**,
estilo startup, para demostrar viabilidad y tener una **v0.1 del producto** antes de/junto a la
demo de Paradigma de final de julio. Caso: **València — detección de aglomeraciones no
planificadas** (PoC ya contratada, pendiente de firma).

Arquitectura mínima de la PoC (rebanada vertical de extremo a extremo):

1. **Simulador de fuentes** con *slider* de *fast-forward*: genera eventos sintéticos (ocupación
   de vídeo, flujos de metro, acústica, convergencia social) según un guion temporal. Resuelve
   que las fuentes reales de València son «peculiares» y que hay permiso para fabricar datos.
2. **Capa de percepción → eventos tipados** (modelo de eventos mínimo) sobre esos datos.
3. **Baselines + CEP determinista** que detectan la anomalía (p. ej. ocupación +7,6σ) y
   despiertan al razonador de dominio.
4. **Un razonador de dominio** (pack «aglomeraciones»): suscripciones, hipótesis en competencia,
   discriminantes, proyección («75% de aforo ~20:15»), emisión con confianza y trazabilidad.
5. **(Opcional, fase 2 de la PoC) razonador de incidente**: ciclo de vida + misiones propuestas.
6. **Estado compartido** sobre **SQLite/Postgres** (no grafo) — demuestra la tesis de la
   sección 3.
7. **Interfaz** tipo panel *ultrawide*, siguiendo la estética de sus demos (ver
   `preparacion-reunion.md` y los fotogramas del vídeo).

Éxito medido por **escenarios conductuales** (REQ-01…06 del doc de tres niveles): antelación
≥20 min, falsos positivos < umbral, 100% de trazabilidad, etc. — métricas, no opiniones.

> Estas tres métricas sobrevivieron al canon casi literalmente: la antelación mínima de veinte
> minutos sobre la detección humana de referencia y el enlace de toda conclusión con los
> eventos que la sostienen son hoy presupuesto e invariante del producto (PRE-03, INV-02). El
> banco vigente, en cambio, ya no va de REQ-01 a REQ-06 sino de **REQ-01 a REQ-58**.

## 7. Modelo de negocio (secundario, pero con respuesta)

José quiere cobrar por «packs de razonamiento» (config IP) + integración (una vez) +
mantenimiento (recurrente).

> El canon resolvió después esta pieza en contra de la formulación de aquí: se cobra por
> **vertical** —el empaquetado comercial por dominio, que incluye packs, plantillas, mapeos e
> implantación— y **nunca por pack**, para que las unidades de precio queden desacopladas de
> las unidades de runtime y la arquitectura pueda refactorizar sin tocar facturas (ADR-015).
> El renombrado de la etiqueta del tarifario quedó aprobado por José el 23-jul-2026.

Mi matiz de la reunión sigue en pie: **no se puede *estrangular*
por precio** (recortar sugerencias a quien paga menos) porque lo que se despliega depende de los
datos y la estructura del cliente, no de su tarifa. Pero **sí hay recurrente defendible**:
(a) los packs/doctrina como propiedad configurable y versionada; (b) la **«consultoría
cognitiva»** de volcar la doctrina del cliente (la de incidente y la de sala) + curación continua;
(c) mantenimiento = el bucle de mejora (correcciones del operador → doctrina versionada). El
argumento de soberanía refuerza el recurrente: implantar IndraMind es **codificar cómo opera
esa organización, bajo su control**.

## 8. Riesgos y qué NO prometer

- No prometer «tiempo real» en segundos si no hace falta: en una DANA hubo **horas**; «casi
  tiempo real / minutos» es suficiente y más honesto. (Pero tener la escalera de atención lista
  para cuando un caso sí exija segundos.)
- No prometer autonomía de actuación: **análisis autónomo, actuación validada**. Es
  responsabilidad legal y de seguridad.
- No caer en el *hype*: gran parte de la «magia» es un LLM competente + buena orquestación +
  buena UX. Vender eso con humildad técnica es más creíble que vender «inteligencia viva».
- Cuidado con auto-hospedar modelos débiles y prometer capacidad frontera.
- La política es el riesgo mayor, no la técnica (ver `vision-producto.md`): Paradigma «manda»
  hoy; mi papel es dar autoridad técnica imparcial para desbloquear, no ganar una guerra.
