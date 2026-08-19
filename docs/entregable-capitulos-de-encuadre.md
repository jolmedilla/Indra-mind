# Los dos capítulos de encuadre del entregable

> **Borrador · 19-ago-2026** · Son los capítulos **§0** y **§8** del entregable derivado
> cuyo índice está en [`indice-entregable-paradigma.md`](indice-entregable-paradigma.md):
> los dos únicos que hay que redactar, porque el resto sale del maestro de requisitos
> *verbatim*.
>
> Se escriben ahora, antes de decidir quién redacta el cuerpo, porque **valen en
> cualquier escenario**: si la edición para el equipo de construcción la genera José
> filtrando el maestro, estos dos capítulos se le añaden delante y detrás; si el
> documento se ensambla de cero, ya están hechas las dos partes difíciles. Una
> derivación del maestro no puede producirlos, porque no están en el maestro.
>
> **Destino si se aceptan:** `docs/` de `indramind-poc`, por la bandeja de propuestas,
> con veredicto del responsable del plano funcional. Mientras vivan aquí no son canon.

---

# § 0 · Cómo leer este documento

Este documento dice **qué tiene que hacer y qué tiene que garantizar** el motor cognitivo de IndraMind Security. No dice cómo construirlo, y esa omisión es deliberada.

## Dos ámbitos, y solo uno os obliga

Todo lo que sigue vive en uno de dos ámbitos, y conviene tenerlos separados desde la primera página.

**El motor cognitivo es norma.** Las capacidades que debe tener, los invariantes que nunca puede dejar de cumplir, lo que debe poder configurarse sin tocar código, los presupuestos de desempeño y coste, los anti-requisitos y el banco de escenarios que lo juzga. Eso es lo que el producto tiene que ser y hacer, y es materia de quien especifica.

**La construcción es vuestra.** Qué bus de eventos, qué almacenamiento, qué motores de correlación y de reglas, qué modelo de lenguaje, cuántos procesos y con qué estructura interna. Por diseño y no por omisión: este documento no os lo va a decir, y si alguna vez parece decirlo, es un defecto del documento y hay que corregirlo.

Donde una elección de construcción condiciona el comportamiento observable, la norma fija **la semántica sin nombrar producto**. El bus, por sus garantías —suscripción equivalente a grupos de consumidores, ventanas sobre tiempo de evento y retención con replay— y no por su marca. El almacenamiento, por benchmark, sin la ontología ni el grafo como dogma. La correlación y las reglas, por su reproducibilidad exacta al rebobinar y por que su doctrina sea configuración y no código. La capa generativa, confinada, etiquetada y presupuestada, sea cual sea el modelo que la sirva.

## El banco es el juez, y es el mismo para todos

Ninguna de las dos partes decide si una elección de construcción es buena. Lo decide **el banco de escenarios**: un conjunto de casos en forma de *dado → cuando → entonces*, con su métrica, que se ejecutan contra la implementación y salen en verde o en rojo.

Eso tiene una consecuencia que conviene enunciar sin rodeos: **cualquier implementación que pase el banco es aceptable**, venga de donde venga y esté escrita como esté. El banco no premia una arquitectura; premia un comportamiento.

## No hay inviabilidad sin identificador

Y tiene una segunda consecuencia, que es la que hace utilizable este documento.

Si algo de lo que aquí se pide os parece que no se puede construir, **la vía para decirlo está abierta y es formal**: se alega contra una fila del banco, un invariante o un presupuesto **concretos**, y se resuelve con evidencia sobre el banco.

Lo que no cabe es el «esto no se puede» genérico, y no por autoritarismo sino porque no es rebatible ni comprobable: no dice qué falla, así que nadie puede medirlo ni arreglarlo. Nombrar la pieza convierte una objeción en un experimento, y un experimento se puede ganar.

La regla os protege tanto como obliga. Nadie puede tumbar una decisión vuestra sin señalar qué fila incumple, y vosotros tenéis un camino nombrado para rechazar lo que no sea construible.

## Qué hay aquí dentro, y qué no

Lo que hay son cinco familias de obligaciones y un contrato:

| | Qué es |
|---|---|
| **Invariantes** | Lo que nunca puede dejar de cumplirse, pase lo que pase |
| **Capacidades** | Lo que el motor tiene que saber hacer |
| **Anti-requisitos** | Lo que el motor no debe hacer, dicho explícitamente |
| **Presupuestos** | Los límites de desempeño y coste que hay que respetar |
| **Configurabilidad** | Qué se cambia sin tocar código, y con qué ciclo de aprobación |
| **El banco** | El contrato de aceptación: los escenarios que hay que pasar |

Cada elemento lleva un identificador estable. Cuando se citan entre sí, se citan por él.

