# Divergencias entre nuestros documentos y el canon de IndraMind

> **Fecha:** 2026-08-01 · Contraste de [`analisis-y-recomendacion.md`](analisis-y-recomendacion.md)
> y [`arquitectura-detallada.md`](arquitectura-detallada.md) (ambos del 15-jul-2026) contra el
> canon del repo `indramind-poc` en su estado del 30-jul-2026: documento de requisitos v0.4,
> registro de decisiones ADR-001..037, decisiones de PoC POC-001..005, índice v3.3.
>
> **Actualizado al 5-ago-2026** con la pasada delta sobre el canon v0.5.1 (ADR-038..048,
> REQ-01..61, `/banco` creado). Va en su propia sección, más abajo: **ninguna de las cuatro
> divergencias se cae, dos se refinan y una afirmación de este documento queda corregida.**
>
> Es el inventario de en qué nos separamos del canon, para poder llevar a José una conversación
> por elemento en lugar de una impresión general.

## El encargo, en palabras de José

Este documento se escribió el 1-ago con una cláusula al pie —«si algo de aquí discrepa del
canon, manda el canon»— que era un error de postura y queda **retirada**. Esa frase es el
estatuto de cabecera que ADR-035 (7) impone a `motor-cognitivo-explicado.md`, un fichero de
**dentro** del canon cuyo trabajo es explicar la norma. Trasplantarla aquí invierte justamente
el papel que José pidió. Lo que pidió, literalmente, fue lo contrario:

- **29-jul.** «Si te pusieras tú con esto, lo primero es que habría que revisarlo, ver lo que te
  parece, **si hay cosas ahí que tú abordarías de otra manera**.» Y sobre el origen de las
  decisiones del registro: «si es que las toma todas, yo le hago preguntas y va tomando las
  decisiones, **por lo menos yo le aporto poco**, pero a lo mejor tú cuando lo revises **ves ahí
  algo raro**». Y el motivo de fondo: «si no tiene que ser eso, **me lo diga alguien que no tenga
  un interés en torpedear el tema**».
- **31-jul.** «Que le eches un ojo y que veas hasta qué punto **primero tú lo ves razonable o
  no**… que me digas: ok, sobre esa base que has generado tú, la veo bien y puede usarse como
  referencia, **o esto no lo veo**, por lo que sea, **o esto hay que cambiarlo antes de que se lo
  des a los del otro lado**.» Y: «**ahora estamos a tiempo de hacer ajustes**».

De modo que el orden de precedencia real es: **el canon es la base de trabajo y el vocabulario
común; no es una autoridad ante la que este análisis se retire.** Donde el canon mejora lo
nuestro, se adopta y se dice por qué. Donde lo nuestro es mejor, se sostiene y se lleva a la
puesta en común. José apoya además esta lectura con su propia valoración del canon —«ha ajustado
cosillas que yo creo que **no cambian en esencia nada de lo que nos dijiste**»—: si un cambio del
canon sí altera la esencia, eso es precisamente un hallazgo que reportar, no algo que absorber.

## Por qué existe este documento

Nuestros dos documentos técnicos se escribieron el 15 de julio, **sin ver el registro de
decisiones de José**, que corría en paralelo desde el 13. En las dos semanas siguientes José
ejecutó una revisión ratificadora completa del documento de requisitos que produjo veinte
decisiones nuevas (ADR-016..035). El resultado es que la mayor parte de lo que escribimos no
está contradicho sino **absorbido**, y lo que queda son cuatro divergencias concretas más un
hueco que el canon cerró por su cuenta.

## Lo que ya coincide (contexto necesario para leer lo demás)

