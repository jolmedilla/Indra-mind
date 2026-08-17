---
name: indra-mind-estado-y-siguientes-pasos
description: "Punto de continuación del trabajo de IndraMind: estado al 10-ago-2026, con la aportación ya en el canon (ADR-052) y la reunión del 7-ago de resultado desconocido"
metadata:
  node_type: memory
  type: project
  originSessionId: 6e2f9326-b8a5-4e21-bcfb-4fd274953309
  modified: 2026-08-10T06:29:01.481Z
---

Estado al **10-ago-2026**. Contexto general en [indra-mind-engagement](indra-mind-engagement.md); el repo de José en [indramind-poc-repo-canon](indramind-poc-repo-canon.md); cómo quiere José que se trabaje en [instrucciones-jose-proyecto-indramind](instrucciones-jose-proyecto-indramind.md).

## Lo primero: nuestra aportación ya es canon

**PROP-004 fue aceptada por José el 7-ago-2026 y aplicada al canon el mismo día.** Es el primer material nuestro que entra como norma:

- **ADR-052** · «La resolución de identidades: dos identificadores con trabajos distintos, y la clave fuerte nunca se almacena».
- Maestro de requisitos a **v0.5.2**: **INV-07 ampliado**, glosario de 63 a **67 entradas**, fila nueva **REQ-62**. Índice v3.33.
- **Entró con nuestra terminología intacta**: «clave de enlace», «puntero de fuente», «bóveda de tokens», y el encuadre de seudonimización frente a anonimización.
- Veredicto literal: «**Aceptada con cambios**». Los cambios fueron menores: la cifra del glosario (cerraba en 63, no en 59), el número de ADR (el 051 se consumió ese mismo día) y «el retoque de la frontera de la resolución aproximada» — **esto último no lo he leído; conviene mirarlo**.

Lección de método que salió de aquí y merece recordarse: **el error del `match_key` no apareció revisando nuestros documentos, sino al tener que escribir el texto normativo.** Pasar de «así lo describimos» a «esto quedaría escrito en un invariante» exige otra precisión. Si queda algo más flojo en el material de julio, aparecerá al intentar convertirlo en letra del canon.

## La regla de precedencia (sigue vigente)

**El canon de José es base de trabajo y vocabulario común, NO una autoridad ante la que nuestro análisis se retire.** De sus palabras del 29 y 31-jul: «si es que las toma todas, yo le hago preguntas y va tomando las decisiones, **por lo menos yo le aporto poco**»; «si no tiene que ser eso, **me lo diga alguien que no tenga un interés en torpedear el tema**»; «o esto hay que cambiarlo **antes de que se lo des a los del otro lado**».

**Trampa a evitar:** ADR-035 (7) impone a `motor-cognitivo-explicado.md` el estatuto «si discrepa del canon, manda el canon». Es para un fichero *de dentro* del canon. No trasplantarlo a nuestros documentos — ya pasó una vez y se corrigió.

## Estado del canon (origin/main = `51f47df`, 7-ago)

Requisitos **v0.5.2** · **ADR-001..053** · POC-001..005 (POC-006 sigue sin existir) · banco **REQ-01..62** · glosario 67 · índice **v3.33**.

**El clon local está 7 commits por detrás** (en `6c8be5d`): hace falta `git pull`. Leer siempre con `git show origin/main:ruta` y verificar la punta al empezar: el repo se mueve muy rápido.

**ADR-051 · José confirmó expresamente la frontera de ratificación**, saldando la pendencia que ADR-049 y ADR-050 dejaban abierta. Por tanto **Alejandro Asensio (Alex) queda confirmado como responsable del plano de método y espacio documental**, y José como responsable del plano funcional.

**Bandeja de propuestas** (`/propuestas`, fuera de `/docs`, ADR-049): PROP-001 y 003 aplicadas · PROP-002 retirada · **PROP-004 aplicada (nuestra)** · PROP-005 (nota Capa Cognitiva/Workbench) y PROP-006 (confirmación de la frontera) aplicadas · PROP-008 aplicada (ADR-053, candidatos aparcados) · **PROP-007 pendiente** («la bandeja se mira al arrancar»).

**Sin leer:** la nota de apoyo nueva sobre **Capa Cognitiva / Workbench** (v0.1, ratificada el 6-ago). Puede ser relevante.

## Hecho en nuestro repo (`indra-mind`, limpio, punta `e07853b`)

