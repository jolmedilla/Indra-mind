# Arquitectura, a nivel de ingeniero

> **Fecha:** 2026-07-15 · Material de apoyo para entender a fondo (y poder presentar) la
> arquitectura. Desarrolla [`analisis-y-recomendacion.md`](analisis-y-recomendacion.md) §4 y
> [`fontaneria-de-datos.md`](fontaneria-de-datos.md) con componentes concretos, formas de
> datos y flujo. Pensado para responder: ¿qué implemento? ¿qué agentes hay? ¿qué es la
> fontanería? ¿dónde encajan las ontologías?
>
> **Pasada de vocabulario (2026-08-01, revisada el mismo día).** Este documento se escribió sin
> ver el registro de decisiones de José, que corría en paralelo. Se ha alineado su terminología
> con el canon vigente del repo `indramind-poc` (ADR-001, 003, 013, 015) **solo donde el canon
> es normativo**: el ámbito del **motor cognitivo**. Los nombres de piezas de **construcción**
> —pizarra, almacenes, topología, la propia palabra «arquitectura»— son nuestros y se conservan,
> porque ADR-035 declara ese ámbito libre. **Ninguna afirmación técnica se ha reescrito:** donde
> el canon decidió después algo distinto de lo que aquí se propone, el texto se conserva y se
> marca con **[DIVERGENCIA n]**, cuyo desarrollo está en
> [`divergencias-con-el-canon.md`](divergencias-con-el-canon.md).

## 0. La idea que hay que interiorizar (corrige el modelo mental)

Es tentador imaginar «un agente IA por entidad que absorbe sus datos, y un orquestador que
correlaciona». **Ese es el anti-patrón.** La arquitectura correcta separa tres cosas que la
gente mezcla:

| Plano | Qué es | ¿IA? |
|------|--------|------|
| **Percepción** | Convertir cada *fuente* en eventos tipados | Modelos especializados (visión, acústica) + estadística. **No LLM.** Una pasada por fuente. |
| **Correlación** | Agrupar eventos en **detecciones** por espacio/tiempo/entidad | **Determinista (CEP).** Reglas. Auditable. **No LLM.** |
| **Razonamiento** | Formar hipótesis, discriminar, proponer, mandar | **LLM**, pero solo *encima* de detecciones ya correlacionadas, y por **dominio**, no por entidad |

- Las **entidades** (hidrante, cámara, sensor, vehículo) son **datos** (filas/nodos), no
  agentes. Nadie pone un LLM «sobre la cámara»: sería N inferencias por cámara (coste
  insostenible) y N realidades distintas.
- No hay un **orquestador-dios** que lo razona todo. La topología es **pizarra + bus**
  (*blackboard architecture*): un conjunto de **razonadores sin estado** que se **suscriben**
  a eventos, **leen y escriben** en una pizarra compartida, y se coordinan a través de ella.

**En una frase para la reunión:** *«Percepción compartida (barata), correlación determinista
(auditable) y razonamiento cognitivo (caro, solo cuando algo lo merece) — tres planos
separados. La IA no vigila: razona.»*

---

## 1. La «fontanería de datos», concreta

**Qué es:** todo lo que ocurre entre «hay una fuente ahí fuera» y «hay un evento limpio,
tipado y correlacionable en el estado». Es el 70–80 % del trabajo real.

### ¿Hacemos un modelo de datos nuevo en cada cliente? **No.**

- Construyes **un modelo canónico (el núcleo) UNA vez.**
- Por cliente haces dos cosas, ninguna de ellas «reescribir el motor»:
  1. **Extender** el modelo con unos pocos tipos propios del dominio → **configuración**.
  2. **Instanciar** el modelo con las entidades reales del cliente → **datos** (se cargan de
     sus sistemas: inventarios, GIS, catastro), no se programan a mano.

### ¿Modelamos las entidades de cada caso (hidrantes, cámaras, sensores)? **Sí, pero como datos.**

Dos niveles, no confundir:

- **Tipos** (esquema, casi 100 % reutilizable entre clientes):
  `Sensor, Camara, Hidrante, Vehiculo, Persona, Unidad, Zona, Edificio, Incidente, Mision…`
- **Instancias** (datos del cliente): «el hidrante #123 en la calle X», «CAM-217 cubre la
  zona A». Vienen de **sus** sistemas; se cargan una vez y se mantienen frescas por **eventos
  de cambio** (CDC), no por volcados masivos.

### Componentes de software que implementas en la fontanería

```
FUENTE ──▶ [1 Conector] ──▶ [2 Normalizador] ──▶ Evento tipado ──▶ [4 Bus]
                                     ▲                                  │
                              [3 Modelo canónico]                       ▼
   [P Percepción: analíticas por fuente] ─── emiten eventos ──▶ [4 Bus]
                                                                        │
                                          [5 Calidad/identidad/geo] ◀───┘
                                                                        │
                                                                        ▼
                                            [6 Estado: situación · registro · series]
```

1. **Conectores / adaptadores** (uno por *protocolo* de fuente; catálogo reutilizable):
   MQTT/OPC-UA, RTSP+VMS, REST/webhooks, SNMP, APIs sociales, CAD/112. Cada uno resuelve
   auth, suscripción/polling, reconexión, *buffering*, *backpressure*.
2. **Normalizadores** (config declarativa por fuente): mapean esquema **y semántica** de la
   fuente al Evento canónico. «El código 3 de esta fuente = incendio». **Config, no código.**
3. **Modelo canónico** (el «esquema de eventos y entidades» — lo que mal se llama «ontología»):
   ```yaml
   Evento:  { id, tipo, entidad_ref, geom, t, valor, confianza, fuente }
   Entidad: { id, tipo, atributos, geom, ref_sistema_origen }  # puntero, no copia
   Relacion:{ origen, tipo, destino }   # p.ej. camara COVERS zona
   ```
4. **Percepción** (analíticas **por fuente**, no agentes-por-entidad): visión (humo/ocupación),
   acústica, telemetría. Modelos especializados + *baselines* estadísticos. Baratas,
   siempre encendidas, **una pasada por fuente**. Emiten eventos tipados. **Aquí no hay LLM.**
5. **Calidad / identidad / geo:** validación, **deduplicación** (mismo suceso por dos
   fuentes), **resolución de entidades** («la persona de la llamada» = «la de la cámara»),
   geocodificación, unificación de coordenadas (CRS), datos tardíos/desordenados.
6. **Bus + estado** (sección 3).

**El punto de producto:** toda la variedad por cliente cae en **3 sitios configurables** —
qué conectores, qué tipos de evento/catástrofe (taxonomía), qué reglas/packs. El motor no
se toca. Eso convierte esto en **producto** (se amortiza), no en integración a medida.

---

## 2. Integración y correlación: qué es cada cosa en la arquitectura

Aquí se responde tu pregunta clave. El flujo, paso a paso:

### 2.1 Percepción (determinista, por fuente)
Cada fuente pasa **una vez** por su analítica → eventos tipados:
`{tipo: ocupacion_zona, entidad: zona/plaza_A, valor: 3900, baseline: 1450±320,
desviacion: +7.6σ, confianza: 0.87, t: 18:42}`. Sin IA generativa. Sin agentes.

### 2.2 Correlación (determinista, CEP) — **aquí vive «la fusión»**
Un **motor de correlación de eventos complejos (CEP)** agrupa eventos por **espacio + tiempo
+ entidad común** y forma **detecciones**:
> «ocupación +7.6σ **∧** flujo_metro +58 % en estación que alimenta la zona **∧** acústico
> sostenido — misma zona, ventana de 20 min → **detección: aglomeración**».

Es **reglas**, no LLM: rápido (miles de eventos/s), reproducible en *replay*, explicable ante
un juez. Las «suscripciones» de un pack son, literalmente, reglas de este motor.