| Lo nuestro | Dónde vive hoy en el canon |
|---|---|
| Esquemas + identidades con procedencia + federación; almacén por benchmark, no por dogma | ADR-004, cuyo propio contexto recoge la crítica que llevamos a la reunión del 14-jul |
| Razonadores sin estado, con el contexto reconstruido acotado en cada invocación | ADR-005, que además da por resuelto el problema de compactación de contexto |
| Pasarela de modelos agnóstica, con el LLM como pieza reemplazable | ADR-006, con matriz de modelos certificados contra el banco por rol y por tier |
| Bus ligero en la PoC, Kafka en producción, con replay | ADR-008, donde el replay es además el mecanismo con el que se ejecuta el banco |
| El grafo de Paradigma como pieza y no como base | ADR-007, con cuatro encajes concretos y relación por contrato de frontera |
| Antelación mínima de 20 minutos sobre la detección humana de referencia | Presupuesto PRE-03 |
| De señal a misión propuesta en menos de 60 segundos | Presupuesto PRE-02 |
| Toda conclusión enlazada a los eventos y el conocimiento que la sostienen | Invariante INV-02 |
| Escenarios conductuales como criterio de éxito | El banco, hoy REQ-01..58, contrato de aceptación del producto |

## Las cuatro divergencias

### DIVERGENCIA 1 · El CEP no puede producir «incidentes»

**Lo que decíamos.** El motor de correlación agrupa eventos por espacio, tiempo y entidad
común y dispara **incidentes candidatos**, sobre los que después despierta el razonador de
dominio.

**Lo que decidió el canon.** El incidente nace en el **acto humano de calificación**, y la
fase de detección desaparece del ciclo de vida del incidente porque pertenece al objeto del
peldaño anterior de la escalera (ADR-013). El ciclo queda en calificación → respuesta →
estabilización → cierre. Lo que la máquina forma antes de que intervenga nadie es una
**detección** (ADR-001), término elegido además porque converge con el vocabulario de los SOC,
donde el triaje convierte detecciones en incidentes, y porque funciona igual en el dominio
físico y en el ciber.

**Veredicto.** El canon tiene razón y la corrección es barata. No es una discusión de
nomenclatura: es el principio de control humano convertido en regla de nombres, de forma que
resulte imposible que algo se llame incidente sin que una persona lo haya calificado.
**Resuelto** en la pasada de vocabulario: nuestros documentos ya dicen «detección».

### DIVERGENCIA 2 · La fusión previa a la calificación está prohibida

**Lo que decíamos.** Un correlador deduplica lo que varios razonadores de dominio emiten sobre
el mismo suceso, agrupando por espacio, tiempo y entidad, «para evitar incidentes duplicados»
— es decir, una fusión que ocurre antes de que intervenga ninguna persona.

**Lo que decidió el canon.** No existe el vínculo entre detecciones antes de calificar
(ADR-018). El acto de calificación puede tomar **varias** detecciones y producir un único
incidente cuyo expediente las referencia todas, de modo que la trazabilidad de toda conclusión
hasta sus orígenes queda sin huecos (INV-02). Se evaluó crear un objeto «vínculo entre
detecciones» y se descartó expresamente.

**El argumento, que merece entenderse.** Si la relación entre dos detecciones era conocible,
entonces pertenece a la doctrina y la máquina debería haber correlacionado en una sola
detección desde el principio. Si no lo era, la calificación conjunta la establece y la
corrección del operador se captura como propuesta de patrón, para que la siguiente vez sí sea
automática. Un objeto intermedio institucionalizaría como trabajo humano permanente
exactamente aquello que el diseño quiere convertir en doctrina.

**Veredicto.** El canon tiene razón, y su argumento es mejor que el nuestro. Nuestra fusión no
desaparece: se parte en dos mitades que ya existen en el canon —la correlación determinista
aguas arriba y la calificación conjunta aguas abajo—, y lo que se pierde es el paso intermedio
sin dueño. **Marcado en el texto, no reescrito**, porque afecta al diseño y no solo al nombre.

### DIVERGENCIA 3 · Quién escribe el grado de confianza (la importante)

**Lo que decíamos.** El razonador de dominio, respaldado por LLM, «emite con confianza y
trazabilidad». Y, en el resumen ejecutivo, que «un LLM actual ya hace el razonamiento» y el
valor está en la arquitectura que lo orquesta.