**Y lo que no hay es ni un solo cuerpo de decisión de arquitectura.** El registro de decisiones existe —es donde consta por qué cada cosa es como es— y no viaja en este documento a propósito: son el *porqué*, no la obligación. El anexo final los lista por número y título, y cualquiera se entrega a petición. Si algo de aquí os parece arbitrario, la pregunta correcta es «¿por qué esto es así?», y tiene respuesta escrita.

---

# § 8 · Cómo se demuestra y cómo se discute

Este capítulo describe el mecanismo por el que se decide si una implementación cumple. Es la contrapartida del §0: allí se dijo que el banco es el juez; aquí se dice cómo juzga.

## El banco tiene dos niveles

**La fila** es normativa y está escrita en prosa genérica. Dice, por ejemplo, que ante eventos convergentes de fuentes independientes en una zona sin evento autorizado en la agenda, el motor debe emitir una detección con hipótesis en competencia, sus grados de confianza y su evidencia trazada, antes de la detección humana de referencia declarada en el escenario.

**La instancia** es un caso concreto de esa fila, ejecutable: con las versiones de doctrina y configuración clavadas, los objetos previos sembrados, una cinta de eventos con su tiempo de evento, y aserciones legibles por máquina. Una fila puede tener muchas instancias.

Por encima de ambos están las **suites**: listas versionadas de instancias agrupadas por uso —la aceptación de una entrega, un estudio de ablación—. El uso vive en la suite, no en el identificador de la instancia.

## Las tres propiedades del arnés

El arnés es el programa que ejecuta las instancias. Tiene tres propiedades que son parte del contrato, porque sin ellas el resultado no significa nada:

**Solo puerta delantera.** Todo entra por el bus, por los consultables y por la interfaz de acciones. Ningún gancho de prueba altera el comportamiento del sistema examinado. La implementación no sabe que está siendo examinada, y de hecho **nunca lee una instancia**: el arnés las interpreta, el motor no.

**El arnés es dueño del reloj de tiempo de evento.** Los instantes salen de la cinta de la instancia, no del reloj de la máquina. Un sistema que consultara la hora real daría resultados distintos en cada pasada, y entonces no habría nada que verificar.

**El expediente es la única superficie de aserción.** Las comprobaciones miran lo que el expediente expone —las detecciones, sus hipótesis, la traza, las interrupciones— y no el estado interno del sistema. Esto es lo que permite que el mismo banco examine implementaciones distintas: no se comprueba cómo lo hace, se comprueba qué deja escrito.

## La doble pasada

Una parte de las aserciones no mira el resultado sino su estabilidad: se ejecuta la misma instancia dos veces, con las mismas versiones fijadas, y **la diferencia debe ser cero** en las capas deterministas.

Es una comprobación barata y muy discriminante. Un sistema que delegue en un modelo generativo la ordenación de hipótesis o el cálculo de un grado de confianza la falla en la segunda pasada, aunque hubiera pasado la primera.

## Los perfiles y la ablación

Una misma instancia puede ejecutarse bajo **perfiles** distintos: configuraciones que activan o desactivan piezas del sistema.

Eso permite algo más útil que comprobar que el sistema funciona: comprobar **qué pieza aporta qué**. Se corre el mismo escenario con la pieza y sin ella, y se mide la diferencia. Un ejemplo real, con dos escenarios que comparten la misma cinta de eventos y las mismas líneas base y solo se diferencian en si hay un acto autorizado en la agenda:

| | Sin razonador de dominio | Con razonador de dominio |
|---|---|---|
| **Convergencia sin acto en agenda** | detecta 5 min antes de la referencia humana | detecta 35 min antes |
| **La misma convergencia, con acto autorizado** | interrumpe: falsa alarma | no interrumpe; registra el acto esperado con la alternativa descartada y su motivo |

El valor de una pieza no se argumenta: se mide quitándola.

## Cómo se alega que algo no se puede

Si una obligación de este documento resulta no construible, la vía es la que se anunció en el §0, y aquí va con su forma concreta:

**Se nombra la pieza.** Una fila del banco, un invariante o un presupuesto, con su identificador.

**Se dice qué ocurre.** Qué se ha construido, qué se ha medido y en qué se queda: «esta fila exige veinte minutos de antelación y medimos ocho»; «este presupuesto exige coste sublineal con el número de fuentes y medimos crecimiento lineal a partir de treinta».

**Se resuelve sobre el banco.** Con la instancia ejecutada y sus números delante, no con opiniones sobre la dificultad.

De ahí salen tres desenlaces posibles, y los tres son legítimos: que la implementación cambie porque la obligación era construible; que la obligación cambie porque no lo era, y entonces se modifica con su asiento y su motivo; o que se acote el perímetro, declarando qué queda fuera y por qué.

Lo que no es un desenlace es que la discusión se gane por cansancio.