> Este documento decía originalmente «incidentes candidatos». El canon reserva «incidente»
> para lo que nace de un acto humano de calificación, de modo que lo que la máquina forma aquí
> es una **detección**, el peldaño de la escalera que va entre el evento y el incidente
> (ADR-001, ADR-013). El renombrado no cambia el mecanismo.

#### Los baselines: qué son y de dónde salen

Entre la percepción y el CEP hay una **capa de baselines / anomalía** (determinista, **no IA**).
Un *baseline* es el **valor/rango normal esperado** de una métrica en un contexto: la ocupación
normal de la plaza A un jueves 18:30–19:00 es `1450 ± 320`; medir 3900 son `+7.6σ` → anomalía.
La percepción mide el valor bruto, la capa de baselines lo compara y **emite el evento ya con la
desviación** (`{valor, baseline, desviacion_σ, confianza}`), y el CEP dispara sobre umbrales de
desviación (`> 2.5σ`). Es la escalera **percepción → baselines → CEP**.

¿De dónde salen los baselines? **No** son una especificación que dé el cliente. Son **datos/
modelos que el producto computa y mantiene**, por *instancia* (sensor/zona) y *franja* (día,
hora, festivos):
1. **Sembrados de histórico:** con el histórico de sensores del cliente (o un periodo de
   calibración) se calculan estadísticamente (media/desviación, o modelos temporales-estacionales).
2. **Aprendidos/actualizados en operación:** derivan con el tiempo (obras, cambios de aforo);
   se recalculan con ventanas móviles. **Es parte del mantenimiento recurrente** — donde está
   el negocio.

En la **PoC de València** (datos sintéticos) los baselines se fijan desde el «modo normal» del
simulador o se *hardcodean*.

### 2.3 Razonamiento (LLM) — **encima de la detección, por dominio**
Solo cuando hay una detección se **despierta el razonador de dominio** (el que se haya
suscrito a ese patrón). El razonador de dominio:
- **genera y compite hipótesis** [concentración espontánea, evento autorizado, salida de
  espectáculo, flujo comercial],
- **consulta discriminantes** (agenda de eventos, cartelera) para descartar,
- **proyecta** (flujo neto → «75 % de aforo ~20:15»),
- **emite la detección** con confianza y **trazabilidad** (qué eventos y qué
  conocimiento la sostienen). **[DIVERGENCIA 3]** — quién escribe el grado de confianza.

Aquí es donde el LLM aporta: hipótesis y narrativa explicable. Lo determinista (disparadores,
políticas) corre fuera del LLM.

### 2.4 ¿Y el «orquestador»? No es un LLM que correlaciona
La coordinación es por **pizarra + bus**:
- **Fusión:** si dos razonadores de dominio emiten sobre lo mismo, un correlador agrupa
  por espacio/tiempo/entidad → **uno**, no dos alertas fantasma. **[DIVERGENCIA 2]**
- **Razonador de incidente** (uno por incidente): recibe la detección calificada, coordina el
  ciclo de vida y **propone misiones** (no razona sobre la plaza; razona sobre la operación).
- **Razonador de sala** (uno por sala): prepara el arbitraje entre incidentes y la saliencia
  (qué se ve), que decide quien tiene el mando.

Ninguno «absorbe datos crudos de entidades»: todos leen/escriben **estado estructurado**.

### Traducción directa de tu intuición

| Tu formulación | Corrección / a qué se traduce |
|---|---|
| «sub-agentes IA razonan sobre cada entidad» | Analíticas **deterministas por fuente** (no IA, no por entidad) → eventos |
| «absorbiendo datos propios de cada una» | Los datos de entidad viven en el **registro/estado**; los razonadores los **consultan**, no los ingieren en bruto |
| «orquestador recibe alto nivel y correlaciona con playbooks» | La correlación es **CEP determinista**; el **pack** aporta las **suscripciones** (disparadores) y la **doctrina** de hipótesis; el «orquestar» es pizarra+bus, no un agente monolítico |

---

## 3. Las ontologías, en nuestro caso