**Lo que decidió el canon.** El grado de confianza es **siempre** un cálculo determinista: un
prior que la doctrina de razonamiento asigna a la clase de la explicación —incluida la clase
«hipótesis sin patrón que la respalde», con prior suelo—, movido solo por evidencia trazada, o
bien una herencia declarada. **La capa generativa propone contenidos, nunca escribe ni altera
grados** (ADR-028). El LLM no es fuente de verdad de las correlaciones ni ejecutor de acciones
(AR-03), y sus roles están acotados y etiquetados (INV-10).

**Lo que el canon pone a cambio, y nosotros no teníamos.** La **valoración generativa**: la
lectura contextual del modelo elevada a artefacto de primera clase, etiquetada como
generativa, anclada a afirmaciones de la traza, cacheada para que el replay sea reproducible y
presentada **siempre junto** al grado determinista sin sustituirlo. Su mandato es doctrina
versionada e incluye dos preguntas fijas: la relectura contextual de las hipótesis en
competencia y la búsqueda de explicaciones ausentes con la evidencia que las discriminaría. Y
su privilegio para reclamar la atención de alguien lo otorgan cláusulas declaradas de la
política de interrupción, nunca el juicio mismo.

**Los cuatro motivos que dan, todos sólidos.** Si el modelo escribe el número: se rompe la
reproducibilidad de la ruta que decide (INV-05); se pierde la calibración de umbrales y del
ciclo post-incidente por desenlaces (INV-04, C-21); se rompe la herencia del grado hacia las
misiones; y, en pantalla, el operador no puede distinguir una magnitud calibrada de una tirada
de dados.

**Veredicto.** Es la única divergencia donde nuestro documento diría hoy algo que el canon
prohíbe, y hay que corregirla en la cabeza antes que en el papel. Nuestro texto no llegaba a
afirmar que el LLM escribiera el grado —decíamos que lo determinista corre fuera del LLM—,
pero lo dejaba sin dueño explícito, que es justamente el hueco que ADR-028 vino a tapar. El
titular del resumen ejecutivo («un LLM actual ya hace el razonamiento») es además una frase
que, ante un lector crítico de Paradigma, se puede volver en contra: invita a leer el producto
como una envoltura alrededor de un modelo. **Marcado en el texto**; conviene no repetirla en
voz alta sin el matiz.

### DIVERGENCIA 4 · La frontera del simulador en la PoC

**Lo que decíamos.** El simulador de fuentes «emite eventos sintéticos» y **sustituye a
conectores más percepción**.

**Lo que decidió el canon.** La frontera del simulador es el **esquema de señal de fuente**:
el simulador emite señales con esquema y cadencia fieles a la fuente real, y es el producto el
que las comprende; **nunca inyecta eventos ya comprendidos** (POC-005, apoyado en la capacidad
de comprensión de señales del propio motor, C-19). Los segmentos generados persisten como
fixtures del banco.

**Veredicto.** El canon tiene razón y esto sí tiene consecuencias prácticas inmediatas para la
construcción. Nuestra versión ahorra trabajo en la PoC pero deja sin ejercitar precisamente la
capa que el producto tendrá que tener en producción, y convierte «pasar a real» en un cambio
de sistema en vez de un cambio de origen de los datos. Es un error nuestro, no una diferencia
de criterio. **Marcado en el texto.**

**Y lo refuerza el propio objetivo de José.** El 29-jul describió lo que quiere de la PoC: no
validar el camino feliz sino la arquitectura, «vamos a repetir, o a darle diferentes datos al
sistema para que comprobemos que **cada uno de los puntos de la arquitectura**, si está produce
un resultado y si no está produce otro peor» — ablaciones, siete a quince escenarios, «le quito
una pieza al coche y el coche no cumple el camino feliz». Un simulador que sustituya a la
percepción deja esa capa fuera del alcance de la ablación: no se puede quitar la pieza que
nunca se montó. La frontera de POC-005 es la condición para que el experimento que él quiere
sea posible.

