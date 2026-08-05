# La "fontanería de datos"

> **Fecha:** 2026-07-15 · Línea base conceptual, **pendiente de revisión** tras analizar el
> vídeo y la documentación de Indra Mind / Paradigma.
>
> Complementa a [`arquitectura-opinion-inicial.md`](arquitectura-opinion-inicial.md): desarrolla
> la capa de ingesta/normalización que allí se identifica como el cimiento del producto.
>
> **Pasada de vocabulario (2026-08-01, revisada).** Este documento se escribió sin ver el
> registro de decisiones de José. Se ha alineado su terminología con el canon vigente del repo
> `indramind-poc` **solo donde el canon es normativo** — es decir, en el ámbito del motor
> cognitivo (ADR-035). Los nombres de piezas de **construcción** (almacenes, pizarra, topología)
> son nuestros y se conservan. Ninguna afirmación técnica ha cambiado; el inventario de las
> divergencias de fondo está en [`divergencias-con-el-canon.md`](divergencias-con-el-canon.md).

## Qué es

Todo lo que ocurre **entre "existe una fuente ahí fuera" y "hay un evento limpio, normalizado
y correlacionable dentro del sistema"**. Es la tubería que convierte señales crudas y dispares
en un idioma común sobre el que la correlación y la IA pueden razonar.

```
FUENTE CRUDA
   │  1. Conector / adaptador          ← aquí vive casi toda la variedad por cliente
   ▼
   │  2. Normalización → modelo canónico
   ▼
   │  3. Calidad + dedup + resolución de entidades + geocodificación
   ▼
   │  4. Enriquecimiento en ingesta (contexto barato y determinista)
   ▼
   │  5. Backbone de streaming (log duradero, ordenado, reproducible)
   ▼
   │  6. Estado / almacenamiento (modelo del mundo + histórico + geo)
   ▼
EVENTO LISTO PARA CORRELACIONAR
   (transversal: catálogo de fuentes + linaje + observabilidad + seguridad/multi-tenant)
```

## Las piezas

1. **Conectores / adaptadores.** Uno por tipo de fuente/protocolo: MQTT/OPC-UA (sensores),
   webhooks/SNMP/propietario (alarmas), RTSP + VMS tipo Milestone/Genetec (cámaras), APIs
   (redes sociales, meteo, tráfico, sísmico), CAP/EDXL (feeds oficiales), CAD/NG112 (112).
   Resuelven lo aburrido pero vital: autenticación, suscripción/polling, reconexión,
   *buffering*, *backpressure*.

2. **Normalización a modelo canónico.** Traducir esquema y **semántica** de cada fuente al
   idioma interno. Dos niveles: estructural (campos → campos) y semántico (el "código 3" de
   esta fuente = "incendio").

3. **Calidad, dedup y resolución de entidades.** Validar, deduplicar (mismo suceso por dos
   fuentes), decidir si "la persona de la llamada" = "la persona de la cámara", reconciliar
   relojes/latencias, geocodificar y unificar sistema de coordenadas, tratar datos tardíos o
   desordenados.

4. **Enriquecimiento en ingesta.** Contexto barato y determinista: zona administrativa,
   activos cercanos, meteo del punto/hora, histórico. (Lo caro/ML va después, en correlación.)

5. **Backbone de streaming.** Log de eventos **duradero** (no se pierde una alarma del 112),
   **ordenado** y **reproducible** (reprocesar histórico al añadir reglas). Desacopla fuentes
   de consumidores.

6. **Estado / almacenamiento.** El **modelo del mundo** (estado actual, caliente), el histórico
   (frío: análisis/replay/auditoría), el índice geoespacial y el grafo de relaciones.

Transversal: **catálogo de fuentes + linaje del dato** (de qué eventos y fuentes salió cada
conclusión → auditabilidad), observabilidad (¿fuente caída? ¿dato rancio?), seguridad y
**multi-tenant**.

## El punto clave: cada cliente es distinto

Cada cliente trae **fuentes distintas** y **catástrofes distintas**. La respuesta correcta
**no** es construir un sistema a medida cada vez (eso es una consultora *body-shop*: no escala).
La respuesta es **separar plataforma estable de configuración por cliente**. Toda la
variabilidad debe caer en solo **tres sitios configurables**:

| Qué cambia por cliente | Cómo se absorbe sin reescribir el core |
|---|---|
| **Qué fuentes** hay | Conectores de un **catálogo creciente** + **SDK** para el que falte. El cliente N reutiliza el 80–90%. |
| **Qué catástrofes/alarmas** | **Taxonomía y modelo canónico extensible** (tipos, severidad, atributos). Un tipo nuevo es config + quizá un modelo ML, no un rediseño. |
| **Cómo se reacciona** | **Reglas de correlación** y **packs de doctrina** de respuesta + modelos ML específicos. |

Lo que lo hace posible técnicamente:

- **Modelo canónico = núcleo estable + atributos extensibles.** Universal y fijo: evento,
  entidad, incidente, tiempo, lugar, severidad, confianza, fuente. Lo específico del dominio
  (inundación vs. tuit vs. detección CCTV) son extensiones tipadas. **Tiempo y espacio son las
  claves de unión universales**, sea cual sea la catástrofe.
- **Mapeos declarativos, no código.** Dar de alta una fuente = rellenar configuración de mapeo.
  *Onboarding* de días, no meses.
- **El motor de correlación opera sobre el modelo canónico** → casi agnóstico al cliente. Por
  cliente se añaden reglas y packs de doctrina, no se reconstruye el motor.
- **Estándares del dominio** (CAP, EDXL, OGC, NG112) para no inventar taxonomía y para
  interoperar con lo que el cliente ya tiene.

## Mensaje para la reunión

> La fontanería, bien diseñada como **plataforma configurable**, es exactamente lo que
> convierte esto en un **producto que se amortiza entre clientes** en vez de un proyecto de
> integración que se rehace cada vez.

Señal de alarma a vigilar: si el equipo actual **cablea fuentes a mano por cliente**, es un
síntoma tan grave como empezar por la IA.