**Qué SÍ:** un **esquema mínimo, versionado y gobernado** de *eventos y entidades* (con tiempo
y geometría). En nuestro caso:
- **Tipos de entidad:** `Sensor, Camara, Hidrante, Vehiculo, Persona, Unidad, Zona, Edificio,
  Incidente, Mision` (~10–15 núcleo; se extiende por dominio).
- **Tipos de evento:** `humo_detectado, ocupacion_zona, flujo_salida_estacion,
  acustico_sostenido, convergencia_social, anomalia_temperatura, intrusion…`
- **Relaciones (la «capacidad grafo»):** `camara COVERS zona`, `estacion FEEDS zona`,
  `unidad BELONGS_TO turno`, `persona OWNS vehiculo`, `hidrante LOCATED_IN calle`.

**Para qué:** para que la **correlación determinista** y la **trazabilidad** funcionen. La
regla «vehículo sale <10 min antes de la primera llama» necesita eventos tipados con tiempo y
geometría. Sin esquema, no hay correlación auditable.

**Qué NO:** una ontología pesada OWL / lógica descriptiva con motor de inferencia simbólico
para «enseñar el dominio». El LLM ya sabe qué es un hidrante. **Ese es el error de Paradigma.**

**Implementación:** puede ser **tablas de Postgres** + un sobre de evento tipado. No hace
falta un *triplestore* ni Neo4j. La elección de almacén es un **benchmark de la PoC**, no un
dogma. Por eso proponemos **rebautizarlo**: «modelo de eventos y entidades» + «registro de
identidades y relaciones». Mismo contenido, sin la alergia al término.

**Frase:** *«El grafo/ontología es una capacidad —identidad, relaciones, procedencia— no una
tecnología. En València puede correr sobre SQLite.»*

---

## 4. Arquitectura: qué componentes implemento

> Nota de ámbito. ADR-035 retiró «arquitectura de referencia» como **nivel intermedio del
> canon** —una capa apartable a medio camino entre norma y libertad— y dejó dos ámbitos: el
> **motor cognitivo**, que es la norma íntegra, y la **construcción**, que es libertad de quien
> construye con el banco de escenarios como juez único. Lo que sigue es, en esos términos,
> **construcción**: es decir, terreno explícitamente libre. Que el canon retire ese nivel no
> significa que aquí no haya arquitectura ni que haya que dejar de llamarla así; significa que
> esta arquitectura no vincula a nadie salvo por lo que demuestre contra el banco.

Inventario de componentes (un ingeniero puede repartir el trabajo por aquí):

### A · Ingesta
- **Connector runtime** + *plugins* de conector (por fuente).
- **Servicio de normalización/mapeo** (reglas declarativas).

### B · Percepción (workers, NO agentes)
- *Workers* de visión, acústica, telemetría. Emiten eventos. Modelos especializados + baselines.

### C · Backbone
- **Bus de eventos** (topic por familia de evento). PoC: cola ligera o incluso tabla.
- **Registro de esquema** (el modelo canónico).

### D · Estado (tres memorias distintas)
- **Pizarra** (estado actual, «caliente»): incidentes, hipótesis, objetos operativos. Es la pieza
  de construcción que **materializa** el cuadro de situación del canon; no son lo mismo.
- **Registro de identidades y relaciones** (Postgres): entidades, relaciones estables, procedencia.
- **Series temporales** (histórico de sensores) con retención escalonada.
- **Pasarela de federación**: consulta a sistemas de origen **bajo demanda**, con política + auditoría (no replicar el padrón).

**Qué dato vive dónde.** Ojo: el **modelo/esquema** es transversal —vive en código / *schema
registry*, no es una fila—. Lo que se reparte son las **instancias** que lo cumplen:

| Qué dato | Dónde vive | Ritmo de cambio |
|---|---|---|
| **Eventos** tipados | bus + almacén de eventos / series temporales | segundos (efímero en vuelo, durable en histórico) |
| **Entidades + relaciones** (identidad) | **registro** de identidades y relaciones (Postgres) | meses (estable, curado) |
| **Incidentes · hipótesis · objetos operativos** (el «ahora») | **pizarra** | segundos–minutos |
| **Valores pesados/sensibles** (padrón, combustible…) | **sistema de origen** (federación, puntero) | bajo demanda |

