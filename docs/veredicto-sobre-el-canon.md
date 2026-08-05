# Veredicto sobre el canon

> **Para José · 5-ago-2026** · Respuesta a lo que pediste el 31-jul: «que me digas: ok, la veo
> bien y puede usarse como referencia, o esto no lo veo, o esto hay que cambiarlo antes de que
> se lo des a los del otro lado». Van los tres cajones, en ese orden.
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

### En una frase

El canon está bien y puede usarse como referencia; lo que hay que arreglar no es lo que dice,
sino **a quién se le da y en qué formato**, y falta la pieza que lo convierte en juez — el banco
ejecutable.