## El hueco que el canon cerró por su cuenta

En nuestra arquitectura, un evento de una clase a la que ningún razonador de dominio está
suscrito no le pasa nada a nadie: cae en el silencio. El canon nombró ese modo de fallo —el
falso negativo silencioso— y lo cerró con el **dominio abierto** (ADR-032): un pack de fábrica
cuyo objeto es todo evento de clase sin suscriptor dedicado, con un suelo determinista de
meta-patrones baratos (acumulación de desviaciones altas por ventana y zona, cascadas de
eventos-indicio de salud de fuentes) que forma una detección de clase «situación sin doctrina»
bajo obligación de atención humana, más interpretación generativa por encima del objeto ya
formado.

El argumento que lo justifica conviene retenerlo porque es bueno de contar: **las emergencias
más graves suelen ser las nuevas**, es decir, precisamente aquellas para las que no hay
doctrina previa. Y la red de seguridad no puede depender de la capa generativa, cuya caída es
un modo de operación que hay que ensayar. Es una mejora real sobre lo que nosotros teníamos, y
comercialmente da el argumento del «día uno con red».

**Una tensión que llevar al banco, no una objeción.** ADR-028 asigna a la clase «hipótesis sin
patrón que la respalde» un **prior suelo**, y ADR-032 sitúa en esa misma clase precisamente las
emergencias nuevas, que son las graves. El grado determinista, por construcción, le da entonces
su valor más bajo a lo que más importa. El canon no lo ignora —para eso están la valoración
generativa y las cláusulas declaradas de la política de interrupción con gravedad anclada—, pero
todo el peso de que lo grave y sin doctrina llegue a un humano recae en esa política, que hoy
existe como principio y no como mecanismo probado. **Propuesta:** un escenario del banco cuyo
criterio de éxito sea que un suceso de clase sin suscriptor y gravedad alta alcanza atención
humana **con la capa generativa caída**. Si pasa, la tensión está resuelta; si no, hemos
encontrado el agujero antes que Paradigma.

## Pasada delta · el canon del 4-ago (v0.5.1, ADR-038..048)

Entre el 31-jul y el 4-ago el canon avanzó más que en toda la semana anterior: requisitos de
v0.4 a **v0.5.1**, ADR de 037 a **048**, banco de REQ-58 a **REQ-61**, glosario a 59 entradas, y
`/banco` creado con su convención fijada. Además creció una espina dorsal de evidencia que antes
no existía —36 fuentes primarias del corpus de contraste, 20 planes territoriales fichados, la
visita al CECOES 1-1-2 de Canarias— y un catálogo de 21 visuales.

Esto importa por una razón práctica: **lo que va a llegar a Paradigma es la v0.5.1, no la v0.4
que validamos.** Lo que sigue es el contraste de lo nuevo.

### Efecto sobre las cuatro divergencias

**Divergencia 1 · gana una segunda puerta, y buena.** ADR-043 declara los **orígenes reconocidos
de calificación**: donde la primera atención de la demanda ocurre en una sala ajena que ya la
procesa con personas —los operadores de demanda canarios, el 112 valenciano que transfiere al
centro de coordinación—, el incidente propio **nace en el momento de la entrada** citando ese
acto humano de origen como su calificación. No se exige recalificar en destino; la primera
actuación se registra como asunción, con plazo cuyo silencio escala. Lo no reconocido entra como
detección bajo obligación de atención. El invariante aguanta —todo incidente sigue naciendo de
un acto humano citable, propio o reconocido— y se evita añadir ceremonia donde el cliente hoy no
la tiene. Nuestra corrección de vocabulario sigue siendo válida; solo deja de ser cierto que la
única puerta sea la calificación en destino.

