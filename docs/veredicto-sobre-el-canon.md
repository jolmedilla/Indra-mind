# Veredicto sobre el canon

> **Para José · 6-ago-2026** · Tres partes, que responden a las tres cosas que has pedido.
>
> **1. El veredicto** sobre el canon: «que me digas: ok, la veo bien y puede usarse como
> referencia, o esto no lo veo, o esto hay que cambiarlo antes de que se lo des a los del otro
> lado» (31-jul) — van los tres cajones, en ese orden.
> **2. El alcance al que me comprometo**, con número de hito: «¿tú te comprometes a hacer esto de
> aquí a septiembre?» (29-jul).
> **3. El reparto con Alex**, sobre lo que dijiste que no habías llegado a pensar todavía.
>
> Revisado: canon `indramind-poc` en `1a69d09` (4-ago) — requisitos v0.5.1, ADR-001..048,
> POC-001..005, banco REQ-01..61, `/banco` recién creado. El detalle de cada punto está en
> [`divergencias-con-el-canon.md`](divergencias-con-el-canon.md).

## 1 · La veo bien, y puede usarse como referencia

**Sí, con confianza.** No es una validación de cortesía: he ido a buscar dónde se rompía y en lo
esencial no se rompe. Tres cosas que quiero que consten.

**Absorbió lo que llevamos a la reunión del 14-jul, y en varios sitios lo mejoró.** El caso más
claro es el grado de confianza. Nuestro documento decía que el razonador «emite con confianza» y
dejaba sin dueño explícito quién escribe ese número — un hueco real. ADR-028 lo tapó y ADR-047
le puso mecanismo: el **combinador de grados** es una función de catálogo única y obligatoria en
todo despliegue, de modo que un grado significa lo mismo venga del pack que venga. Eso es mejor
de lo que nosotros teníamos.

**La separación determinista/generativa es la mejor parte del diseño.** Es la pieza que Paradigma
va a atacar —«esto es un envoltorio alrededor de un LLM»— y es justo donde el canon está más
blindado: el modelo propone contenidos y nunca escribe grados; la atención la otorgan cláusulas
declaradas, nunca el juicio mismo; las tres vías de atención son independientes del grado. Con
ADR-044 y ADR-045 encima, el saber lateral del experto entra como doctrina versionada y citable
en vez de como intuición del modelo en caliente. Eso responde a la objeción antes de que se
formule.

**Ya no es una opinión bien escrita: tiene espina dorsal de evidencia.** ADR-042 (dos firmas para
el aviso público) sale de la recomendación de la FCC tras la falsa alerta de Hawái y del flujo de
aprobación de un producto de mercado. ADR-040 (el eclipse de sala) se apoya en el semáforo de
presión asistencial del CECOES, en el correo de las 18:43 durante la DANA y en la saturación
documentada en Grenfell. Un documento así es mucho más difícil de despachar.

## 2 · Esto no lo veo

Dos cosas. La primera es sobre tu forma de presentarlo, no sobre el contenido; la segunda es
sobre el artefacto.

**a) «Todo esto son requisitos» no se sostiene, y no lo necesitas.** Me dijiste el 31-jul que no
sabías si era defendible. No lo es: si le dices a un equipo técnico que un diseño es un
requisito, te van a buscar las castañas por ahí y tendrán razón. Pero el problema que intentas
resolver con esa etiqueta ya está resuelto **dentro de tu propio canon**, y mejor. ADR-035
—del 28 de julio, tres días antes de que me dijeras que la discusión seguía viva— parte el mundo
en dos ámbitos:

- **motor cognitivo** = la norma íntegra, incluidos los requisitos de razonamiento y el control
  humano. Eso es lo que el producto tiene que ser y hacer. Son requisitos, y son tuyos.
- **construcción** = tecnologías, estructura interna, topología. Libertad de Paradigma. Ahí no
  hay injerencia que reprocharte, porque les estás dando el terreno entero.
- **el banco** = juez único. Y «no hay inviabilidad sin identificador»: nadie puede decir «esto
  no se puede», tiene que decir «esto falla en la fila REQ-nn».

La brecha que temías al partir el documento no se abre, porque lo que queda del lado libre sigue
atado por el banco. Entra a la reunión con esto y no con «son requisitos, punto».