1. `11c3aa3` — contraste base: pasada de vocabulario, `divergencias-con-el-canon.md`, `equivalencias-de-vocabulario.md`.
2. `c6fabcb` — pasada delta sobre v0.5.1 / ADR-038..048.
3. `675c838` + `4ac1957` + `e07853b` — **`docs/veredicto-sobre-el-canon.md`**, el entregable, en tres partes: veredicto, alcance comprometido y reparto con Alex.
4. `82ea8ad` — **`docs/chuleta-identificadores-canon.md`**: estructura de su documentación + los identificadores.
5. `a33bbc9` — **`docs/indice-entregable-paradigma.md`**: el índice del entregable derivado, ~30 págs.
6. `8c7015b` + `b868c0d` — **corrección del `match_key`**: era «hash con sal», es **HMAC con clave custodiada fuera de la base**. La sal no es secreta y un DNI son ~10⁸ candidatos; y para enlazar hace falta determinismo, lo que convierte cualquier sal compartida en pimienta.

## Lo que NO sé, y hay que preguntar antes de seguir

**La reunión del viernes 7-ago ocurrió, pero no sé qué se decidió.** Lo único que consta es lo que José commiteó ese día. Sin confirmar:

- **¿Hay encargo?** El go/no-go.
- **¿Se aceptó la facturación?** Y si se desbloqueó lo administrativo (el contacto era el martes 4-ago).
- **¿Se aceptó el reparto** con Alex, y las ablaciones son suyas?
- **¿En qué repo va `/src`?** ADR-049 menciona un «repositorio de construcción» que ya existe, pero `CLAUDE.md` sigue poniendo `/src` en `indramind-poc`. Y solo consta acceso de lectura más escritura en `/propuestas`.
- **¿Cuántas horas puede poner Alex?**
- **¿Se decidió derivar el entregable para Paradigma?**

## El plan de PoC que se propuso

**Compromiso: H1 en verde con sus ablaciones, y H2 hasta donde llegue.** Anclado a la regla de la hoja de ruta: «los hitos son el seguro de la fecha… la demo se ancla a hitos, no al núcleo completo».

- **Los hitos H1–H4** viven solo en `hoja-de-ruta.md` §Fase 4 y en una línea de `decisiones-poc.md`. **No son normativos.** H1 = razonador de dominio en verde con trazas (detección anticipada, espejo de mascletà) · H2 = razonador de incidente (misiones <60 s, PRE-02) · H3 = sala completa **con las ablaciones** · H4 = ensayo general.
- **La rebanada** es la de `arquitectura-detallada.md` §5, sin cambios: simulador → 4-5 tipos de evento → baselines y correlación en código llano → un razonador de dominio (pack aglomeraciones) → SQLite → panel. FastAPI, cola en proceso, API de Claude.
- **La decisión que lo hace viable: instrumentar para ablación, no para cobertura.** Dos filas × dos perfiles = cuatro ejecuciones. REQ-01 y REQ-02 con P0 (umbrales simples) y P1 (con razonador de dominio): sin la pieza, el sistema o es ciego o es un histérico. **Mejora su plan**, que pone las ablaciones en H3.
- **Fuera:** H3, H4 y la ciudad de referencia de ADR-046 con todos los packs activos.
- **Camino crítico:** el **esquema de instancia** del banco. Lo ratifica José (ADR-050 pone en su plano el banco «y sus instancias») y debe entrar por la bandeja. `banco/instancias/` y `banco/suites/` siguen vacías, y `/src` no arranca hasta que banco y packs validen en simulación.
- **De las ~38 h, unas 19 son de construir**; el resto seguimiento, entregable derivado y notas.

## Reparto propuesto con Alex

**Alex es productivo y rápido** —en dos días hizo los 21 visuales, la bandeja entera y dos ADR—, así que el argumento de «tiene menos tiempo» no vale. Firma como `aasensio@paradigmadigital.com`.