Escala de decisión: **segundos → pizarra · meses → registro · bajo demanda → federado ·
pesado/sensible → se queda donde está, con puntero**. La pizarra guarda **solo el estado
actual**, no las entidades estables ni el histórico. Y esto es, además, **minimización de datos
= soberanía / RGPD *by design***: no replicamos el padrón ni la DGT; los consultamos con
auditoría y el dato sigue en su dueño.

**Cómo se implementa la pizarra** (patrón *blackboard* de Hearsay-II: memoria de trabajo
compartida + fuentes de conocimiento —los razonadores— + un control —la escalera de atención—
que decide quién se ejecuta). Los razonadores **no se llaman entre sí**: leen/escriben la
pizarra y se despiertan por suscripción.
- **PoC:** Postgres/SQLite con tablas `incidents · hypotheses · events · entities · op_objects ·
  audit_log`, y **pub/sub** ligero para el despertar (`LISTEN/NOTIFY` de Postgres o una cola).
- **Producción:** igual, escalado — Postgres (durable/relacional) + **Redis** (estado caliente
  de baja latencia) + **Kafka** (stream); la situación es estado **materializado** sobre el log
  de eventos; el registro de identidades/relaciones puede ser Postgres o un grafo.
- **Propiedades:** durable (sobrevive a reinicios); **fuente única de verdad por incidente**
  (el *razonador de incidente* es el único escritor del objeto incidente → sin conflictos de concurrencia);
  **auditoría append-only** (cada escritura con quién/cuándo/por qué → trazabilidad); y es lo
  que permite que los razonadores sean **sin estado** (reconstruyen contexto leyendo de aquí).
  No es paso de mensajes en cadena: es **estado compartido + suscripciones**.

**Cómo se implementa el registro de identidades (sin copiar el dato).** Es una **tabla de
enlaces y punteros**, no un almacén. La resolución de identidad usa **dos identificadores con
trabajos distintos** — esta es la clave que suele confundir:

- **`match_key` — para ENLAZAR** (deduplicar/resolver): un **hash con sal** de una clave fuerte
  (DNI, matrícula…). Es **irreversible y nunca se descifra**: cuando llega una clave nueva se
  **re-hashea y se compara**. Así se afirma que es el mismo actor **sin guardar la clave en claro**.
- **`handle` — para RECUPERAR**: el identificador propio del registro **en cada fuente**
  («veh-4471 en la DGT»), guardado como puntero. La consulta federada es *«dame el registro 4471
  de la DGT»*, **no** *«dame a la persona con DNI X»*. No hace falta descifrar nada.

```yaml
entity:      { id: E-7731, tipo: persona }               # id sintético, sin nombre
match_key:   { entity: E-7731, hash: sha256(sal+DNI) }   # ENLAZAR · irreversible
entity_ref:  { entity: E-7731, fuente: DGT,       handle: veh-4471, desde: ..., confianza: 1.0 }
             { entity: E-7731, fuente: caso_2023,  handle: per-99120, metodo: match_DNI }
relacion:    { origen: E-7731, tipo: OWNS, destino: V-4482, fuente: DGT }
```

- **Excepción:** si una fuente **solo** se consulta por la clave sensible (un API que exige el
  DNI), no se puede hashear: se **tokeniza** — un token en el registro y el mapeo token↔DNI en una
  **bóveda separada, protegida y auditada** (reversible, pero aislada). Tokenización (reversible)
  vs. hash (irreversible): herramientas distintas para trabajos distintos.