**Divergencia 2 · intacta y reforzada.** ADR-040 añade el **negativo** de la correlación —el
atributo de **disyunción**: la detección que nace sin plegarse al incidente que eclipsa la
sala— como atributo computado y trazado. No relaciona detecciones antes de calificar: computa
que *no* se relacionan. La prohibición de ADR-018 sigue en pie.

**Divergencia 3 · es donde se ha movido todo, y hay que releerla entera.** Cuatro ADR refinan
ADR-028:

- **ADR-047 · patrón de catálogo.** El motor publica catálogos cerrados de **funciones de
  catálogo** parametrizables, y entre ellas el **combinador de grados**, que es la única función
  *no seleccionable*: única y obligatoria en todo despliegue, para que un mismo grado signifique
  lo mismo venga del pack que venga. Esto **cierra exactamente el hueco que señalábamos**: nuestro
  texto dejaba el grado sin dueño explícito; ahora tiene mecanismo, escala y tablas de anclaje
  versionadas. El canon llegó más lejos que nosotros.
- **ADR-044 · heurísticas de razonamiento** y **ADR-045 · relectura del plan** amplían lo que la
  capa generativa puede aportar —el olfato del experto senior como doctrina versionada; una
  tercera pregunta del mandato que audita el plan vigente, no solo el mundo— manteniendo el muro:
  no escriben grados, no otorgan atención, no otorgan ejecución.
- **ADR-048 · política de verificación** es el movimiento real y merece escrutinio. La capa
  generativa nombra una comprobación y **la doctrina puede otorgarle ejecución automática
  acotada**, cuyo resultado mueve el grado. Es una vía indirecta del modelo al número que ADR-028
  no contemplaba. Los guardarraíles son serios: solo comprobaciones cuya condición de éxito sea
  expresable en la gramática declarada, evaluación siempre determinista, movimiento del grado
  **solo por el combinador** y con **techo por debajo del peso de un discriminante declarado**,
  acotación a entidades del propio expediente, prohibición del barrido abierto, doble puerta para
  lo sensible, y **cero cláusulas por defecto**. El argumento de producto es fuerte: la hipótesis
  lateral debe llegar resuelta y no cobrarle al operador un peaje de atención por instancia.
  **Veredicto: aceptable, pero es la pieza a vigilar** — es el único sitio del canon donde una
  salida del modelo llega al grado, aunque sea por la puerta determinista.

**Divergencia 4 · confirmada, con mecanismo.** El `banco/README.md` fija un **contrato del arnés**
con tres propiedades que son exactamente nuestra tesis: **solo puerta delantera** —todo entra por
el bus, los consultables y la API de acciones; ningún gancho de prueba altera comportamiento—, el
arnés como dueño del reloj de tiempo de evento, y el expediente como única superficie de
aserción. Y ADR-046 fija la **ciudad de referencia**: un único mundo sintético con todos los
packs de fábrica activos a la vez, del que el València sintético de la PoC es la semilla
(`REQ-xx-REF-nn`; el uso vive en **suites**, no en el identificador).

### Una afirmación nuestra que queda corregida

Escribimos que la tensión entre el **prior suelo** de ADR-028 y el **dominio abierto** de ADR-032
hacía que «lo más importante entre con el grado más bajo», y propusimos un escenario de banco.
**La premisa era equivocada y hay que retirarla:** ADR-048 (5) deja explícito que la atención es
territorio exclusivo de sus tres vías —timbre por anclajes, obligaciones por clase y gravedad
anclada— y que **las tres son ya independientes del grado**. Un suceso grave sin doctrina no
depende de su grado para llegar a un humano: depende de que su clase esté bajo obligación, que es
justo lo que ADR-032 declara. Y ADR-040 añade la **escalada ante plazo en riesgo**, que era la
mitad que faltaba: la obligación cuya atención no llega escala al puesto alternativo y al jefe de
sala, dentro de plazo, en vez de expirar en silencio.

Lo que sobrevive de aquello, ya sin filo de objeción, es **el escenario**: sigue valiendo la pena
que el banco tenga una fila donde un suceso de clase sin suscriptor y gravedad alta alcanza
atención humana **con la capa generativa caída**. Deja de ser una sospecha y pasa a ser la
verificación de una promesa que el canon ya hace.