**b) El canon es excelente como canon e inservible como entregable.** Esto es lo que me
incomoda decirte y por lo que me pediste que lo mirara. Está escrito para un lector —tú, con
Claude recuperando por identificador— y funciona muy bien para eso. Pero el lector del otro lado
es distinto y no es amistoso: párrafos únicos de cuatrocientas palabras con quince referencias
cruzadas, 48 ADR, 61 filas, un corpus de 36 fuentes y 21 visuales, producidos en tres semanas.
Un ingeniero de Paradigma que abra eso tiene dos salidas fáciles, y las dos te perjudican: «esto
no hay quien lo lea» y «esto lo ha escrito una IA». La densidad que a ti te da precisión, a ellos
les da munición.

No propongo reescribirlo —sería tirar el trabajo, y como canon está bien—. Propongo **derivar**
un entregable distinto, que es el punto 3.a. Los visuales sugieren que ya lo estabas viendo.

## 3 · Esto hay que hacerlo antes de dárselo a los del otro lado

Por orden de importancia.

**a) Separar el entregable del canon.** Lo que va a Paradigma es: el **banco** (las 61 filas, que
son el contrato), los **invariantes**, y la **frontera de dos ámbitos**. Nada más. Los 48 ADR son
el *porqué*, y se ofrecen a demanda: «¿por qué esto es así? mira ADR-nn». Así el paquete es
corto, verificable y no parece un intento de diseñarles el sistema.

**b) Cerrar el banco ejecutable — es el camino crítico.** Las 61 filas normativas existen;
`banco/instancias/` y `banco/suites/` están **vacías**, y la fase 1 sigue sin registrarse: el
contador de decisiones de PoC está en POC-005 y el POC-006 que tu hoja de ruta anuncia todavía no
existe. Sin instancias no hay juez, y sin juez
toda la estrategia se cae: no puedes darles las mismas reglas a los dos lados si las reglas no se
pueden ejecutar. Tu propia hoja de ruta dice que `/src` no arranca hasta que banco y packs estén
validados en simulación. El `README` del banco declara pendiente justo lo que lo desbloquea —el
esquema concreto de instancia y el validador `check_banco`— y lo declara **decisión de
construcción**, que por ADR-035 es mi terreno. **Me ofrezco a eso**: el formato ejecutable y el
validador son míos; el contenido de los escenarios sigue siendo tuyo y los revisas uno a uno,
que es tu puerta de fase.

**c) Blindar ADR-048 con una fila de banco.** Es la única puerta del canon por la que una salida
del modelo llega al grado de confianza —acotada, determinista y con techo, pero existe—. El
diseño me parece bien; lo que no puede ser es que sus guardarraíles estén solo declarados. Una
fila que verifique: cero ejecuciones sin cláusula declarada, cero cláusulas por defecto, y que el
peso del resultado nunca supere el techo del discriminante. Si Paradigma busca el punto flaco,
buscará ahí; conviene llegar con la prueba hecha.

**d) Una fila del dominio abierto con la capa generativa caída.** Que un suceso de clase sin
suscriptor y gravedad alta alcance atención humana con lo generativo apagado. El canon ya lo
promete —ADR-032 más la escalada ante plazo en riesgo del ADR-040—; falta demostrarlo. Es además
el mejor argumento comercial que tienes: «día uno con red».

**e) Cerrar retención y purga, que es la única consulta abierta y la más expuesta.** El canon fija
los principios (minimización con retención definida, auditoría de accesos, valor probatorio del
expediente) pero no el mecanismo, y la tensión con el replay —que exige conservar eventos— sigue
sin resolver. «No habéis resuelto el RGPD» es la objeción más barata que te pueden hacer y la
única que puede pararte por fuera del debate técnico. **Aquí tengo material que el canon no
tiene**: el mecanismo de resolución de identidades de nuestra arquitectura detallada —los dos
identificadores con trabajos distintos (`match_key` irreversible para enlazar, `handle` por
fuente para recuperar), la excepción tokenizada con bóveda separada, y la distinción entre
seudonimizar y anonimizar—. Lo he verificado contra el canon del 4-ago: ninguno de esos términos
aparece ni una vez en los 48 ADR ni en el maestro. Entraría como nota de análisis en
`docs/apoyo/`, con su borrador de escenario, por el ciclo normal.