**Seudonimización, no anonimización (RGPD).** Un id sintético **re-identificable** cruzando las
fuentes **sigue siendo dato personal**. El marco correcto es **seudonimización + minimización**,
no «no tenemos datos personales» (un DPD lo rebatiría). Se guarda: id sintético, hash de match,
handles, relaciones, procedencia (fuente+fecha), auditoría de accesos. **No** se guarda: nombres
ni atributos identificativos, copias de registros (padrón, DGT), histórico de la fuente. El nombre
solo se **cachea con TTL** en la situación durante un incidente activo; el registro durable nunca
lo guarda.

### E · Correlación
- **Motor CEP**: correlación espacio-tiempo-entidad → detecciones. Reglas = config.
  Motores tipo **Esper / Flink CEP / Drools Fusion** (o reglas llanas en la PoC).
- **Fusión**: dedup de detecciones de varios razonadores de dominio. **[DIVERGENCIA 2]**

### F · Razonadores (los «agentes») — servicios **sin estado**, cada uno = motor genérico + pack
- **Razonador de dominio** (N, por dominio): suscripciones → hipótesis → discriminantes →
  emisión. Respaldado por LLM. Ej.: `razonador_aglomeraciones`, `razonador_incendios`.
- **Razonador de incidente** (1 por incidente): **máquina de estados** del ciclo de vida
  (calificación→respuesta→estabilización→cierre) + **plantillas de misión** (SOP) +
  política de interrupción. LLM para síntesis/narrativa; determinista para umbrales/ciclo.
- **Razonador de sala** (1 por **sala** = centro de mando / *control room*: p. ej. el
  **CISEM de Callao** en Madrid, el **112 de la Comunitat Valenciana**, un centro de **Dubai
  Police**). Arbitra entre **todos** los incidentes que compiten por los recursos de esa sala y
  gestiona la atención de sus operadores. Es el nivel **más genérico** de los tres: opera sobre
  el catálogo de *tipos* de objeto operativo (unidad, misión, ruta, zona…), «no sabe qué es un
  dron». Sus reglas (saliencia + arbitraje) son **reutilizables**; por cliente solo se afinan
  umbrales/criterios de mando. **Implementación:** funciones de *scoring* + reglas
  condición→acción (motor tipo **Drools**, o código llano en la PoC). **LLM: el peor candidato**
  aquí — las decisiones de recursos afectan a vidas y se quieren deterministas, auditables y
  explicables; LLM solo para *narrar* la comparativa. Su *pack* (doctrina de sala) es el
  mismo artefacto lo ejecute un motor de reglas o un LLM. Nunca asigna de forma autónoma:
  genera comparativa y **escala al humano**.
- **Capa de herramientas** que los razonadores invocan (*tool use*): `consultar_registro`,
  `consulta_federada`, `run_discriminante`, `run_modelo_proyeccion`. Aquí encaja tu intuición
  de «llamar al GIS» — como herramienta con memoria de correcciones («ojo con el badén»).

> **Estado externalizado = solución a la compactación de contexto.** Los razonadores no
> mantienen conversaciones largas: escriben todo (hipótesis, evidencias, confianzas) como
> **datos estructurados** en la situación/expediente, y **reconstruyen** su contexto acotado
> en cada invocación. Lo que «nunca se pierde» vive en campos durables, no en una ventana de
> tokens. Por eso son *stateless*.

### G · Doctrina / configuración
- **Repositorio de packs**: doctrina (de dominio, de incidente, de sala), taxonomías,
  baselines, **casos razonados** (ejemplares *few-shot*), políticas. **Versionado.**
- **Banco de pruebas**: pares *escenario → comportamiento esperado*; simulación + *replay*.

### H · Presentación
- **API del cuadro de situación**: sirve objetos operativos con saliencia.
- **Frontend** (panel *ultrawide*): mapa, timeline, workspace de incidente, feed de
  sugerencias con confianza.

### I · Transversal
- **Auditoría / linaje**: cada conclusión → eventos + conocimiento; cada acceso a dato, logueado.
- **AuthN/Z, multi-tenant**.
- **Pasarela de modelos** (LLM gateway, **agnóstica al modelo**): API frontera (Claude) en la
  PoC; auto-hospedado (Qwen/DeepSeek/Llama) en producción soberana, **sin rediseñar**.