- **Juanjo = B** de su tabla: el motor, `/src`, razonadores, runner.
- **Alex: el arnés, las ablaciones (perfiles P0–P3, suites, correrlas) y firmar el verde o rojo.** Separa juez de juzgado, que es el único argumento con el que Paradigma puede desacreditar el resultado sin entrar en el fondo. Y hace verdad la frase de José: «esto es una cosa que hemos hecho a ratos».
- **Criterio general:** a Alex, decisiones y revisiones con fecha; **nunca código en el camino crítico**.
- **La costura entre fronteras:** ADR-035 da la construcción a quien construye; ADR-050 da `/tools` al responsable de método. El arnés está en el cruce. Resolución propuesta: el **esquema de instancia** lo ratifica José; la residencia y el nombre del validador son plano de método; el diseño y el código son construcción.
- **El aviso que ya se dieron:** ADR-049 existe porque el 3-ago el catálogo de visuales se generó dos veces el mismo día y se pagó dos veces. El acoplamiento hay que ratificarlo antes de que nadie escriba.

## Conceptos ya establecidos, para no re-derivarlos

- **El «motor cognitivo» es el producto entero**, no la parte determinista ni un componente. ADR-035: «el producto íntegro que definen las secciones normativas 1 a 9», razonadores incluidos. La prueba: ADR-035 (7) renombró `arquitectura-del-sistema-contada.md` → `motor-cognitivo-explicado.md`.
- **Dos ejes ortogonales:** el normativo (motor = obliga · construcción = libre) y el arquitectónico (determinista · generativo). El segundo vive **dentro** del primero y también es norma.
- **La arquitectura no está impuesta: está implicada.** Seis normas expresadas como propiedades observables la fuerzan sin describirla — **INV-05** (replay, diff = 0), **INV-04** (grado siempre determinista), **INV-10** (etiquetado), **AR-03**, **PRE-04** (coste sublineal; excluido leer flujos completos con la generativa) y **PRE-05**. Una implementación con el modelo decidiendo falla INV-05 a la segunda pasada, falla el «cero interrupciones en todo el banco» de REQ-02 y se cae en PRE-04. **Esto responde a lo que José dijo el 29-jul: «¿qué funcionalidad te deriva en esa arquitectura? Yo no sabría expresarla». Ya la había expresado.**
- **«No hay inviabilidad sin identificador»** (ADR-035, 4) no tiene nada que ver con el prefijo INV: significa que no se puede alegar que algo no se puede hacer sin citar una fila, un invariante o un presupuesto concreto, y se resuelve con evidencia sobre el banco.
- **Tres niveles:** la **norma** (INV/C/PRE/AR) → la **fila del banco** (REQ-nn, prosa genérica) → la **instancia** (`REQ-xx-REF-nn`, caso concreto ejecutable con versiones clavadas, consultables enlatados, cinta de eventos y aserciones legibles por máquina). Encima, las **suites**: listas versionadas de instancias por uso. El uso no vive en el identificador.
- **Banco vs arnés:** el banco son las preguntas del examen (YAML declarativo); el arnés es el examinador (código). «El arnés interpreta las instancias; el motor jamás las lee».
- **La dificultad real del esquema de instancia:** debe ser ejecutable por un runner **y** escribible por un experto de dominio no programador (CFG-05, «prueba de experto» como criterio temprano).

## Facturación

Honorarios **120 €/hora**. Cifras cerradas el 6-ago:

| Concepto | Base |
|---|---|
| Preparación de la presentación de julio (4 h) — pendiente de cobro desde julio | 480 € |
| 6 h/semana de la semana del 3-ago al 15-sep ≈ 38 h | 4.560 € |
| **Base imponible** | **5.040 €** |
| IVA 21 % | 1.058,40 € |
| **Total** | **6.098,40 €** |

Presentarlo como **precio cerrado**; las 6 h/semana son **promedio, no compromiso semanal**; y el trabajo de julio va como **línea aparte y visible**. **La facturación no va en el documento del veredicto** —Alex lo lee— sino en mensaje aparte, probablemente a quien gestiona la empresa.

## Pendiente

- **Ofrecido y no hecho:** el correo de facturación.
- **Leer** el retoque de «la frontera de la resolución aproximada» que José metió en ADR-052, y la nota de Capa Cognitiva/Workbench.
- **`git pull`** en el clon de José (7 commits por detrás).
- **Hilo de WhatsApp anterior al 31-jul 12:27** sin leer (`chats load_more_history` sobre `34615437634@c.us`).
- **Formato decidido:** el veredicto va como **documento**, no presentación. La presentación se gana su sitio para dirección/Marcelo y para el entregable a Paradigma, con la cadena que ya existe (`tools/publicar.sh` + weasyprint, ADR-014). **No introducir LaTeX.**