---

### El veredicto en una frase

El canon está bien y puede usarse como referencia; lo que hay que arreglar no es lo que dice,
sino **a quién se le da y en qué formato**, y falta la pieza que lo convierte en juez — el banco
ejecutable.

---

# Alcance al que me comprometo

Me preguntaste el 29-jul si me comprometía a esto de aquí a septiembre. Sí, y va con número de
hito para que el compromiso signifique algo.

## Me anclo a tu propio mecanismo

> «**Los hitos son el seguro de la fecha:** si el mes acaba en H2, se demuestra un H2 coherente;
> el núcleo vinculante de POC-001 no se recorta — la demo se ancla a hitos, no al núcleo
> completo.»

Eso está bien pensado y es lo que hace que esto no tenga que ser una apuesta. Así que no digo
«haré la PoC»: digo **H1 en verde con sus ablaciones, y H2 hasta donde llegue.**

Y conviene notar que tu H1 y lo que nosotros habíamos puesto como criterios de éxito en julio son
la misma cosa. Tú lo describes como «detección anticipada, espejo de mascletà»; nosotros
escribimos antelación ≥ 20 min y «con una mascletà en agenda, NO alerta». Son REQ-01 y REQ-02.
Llegamos al mismo sitio por separado, que es la mejor señal de que es el sitio correcto.

## La rebanada

Lo que ya estaba descrito en [`arquitectura-detallada.md`](arquitectura-detallada.md) §5, sin
cambios: simulador de fuentes, 4-5 tipos de evento, baselines y correlación en código llano, **un**
razonador de dominio (pack de aglomeraciones), estado en SQLite, y un panel que reutiliza la
estética que ya existe. Backend FastAPI, bus una cola en proceso, razonador contra la API de
Claude. Sin tecnología pesada — que es parte del mensaje: **la arquitectura depende de funciones,
no de un clúster ni de un producto de grafos.**

## Lo importante: instrumentar para ablación, no para cobertura

Aquí está lo que hace esto viable en el tiempo que tengo, y es una decisión de ingeniería que
merece discutirse.

El 29-jul hablabas de «siete, diez, quince escenarios» de ablación. Pero el poder discriminante no
está repartido por igual: está concentrado en muy pocas filas. **Dos filas y dos perfiles dan el
argumento completo:**

| | **P0** · umbrales simples | **P1** · con razonador de dominio |
|---|---|---|
| **REQ-01** — convergencia de fuentes independientes, sin evento en agenda | detecta tarde, o no detecta | detecta ≥ 20 min antes de la referencia humana |
| **REQ-02** — la misma convergencia, pero con una mascletà en la agenda | **salta: falsa alarma** | no interrumpe; registra «evento esperado» con la alternativa descartada y su motivo |

Cuatro ejecuciones, y prueban las dos mitades a la vez: que la pieza hace falta, y que sin ella el
sistema o es ciego o es un histérico. Eso es literalmente «le quito una pieza al coche y el coche
no cumple», y es lo que convierte una demo en un argumento.

**Distinción que conviene mantener**, porque son dos cosas y se confunden:

- **El núcleo** —las filas que tienen que correr en verde en el perfil completo— lo defines tú
  escenario a escenario, que es la puerta de tu fase 1. Puede ser bastante más que dos.
- **La instrumentación de ablación** se concentra en esas dos. Ablacionar todo cuesta caro y no
  añade fuerza al argumento: multiplica ejecuciones sin multiplicar evidencia.

## Qué queda fuera, dicho ahora y no en septiembre

**H3** (sala completa: fusiones, sectorización, arbitraje) y **H4** (capa de demo completa,
videowall, consola del presentador, ensayo general). Y la **ciudad de referencia** de ADR-046 con
todos los packs de fábrica activos a la vez: eso es banco de producto, no de PoC — la semilla de
València germina hacia ahí, no nace ahí.

Sobre el reparto de mi dedicación, para que el compromiso sea creíble y no un número al aire: de
las ~38 horas del periodo, unas 5 van a seguimiento, ~8 al arnés del banco y `check_banco`, ~6 al
entregable derivado y a la nota de retención y purga, y **quedan ~19 para construir**. Con Claude,
19 horas dan H1 sólido con sus ablaciones y H2 empezado — el razonador de incidente proponiendo
misiones, probablemente sin replanificación.