### Lo que esto cambia en la conversación con Paradigma

Vale la pena decírselo a José tal cual: el canon ya no es una opinión bien escrita. ADR-042 (la
validación reforzada, dos firmas para el aviso público) nace de la FCC tras la falsa alerta de
Hawái y del flujo de aprobación de un producto de mercado; ADR-040 (el eclipse de sala) se apoya
en el semáforo de presión asistencial del CECOES, en el correo de las 18:43 durante la DANA y en
la saturación documentada en Grenfell. Un documento con esa espina dorsal es mucho más difícil de
despachar con un «esto no se puede» — que es, además, lo que ADR-035 (4) ya prohíbe hacer sin
identificador.

## Lo que tenemos y el canon no: candidato a aportación

El mecanismo concreto de resolución de identidades de
[`arquitectura-detallada.md`](arquitectura-detallada.md) §4.D es más fino que nada que exista
hoy en el canon. En concreto:

- Los **dos identificadores con trabajos distintos**: un `match_key`, **HMAC con clave custodiada
  fuera de la base de datos** —corregido el 6-ago-2026; decía «hash con sal», que no aguanta porque
  la sal no es secreta y un DNI son ~10⁸ candidatos—, que sirve para **enlazar** recalculándolo y
  comparándolo, sin guardar nunca la clave en claro; y un `handle` por fuente, que sirve para
  **recuperar** vía consulta federada («dame el registro 4471 de la DGT», no «dame a la persona con
  DNI X»).
- La **excepción tokenizada** para las fuentes que solo admiten consulta por la clave sensible:
  token en el registro y mapeo token↔clave en una bóveda separada, protegida y auditada.
- La distinción **seudonimización frente a anonimización**: un identificador sintético que sigue
  siendo reidentificable cruzando fuentes es dato personal, y sostener lo contrario ante un DPD
  es perder la reunión.

El canon fija hoy el principio —identidades resueltas con procedencia (ADR-004) y minimización
con retención definida (INV-07)— pero no el mecanismo. Y conecta directamente con la única
consulta abierta que arrastra la hoja de ruta del repo: el **modelo de retención y purga** por
clase de dato al cierre del incidente, que tiene principios pero no mecanismo, y que debe
resolver la tensión entre esa minimización, el replay que exige conservar eventos, la
auditoría de accesos y el valor probatorio del expediente.

**Verificado contra el canon v0.5.1 (5-ago).** Sigue siendo un hueco, y de los limpios: en el
maestro de requisitos y en los 48 ADR no aparece ni una vez «seudonimización», «anonimización»,
«tokenización», «bóveda» ni «resolución de identidad». «Retención y purga» aparece tres veces en
los requisitos y en ningún ADR: es decir, sigue siendo **consulta abierta**, exactamente donde la
dejamos.

**Cómo entraría, según las reglas del propio repo.** Como nota de análisis en `docs/apoyo/`
—hoy con la convención de fecha delante que fijó ADR-039: `2026-08-nota-…`—, con la sección
final obligatoria «Qué aprendemos y qué trasladamos al canon», y con un ADR detrás si la
decisión se ratifica. Nunca como parche a un documento existente, y con el borrador de escenario
correspondiente para el banco, porque ningún hallazgo entra al diseño sin su escenario.

## La puerta que el canon nos deja abierta: el esquema del banco

El `banco/README.md` cierra con un **pendiente declarado** literal:

> «El esquema concreto de instancia y el validador `check_banco` —integridad referencial contra
> configuración semántica, consultables y funciones de catálogo (ADR-047)— son **decisión de
> construcción de la PoC**, con la prueba de experto (CFG-05) como criterio temprano.»