### Flujo completo (una secuencia)
```
fuente → conector → normalizador → EVENTO → bus
   └─(percepción ya emitió sus eventos)─┘
bus → CEP correlaciona → DETECCIÓN en la pizarra
   → razonador de dominio (suscrito) despierta → consulta discriminantes (federación)
   → enriquece la DETECCIÓN (hipótesis + confianza + trazas)
   → fusión dedup → operador CALIFICA → nace el INCIDENTE → razonador de incidente propone misiones
   → operador valida → razonador de sala prepara arbitraje entre incidentes / saliencia
   → API + panel renderizan
   (cada paso escribe en la pizarra + auditoría)
```

---

## 5. La rebanada vertical (PoC València), componente a componente

Objetivo: el **mínimo de extremo a extremo** que demuestra la tesis, en semanas. Caso:
**aglomeraciones no planificadas** en el centro de València.

### Qué SÍ construimos

| # | Componente | Versión mínima | Mapea a |
|---|-----------|----------------|---------|
| 1 | **Simulador de fuentes** | Script/servicio que emite eventos sintéticos en una línea temporal con *slider* de fast-forward. Sustituye a conectores + percepción. **[DIVERGENCIA 4]** | A + B |
| 2 | **Modelo de eventos mínimo** | 4–5 tipos de evento (`ocupacion_zona, flujo_salida_estacion, acustico_sostenido, convergencia_social`) + entidades (`Zona, Estacion, Incidente`) en SQLite/Postgres | C + D |
| 3 | **Baselines + CEP** | Desviación vs baseline por zona/franja + un mini motor de reglas (código llano) que dispara candidato cuando N señales convergen en espacio+tiempo | E |
| 4 | **Un razonador de dominio** (`pack aglomeraciones`) | Suscripción (la detección) → hipótesis en competencia → discriminantes (contra tablas *fake* de agenda/cartelera) → proyección (flujo neto → t a 75 % aforo) → emisión con confianza + trazas. **Claude** para hipótesis/narrativa. | F |
| 5 | **Estado** | Situación + incidente + hipótesis + auditoría en **SQLite/Postgres**. Demuestra «no hace falta grafo». | D |
| 6 | **API + panel** | Panel *ultrawide* (estética IndraMind): mapa del centro, timeline de eventos, detección con confianza y **por qué** (hipótesis descartadas), proyección | H |
| 7 | *(Opcional)* **Razonador de incidente** | Tras la calificación humana, propone 2–3 misiones desde plantilla; el operador valida | F |
| 8 | **Banco de escenarios** | El guion de València (del doc de tres niveles) corrido por el simulador; métricas de éxito | G |

### Qué NO construimos todavía
Conectores reales, analítica de vídeo real, base de datos de grafos, razonador de sala / multi-incidente,
LLM auto-hospedado, multi-tenant. Todo eso es «después».

### Stack sugerido para la PoC (rápido y Claude-driven)
- **Backend:** Python (FastAPI) o Node. **Estado:** SQLite (o Postgres). **Bus:** cola
  in-process o tabla. **Razonador:** API de Claude. **Frontend:** una web con la estética que
  ya tenemos ([`presentaciones/diagnostico-indramind.html`](../presentaciones/diagnostico-indramind.html)
  sirve de base visual).
- **Mensaje:** la PoC corre entera sin tecnología pesada → **la arquitectura depende de
  funciones (esquemas, identidad, correlación, doctrina), no de tecnología de grafos ni de un
  clúster de 30 personas.**

### Métricas de éxito (conductuales, no opiniones)
- **Antelación ≥ 20 min** sobre la detección humana de referencia.
- **Falsos positivos < umbral** pactado (p. ej. con una mascletà en agenda, NO alerta).
- **100 % de trazabilidad**: toda conclusión enlazada a eventos + conocimiento + política.
- **De señal a propuesta < 60 s** (si añadimos el razonador de incidente) — hoy PRE-02 del canon.