## Y esto ya te cierra la puerta que quieres cerrar

No hace falta llegar a H3 para poder decir lo que querías decir. Con H1 en verde y las cuatro
ejecuciones de ablación delante, ya tienes: «no me digas que no se puede, porque aquí lo tienes
funcionando; ahora, si lo quieres hacer de otra manera, **igualámelo contra esto**». El benchmark
existe desde el primer hito, y crece después.

---

# Reparto propuesto con Alex

Dijiste el 31-jul que tenía que ser algo colaborativo y que no habías llegado a pensar cómo. Va
una propuesta, con el razonamiento delante para que puedas discutirla por partes.

## El principio: juez y juzgado no pueden ser el mismo

Si yo construyo el motor **y** el arnés que lo juzga, me estoy escribiendo el examen. Ese es el
único argumento con el que Paradigma puede desacreditar el resultado sin entrar en el fondo, y es
gratis de usar. Conviene cerrarlo desde el principio y no cuando ya moleste.

Hay además una frase tuya que impone una condición al reparto: «tenemos que, el día que haya que
comparar, decir: no, no, **esto es una cosa que hemos hecho a ratos**». Para que eso sea verdad,
Alex tiene que haber construido algo. Un papel de solo revisar documentos no sostiene esa frase, y
sostenerla en falso es peor que no tenerla — se desmonta con dos preguntas.

## Dónde poner la frontera

La credibilidad no viene de quién escribió el arnés: el arnés es determinista y cualquiera puede
inspeccionarlo. Viene de **quién definió qué cuenta como fallo y quién firma el resultado**. El
arnés es la regla de medir; las ablaciones son el examen. Da igual quién fabricó la regla si está
calibrada; importa mucho quién escribe el examen y quién corrige.

| Pieza | Quién | Por qué |
|---|---|---|
| **El arnés** — esquema de instancia, reloj de tiempo de evento, motor de aserciones, `check_banco` con integridad referencial contra los tres catálogos (ADR-047) | **Yo** | Es infraestructura en camino crítico: tu hoja de ruta dice que `/src` no arranca hasta que el banco valide en simulación. No puede depender de una semana de ofertas |
| **Las ablaciones** — los perfiles P0–P3, las suites, y **correrlas** | **Alex** | Es donde vive el juicio, es lo que se apunta a Paradigma, y es él quien tendrá que defender ante los suyos que los perfiles son justos. Cae además en fase 4, semanas 3-4 |
| **El veredicto de cada entrega** — declarar verde o rojo | **Alex** | Yo construyo el instrumento; él lo lee y firma |
| **Segundo lector de las filas del banco**, y filtro de salida: nada va a Paradigma sin que lo haya leído | **Alex** | El encargo no es «¿está bien?» sino «**¿podrás defender esta fila dentro de Paradigma?**». Cada fila que no pase ese filtro explota después. Y el filtro de salida es lo que hace cierto que esto no llega de la nada |
| **Los segmentos sintéticos y el render de la demo** (A y C de tu hoja de ruta) | **Yo**, con Claude | En la iteración 1. Si aparece un tercero, entra por aquí |

## Un criterio general, que vale más que este reparto concreto

A Alex conviene darle **decisiones y revisiones con fecha, no código en el camino crítico.** Lo
primero sobrevive a una semana de ofertas; lo segundo bloquea a todo el mundo.

## Dos cosas que hay que cerrar para que esto funcione

**El punto de acoplamiento**, que ya tienes resuelto en la hoja de ruta y solo hay que pactar en
voz alta: «el esquema de eventos es el único artefacto que tocan los tres — lo custodia B y solo
cambia con versión y aviso». Con eso dicho, Alex y yo trabajamos en paralelo sin bloquearnos.

**Cuántas horas puede poner Alex de verdad.** Dijiste que yo tendría más tiempo que él, pero sin
número. De eso depende si las ablaciones son suyas de principio a fin o si él escribe los perfiles
y las corro yo — que sigue separando juez de juzgado, aunque más justito.

## Cadencia

El ratito diario que pediste cuando estés, más un punto semanal de media hora los tres **contra el
estado del banco**. Tener el banco como orden del día es lo que evita que la reunión se convierta
en intercambio de opiniones.