Por la frontera de ADR-035 eso es terreno de construcción, es decir, nuestro. Y está en el camino
crítico: `banco/instancias/` y `banco/suites/` están hoy vacías, la fase 1 de la hoja de ruta no
puede cerrar sin ellas, y la puerta de la fase 3 dice que `/src` no arranca hasta que banco y
packs estén validados en simulación.

Es además la forma más limpia de aportar sin pisar a José: el contenido de los escenarios es
suyo —él los revisa uno a uno, es su puerta de fase—; el **formato ejecutable** y su validador
son nuestros. Todo lo que hace falta ya está fijado por él y no hay que inventarlo: la anatomía
de cinco bloques (identidad · versiones fijadas · dado · cuando · entonces), la convención
historia-más-contrato, el contrato del arnés y la nomenclatura `REQ-xx-REF-nn` con las suites
fuera del identificador.

## Lo que la pasada de vocabulario concedió de más (revertido el 1-ago)

Al releer la pasada con el encargo de José delante aparecieron tres sitios donde no se alineó
vocabulario sino que se cedió terreno. El argumento para revertirlos **no discute ninguna
decisión del canon: sale del propio ADR-035**, que parte el mundo en dos ámbitos y declara la
**construcción** —tecnologías, estructura interna, topología— libertad de quien construye, con
el banco como juez único. Importar vocabulario normativo del motor cognitivo a descripciones de
construcción es aplicar el canon fuera de su ámbito.

| Cambio que se hizo | Por qué se revierte |
|---|---|
| «situación / pizarra» → «cuadro de situación» (arquitectura §0, §3, §4.D y el flujo) | El **cuadro de situación** del canon es «la imagen operacional común que existe a cada nivel» (ADR-002): un artefacto de conciencia compartida, por peldaño de la escalera. Nuestra **pizarra** es un almacén de estado caliente sobre el que se coordinan razonadores sin estado. La pizarra *materializa* el cuadro de situación; no es lo mismo. Fundirlos borra la distinción entre lo que la máquina usa para coordinarse y lo que la persona ve, que es justo la distinción que sostiene el control humano. Y la pizarra es construcción: nombrarla es nuestro. |
| «modelo del mundo» → «cuadro de situación» (fontanería §6) | Peor caso del anterior: ahí «modelo del mundo» nombraba un **nivel de almacenamiento** en una lista de niveles de almacenamiento. La sustitución convierte una pieza de infraestructura en un artefacto de presentación. |
| «Arquitectura de referencia» → «especificación» (análisis §1.4 y §4; título de arquitectura §4) | ADR-035 retira «arquitectura de referencia» como **nivel intermedio del canon** —la capa apartable que ya no protegía nada—, no como palabra ni como actividad. Nuestro §4 es un inventario de componentes: construcción pura, terreno declarado libre. Renunciar al término no obedece al canon; solo nos deja sin la palabra en la única conversación donde hace falta (la de abajo). |

Lo que **sí se mantiene alineado**, porque cae de lleno en el motor cognitivo y el canon tiene
razón: detección frente a incidente (ADR-001, ADR-013), los nombres de los razonadores
(ADR-003), el pack como doctrina-configuración (ADR-022), el cobro por vertical (ADR-015) y el
ciclo de vida en cuatro fases.

## Requisitos frente a arquitectura: la discusión que sigue abierta

Es el asunto vivo, y no está en las cuatro divergencias porque no es una divergencia con el
canon sino la pregunta que José tiene sin resolver. En la llamada del 29-jul planteó su miedo:
si entrega a Paradigma requisitos que llevan dentro la arquitectura, le dirán «te has metido en
mi terreno»; y si los parte en dos, «se quedan el funcional y lo otro no lo quieren ni ver». La
propuesta nuestra fue partirlo: requisitos funcionales **y no funcionales**, con la arquitectura
como **consecuencia** de ellos, «porque si no te pueden buscar las castañas por ahí». José la
aceptó como objetivo —«si somos capaces de partir eso en dos, fenomenal»— pero sin verla
posible: «yo no he sido capaz, no soy capaz de separarlo».

