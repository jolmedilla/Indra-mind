# Equivalencias de vocabulario

> **Anexo a la presentación del 17-jul-2026** ([`presentaciones/diagnostico-indramind.html`](../presentaciones/diagnostico-indramind.html))
> · Fecha: 5-ago-2026 · Una página, para leer antes que nada lo demás.

## Por qué hay dos juegos de nombres

La presentación del 17 de julio y el registro de decisiones de José se escribieron **en paralelo
y sin verse**: la primera es del 15-17 de julio, el registro arrancó el 13 y corrió hasta el 30.
Cuando se cruzaron, resultó que no había contradicción de fondo —el canon había absorbido las
tesis de la presentación— pero sí dos vocabularios para las mismas piezas.

Los documentos de trabajo de este repo están hoy alineados con el canon. **La presentación no se
ha reescrito**, por ser acta de lo que se dijo aquel día. Esta tabla es el puente.

El criterio para decidir qué se renombraba y qué no **no fue la deferencia, sino ADR-035**, que
parte el producto en dos ámbitos: el **motor cognitivo**, que es norma, y la **construcción**
—tecnologías, estructura interna, topología—, que es libertad de quien construye con el banco de
escenarios como juez único. Se adoptó el vocabulario del canon en el primer ámbito. En el
segundo no, porque ahí el canon no manda y decirlo de otro modo sería confundir la frontera.

## Lo que se renombró (ámbito del motor cognitivo)

| En la presentación del 17-jul | Nombre vigente | Norma | Qué se gana |
|---|---|---|---|
| incidente candidato · situación candidata | **detección** | ADR-001, ADR-013 | «Incidente» queda reservado a lo que nace de un acto humano de calificación. Es el principio de control humano convertido en regla de nombres: resulta imposible que algo se llame incidente sin que una persona lo haya calificado. Converge además con el vocabulario de los SOC, donde el triaje convierte detecciones en incidentes |
| especialista de dominio | **razonador de dominio** | ADR-003 | — |
| director de incidente | **razonador de incidente** | ADR-003 | «Director» y «coordinador» se leían como personas. Los tres componentes máquina pasan a «razonador de …» y los cargos humanos son **operador, mando del incidente y jefe de sala**. Los dos lados forman espejo: la máquina prepara y propone, la persona decide |
| coordinador de operaciones | **razonador de sala** | ADR-003 | — |
| playbook | **pack** | ADR-015 | «Pack» es la unidad de *runtime*; era ya el término de José desde las primeras conversaciones |
| cobrar por pack | cobrar por **vertical** | ADR-015 | «Vertical» es la unidad **comercial** —packs, plantillas, mapeos e implantación de un dominio—. Separarla del runtime permite refactorizar la arquitectura sin tocar el tarifario |
| ciclo de vida: detección → calificación → respuesta → estabilización → cierre | ciclo de vida: **calificación → respuesta → estabilización → cierre** | ADR-013 | La detección no es una fase del incidente: es el objeto del peldaño anterior. El incidente empieza a existir en la calificación |

En los siete casos el nombre del canon es mejor que el nuestro, y por eso se adopta. Ninguno
cambia el mecanismo que describía la presentación.

## Lo que **no** se renombró (ámbito de construcción)

| Término | Se conserva porque |
|---|---|
| **pizarra** | El **cuadro de situación** del canon (ADR-002) es la imagen operacional común que existe a cada nivel: lo que la persona ve. La **pizarra** es el almacén de estado caliente sobre el que se coordinan los razonadores sin estado: lo que la máquina usa. La pizarra *materializa* el cuadro de situación; no son lo mismo, y fundirlos borraría la frontera que sostiene el control humano |
| **modelo del mundo** | Nombra un nivel de almacenamiento, no un artefacto de presentación |
| **arquitectura** | ADR-035 retira «arquitectura de referencia» como **nivel intermedio del canon** —la capa apartable que ya no protegía nada—, no como palabra ni como actividad. Lo que este repo llama arquitectura es construcción: terreno declarado libre, que no vincula a nadie salvo por lo que demuestre contra el banco |
| bus, motor CEP, registro de identidades y relaciones, pasarela de federación, `match_key` / `handle`, capa de percepción, normalizador | Todo el inventario de componentes es construcción (ADR-035). Sus nombres son de este repo |

## Cómo leer la presentación del 17-jul con esto delante

No hace falta corregirla mentalmente más allá de la tabla de arriba. Y conviene no corregirla en
papel: el desfase entre las dos es la prueba documental de que el canon absorbió las tesis que
se llevaron a aquella reunión, y no al revés.

Las cuatro diferencias que **sí** son de fondo —y no de nombres— están en
[`divergencias-con-el-canon.md`](divergencias-con-el-canon.md), con el veredicto de cada una.
