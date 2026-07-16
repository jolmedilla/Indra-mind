# Opinión de arquitectura — línea base sin sesgo

> **Fecha:** 2026-07-15
> **Contexto:** redactada a partir de la descripción del problema en `vision-producto.md`,
> **antes** de conocer la tecnología/enfoque que está usando el equipo de Paradigma. Sirve
> como opinión imparcial de partida para contrastar después con su aproximación real.

## Tesis central

> **Esto es, en primer lugar, un problema de integración de datos heterogéneos y de
> procesamiento de eventos en tiempo real, y solo en segundo lugar un problema de IA.**

La IA/ML es un componente importante (correlación, predicción, visión por computador, PLN,
copiloto para el operador), pero **no es el cimiento**. El cimiento es el "aburrido pero
crítico" backbone de conectores, modelo de datos canónico, streaming, estado del mundo,
geoespacial, fiabilidad y seguridad.

**Hipótesis sobre el bloqueo del equipo actual:** que 30 personas lleven 5–6 meses sin nada
funcional es un síntoma clásico de **organizar la arquitectura alrededor de una tecnología
(un framework de IA/agentes, un paradigma concreto) en lugar de alrededor del dominio**, y de
intentar abarcarlo todo a la vez en vez de entregar una **rebanada vertical fina** de
extremo a extremo. Lo confirmaré (o descartaré) al ver su enfoque.

## Marco conceptual: fusión de datos (modelo JDL)

El dominio encaja de lleno en el problema clásico de **data fusion** multi-fuente. El modelo
JDL (Joint Directors of Laboratories) da un lenguaje limpio para estructurarlo y para
explicar "dónde encaja cada cosa":

| Nivel | Qué es | En este producto |
|-------|--------|------------------|
| **L0** Pre-procesado | Señal cruda | Ingesta y normalización de sensores, cámaras, alarmas, feeds |
| **L1** Objeto/entidad | Qué/quién/dónde | Detección, *entity resolution*, geolocalización, tracking |
| **L2** Situación | Cómo se relaciona todo | **Correlación espacio-temporal**, "esto es un mismo incidente" |
| **L3** Impacto/amenaza | Qué va a pasar | Predicción, escalado, anticipación |
| **L4** Refinamiento | Mejorar el propio proceso | Búsqueda proactiva de más datos, ajuste de modelos |
| **L5** Interacción | Operador | COP, sugerencias, copiloto, *human-in-the-loop* |

Vale la pena usarlo en la reunión: demuestra que el problema tiene décadas de literatura y
que "todo va a la IA" no es la respuesta.

## Arquitectura propuesta (a grandes rasgos, por capas)

```
┌─────────────────────────────────────────────────────────────────┐
│  L5  UX del operador — Common Operational Picture (COP)          │
│      mapa + timeline + workspace de incidente + feed de          │
│      sugerencias/alertas. Copiloto en lenguaje natural.          │
├─────────────────────────────────────────────────────────────────┤
│  L3/L4  Razonamiento y decisión (IA como copiloto, GROUNDED)     │
│      • Modelos ML especializados: predicción, anomalías, visión  │
│      • Agente de búsqueda proactiva (pide más datos si hay duda) │
│      • LLM para resumen / interacción / explicación (con citas)  │
├─────────────────────────────────────────────────────────────────┤
│  L2  Correlación y fusión  → EL CORAZÓN                          │
│      • Correlación DETERMINISTA (CEP): espacio-tiempo, reglas,   │
│        explicable y auditable (safety-critical)                 │
│      • Enriquecimiento PROBABILÍSTICO (ML): resolución de        │
│        entidades, clasificación                                  │
│      • MODELO DEL MUNDO / estado: grafo de entidades +           │
│        índice geoespacial = la "visión única"                    │
├─────────────────────────────────────────────────────────────────┤
│  Backbone de EVENTOS en tiempo real (streaming)                  │
│      todo fluye como eventos; base del "tiempo real"             │
├─────────────────────────────────────────────────────────────────┤
│  L0/L1  Modelo de datos CANÓNICO + normalización                 │
│      tiempo y espacio como claves universales de unión           │
├─────────────────────────────────────────────────────────────────┤
│  Ingesta / CONECTORES (lo poco glamuroso pero decisivo)          │
│      sensores (MQTT/OPC-UA), alarmas (webhooks/SNMP/propietario),│
│      CCTV/VMS (RTSP, Milestone/Genetec), redes sociales, meteo,  │
│      tráfico, sísmico, CAD/112 (NG112)                           │
└─────────────────────────────────────────────────────────────────┘
     Transversal: auditoría/trazabilidad · seguridad y soberanía
     del dato · alta disponibilidad 24/7 · multi-tenant/config ·
     despliegue on-prem / nube soberana
```

## Mensajes clave para la reunión

1. **Integración primero, IA después.** El 70–80% del esfuerzo y la defensibilidad están en
   conectores + modelo canónico + streaming + estado + fiabilidad. Sin eso, la IA no tiene
   sobre qué razonar.

2. **Rebanada vertical fina, ya.** Elegir **un** cliente/escenario real (p. ej. 2–3 tipos de
   fuente) y entregar el flujo completo ingesta → correlación → vista del operador. Valor
   demostrable en semanas, no "hervir el océano". Esto es lo que se puede enseñar en el
   prototipo de julio/agosto.

3. **Separar correlación determinista de enriquecimiento probabilístico.** Lo *safety-critical*
   debe ser **explicable y auditable** (vidas, responsabilidad legal). La IA **aumenta**, no
   **decide**. En un contexto 112, una alucinación es peligrosa.

4. **IA como copiloto *grounded* y con humano en el bucle.** Anticipación = modelos ML
   especializados + recuperación agéntica; el LLM aporta la capa de lenguaje/resumen/
   interacción, siempre anclado al modelo de estado y con trazabilidad de por qué sugiere algo.
   No "un agente/LLM que lo hace todo".

5. **Cuidado con el *lock-in* de una sola tecnología.** Señal de alarma: que la arquitectura
   gire en torno a una herramienta en vez de en torno al dominio. La capa de IA evoluciona
   rápido: debe ser modular y reemplazable.

6. **Soberanía y despliegue condicionan el diseño.** Policía de Dubái vs. administración
   española/UE tienen requisitos muy distintos (residencia del dato, on-prem, quizá modelos
   auto-hospedados). No se puede asumir una API de IA en nube pública para todos.

## Categorías tecnológicas candidatas (sin prescribir aún)

- **Backbone de eventos:** Kafka / Pulsar / Redpanda.
- **CEP / correlación:** Flink, Drools, Esper o equivalente.
- **Geoespacial:** PostGIS, servidores de teselas, estándares OGC.
- **Estado/mundo:** grafo (entidades y relaciones) + store geoespacial; vector store para
  recuperación.
- **Conectores:** framework tipo NiFi / Camel o adaptadores propios.
- **Servido de modelos:** capa de *model serving* desacoplada; opción auto-hospedada.
- **Estándares del dominio:** CAP (Common Alerting Protocol), EDXL, NG112, OGC.

## Riesgos a vigilar

- Empezar por la IA y no por la fontanería de datos.
- Big-bang en lugar de vertical slice.
- Acoplar el producto a una tecnología de moda.
- Subestimar seguridad, HA y soberanía (son requisitos de entrada, no un extra).
- Confundir "demo bonita" con "producto operable 24/7".

---

_Siguiente paso: ver el vídeo de la reunión con José y su documentación, contrastar con esta
línea base y anotar coincidencias/discrepancias en `vision-producto.md` (preguntas abiertas)._
