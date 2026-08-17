---
name: indra-mind-producto
description: "Qué es el producto IndraMind Security, su situación técnica/política y el debate ontologías"
metadata: 
  node_type: memory
  type: project
  originSessionId: 81a3551e-bf28-44aa-97bb-ca6e4ab02cf9
---

**IndraMind Security** — «plataforma cognitiva soberana para entornos críticos de seguridad».
Producto estrella de Indra (~200 M€ de inversión). Aúna fuentes heterogéneas (sensores,
cámaras/CCTV, alarmas, SOC ciber, PSIM físico, sistemas operacionales, 112/CAD, redes
sociales) para dar **conciencia situacional** a operadores de emergencias/seguridad (112,
policía, protección civil, infra crítica, fronteras). Clientes: Dubai Police (~50 M€), Ayto./
emergencias València (~5 M€, el de la DANA). Verticales: infra crítica, emergencias, seguridad
ciudadana, control de fronteras.

**El problema:** la parte de integración/soberanía existe; el **motor cognitivo (IA) no existe**
y es lo que hay que diseñar. Lo desarrolla un equipo de **Paradigma Digital** (~30 pers., ~6
meses, ~3 M€, nada funcional), liderado por un ingeniero ex-Stratio no experto en IA que
apostó por **ontologías pesadas** orientadas a investigación forense offline — mal encaje para
asistencia cognitiva en tiempo casi real. Juanjo entra como autoridad técnica imparcial para
hacer *challenge*.

**Postura técnica de Juanjo (consensuada con el análisis):** es un problema de **integración de
datos + eventos en tiempo real primero, IA después**. Arquitectura de referencia: percepción
compartida (eventos tipados) + **tres niveles de razonamiento** (especialista de dominio /
director de incidente / coordinador de operaciones) + **escalera de atención** (baselines →
CEP determinista → LLM solo ante evento candidato) + razonadores **sin estado** con estado
externalizado + control humano + trazabilidad. **Ontologías: sí como modelo de datos mínimo
(rebautizar «modelo de eventos y entidades»), no como motor de razonamiento; «grafo» = una
capacidad (identidad+relaciones+procedencia), no una tecnología → puede ser Postgres.** LLM
auto-hospedado por soberanía pero arquitectura agnóstica al modelo.

Todo el análisis y la preparación de la reunión están en el repo (`docs/`): `vision-producto.md`,
`arquitectura-opinion-inicial.md`, `fontaneria-de-datos.md`, `analisis-y-recomendacion.md`,
`preparacion-reunion.md`. Ver [indra-mind-engagement](indra-mind-engagement.md).