El 31-jul la daba explícitamente por viva —«está en vigor la discusión que tuvimos el otro día
de si estos son requisitos o no»— y admitía la debilidad de su posición: «le he dicho que vamos
a acostumbrarnos a no llamarle a esto arquitectura, porque son requisitos… **no sé si es
defendible o no**, pero yo necesito eso».

**Lo que hay que llevarle: ADR-035 ya le da la partición que creía imposible**, y en mejores
términos que los que él temía. La frontera de dos ámbitos dice exactamente lo que necesita
frente a Paradigma:

- El **motor cognitivo** es la norma íntegra —incluidos los requisitos de razonamiento, la
  separación determinista/generativo y el control humano—. Eso es «lo que el producto tiene que
  ser y hacer»: son requisitos, y son suyos.
- La **construcción** —tecnologías, estructura interna, topología— es libertad de Paradigma. Ahí
  no hay injerencia que reprochar, porque se les está dando el terreno entero.
- El **banco** es el juez único, y la cláusula «no hay inviabilidad sin identificador» (ADR-035,
  4) cierra por adelantado la salida de «eso no se puede»: toda alegación se formula contra filas
  concretas del banco y se resuelve con evidencia.

Es decir: la brecha que José temía al partir el documento no se abre, porque lo que queda del
lado libre sigue atado por el banco. La respuesta a «¿son requisitos o arquitectura?» es que la
pregunta estaba mal planteada, y su propio canon ya la reformuló el 28-jul —tres días antes de
que dijera que seguía en vigor—. Conviene que lo sepa antes de la puesta en común, porque es el
argumento con el que entra a esa reunión sin tener que defender que un diseño es un requisito.

## Qué NO se ha tocado, y por qué

La pasada de vocabulario se aplicó solo a los tres documentos pensados para seguir citándose:
el análisis, la arquitectura detallada y la fontanería. Quedan **intactos a propósito**:

- [`vision-producto.md`](vision-producto.md) y [`preparacion-reunion.md`](preparacion-reunion.md),
  que son actas de lo que dijo el cliente y de lo que se preparó para la reunión de julio.
- [`arquitectura-opinion-inicial.md`](arquitectura-opinion-inicial.md), que es la línea base
  formada deliberadamente **sin sesgo**, antes de ver el material: reescribirla destruiría
  justamente lo que la hace valiosa.
- Todo [`presentaciones/`](../presentaciones/), que es material ya presentado. La presentación
  conserva por tanto el vocabulario original —especialista, director, coordinador, candidato—;
  el puente entre ese vocabulario y el vigente está en
  [`equivalencias-de-vocabulario.md`](equivalencias-de-vocabulario.md).

El criterio es el del propio canon de José: las actas no se reescriben, y lo archivado se
conserva porque explicó algo en su momento.

## Pendiente de verificar

El contraste base se hizo contra el canon del 30-jul-2026 (commit `ee0fe75`, ADR-037, índice
v3.3) y la pasada delta contra el del 4-ago (commit `1a69d09`, v0.5.1, ADR-048, índice v3.28),
leído desde `origin/main` sin tocar el árbol de trabajo del repo de José.

Sigue **sin leerse el hilo de WhatsApp con José desde el 7 de julio** (el conector estaba caído
y luego limitado por cuota). Si en esa conversación hay instrucciones sobre el repo que no estén
ni en su `CLAUDE.md` ni en las instrucciones del proyecto, este documento puede necesitar una
revisión.

De la pasada delta quedan **dos cosas leídas por encima**, por no ser camino crítico para el
viernes: el corpus de contraste (36 fichas de fuentes primarias) y las 20 fichas de planes
territoriales. Se ha leído su efecto sobre los ADR, no las fichas en sí.

Las transcripciones verbatim de las llamadas del 29 y el 31 de julio **sí** están ya leídas
(Granola, 1-ago), y son la fuente de las citas de este documento. La revisión de postura y las
dos secciones nuevas salen de ahí.
