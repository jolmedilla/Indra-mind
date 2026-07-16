# Preparación de la primera reunión

> **Fecha objetivo:** este viernes (o, como muy tarde, el viernes siguiente, antes de que
> Marcelo se vaya de vacaciones). Asisten: José, Marcelo (jefe), preventa «todoterreno» y
> perfil de diseño de producto/UX. **No** Paradigma. Duración ~2–4 h.
>
> Basado en [`analisis-y-recomendacion.md`](analisis-y-recomendacion.md). Lo que José necesita
> de mí: **autoridad técnica imparcial** para decir con criterio «esto se hace así», y
> desbloquear la situación.

## Objetivo de la reunión (lo que José espera)

1. Mi **visión**: ¿es viable? ¿dónde están los problemas?
2. **Arquitectura a alto nivel**: cómo lo haría, qué equipo, qué tiempos.
3. **Propuesta de PoC** rápida (plan B) si deciden ir por ahí.

Y, transversal: hablar **con autoridad** para que puedan apoyarse en mí frente a quien venga
«con peteneras». No hace falta tener la verdad absoluta; sí criterio de peso y neutralidad.

## Los 5 mensajes que quiero que se lleven

1. **«Es viable, y no es física nuclear.»** El razonamiento que buscáis es sencillo y lateral;
   un LLM actual ya lo hace. El valor —y el 80% del trabajo— está en la **arquitectura que
   integra muchas fuentes y lo orquesta en tiempo casi real, fiable, trazable y soberano**.

2. **«El problema es de fontanería y de foco, no de inteligencia.»** Integración de datos +
   eventos en tiempo real primero; IA después. Paradigma ha empezado la casa por el tejado:
   30 personas por módulos sin haber definido qué es un *incidente*.

3. **«Ontologías: sí como modelo de datos mínimo, no como motor de razonamiento.»** (Guion
   detallado abajo — es el *challenge* central.)

4. **«La arquitectura correcta ya está casi dibujada»**: percepción compartida (eventos
   tipados) + tres niveles de razonamiento (especialista / director / coordinador) + escalera
   de atención + control humano + trazabilidad. Configuración declarativa sobre motor
   genérico. (Ver análisis §4.)

5. **«El camino es una PoC vertical fina, estilo startup, con Claude»**, sobre València
   (aglomeraciones). Equipo pequeño, semanas, métricas de éxito conductuales. (Análisis §6.)

## Guion para el *challenge* de las ontologías

Orden sugerido para decirlo con autoridad y sin sonar dogmático:

1. **Dar la razón donde la tienen** (esto da credibilidad): «Las ontologías como *motor de
   razonamiento* son un paradigma de los 80–90 —árboles de conocimiento hechos a mano,
   deterministas, lentísimos de construir y rígidos—. Los transformers los superan. En eso
   coincidís tú, tu amigo y yo, y la industria.»

2. **Reencuadrar, no negar** (esto evita la guerra y demuestra dominio): «Pero hay tres
   funciones que un transformer no sustituye y que este producto necesita: (a) **correlación
   determinista** a velocidad de máquina, reproducible y explicable ante un juez; (b)
   **resolución de identidad con procedencia** (que dos registros sean la misma persona no
   puede ser una corazonada de *embeddings* si acaba en un atestado); (c) **memoria estructurada
   consultable con exactitud**. Esas tres exigen **esquemas** —eventos y entidades tipados—.»

3. **Rebautizar** (esto desactiva la alergia al término): «Lo que hace falta no es una
   *ontología*, es un **modelo de eventos y entidades mínimo y gobernado**; y lo que llamáis
   *grafo* es una **capacidad** (identidad + relaciones + recorrido + procedencia), **no una
   tecnología**: a escala ciudad puede correr sobre PostgreSQL. Hagamos del almacén un
   *benchmark* de la PoC, no un dogma.»

4. **El argumento que gana con cliente público:** «No volcamos el padrón ni la DGT: guardamos
   identidades y relaciones, y **federamos el resto bajo demanda con auditoría**. Eso es
   **minimización de datos = soberanía y RGPD *by design***. El día que un DPD pregunte *dónde
   están mis datos*, la respuesta gana la reunión.»

5. **Cierre:** «No me reafirmo en *ontologías y grafos*; me reafirmo en **esquemas, identidad,
   relaciones y procedencia**. Eso lo necesitamos sin discusión. Lo que sobra es la
   mega-ontología como almacén y la ontología como razonador.»

## Anticipar objeciones («las peteneras»)

- **«Esto para tiempo real no vale.»** → El razonamiento cognitivo no corre en cada frame:
  corre la **escalera de atención** (percepción barata → baselines → CEP determinista → LLM
  solo ante evento candidato). Y muchos casos (DANA: horas) no son de segundos. Tiempo real
  donde hace falta; minutos donde basta.
- **«Sin ontología el sistema no entiende el dominio.»** → El LLM ya entiende el dominio; la
  ontología es para *homogeneizar datos*, y mínima. (Ver guion.)
- **«¿Y la memoria / que no se pierda el contexto?»** → Razonadores **sin estado**; el estado
  vive fuera (situación + expediente estructurados); el contexto se reconstruye acotado. No
  hay conversación larga que compactar. (Análisis §5.)
- **«Necesitamos 30 personas / 2 años.»** → Para la PoC, no: equipo pequeño + Claude, semanas.
  Los 2 años son la **«consultoría cognitiva»** de volcar la doctrina de cada cliente, no la
  ingeniería del motor.
- **«¿No lo hace ya alguien? / nadie lo hace.»** → Matizar con rigor (ver
  [`analisis-competitivo.md`](analisis-competitivo.md)): *nadie ofrece el motor cognitivo de
  fusión multidominio con soberanía*, pero **sí** hay incumbentes grandes en capas adyacentes —
  **Ericsson** (conectividad; y dueña de **Vonage/Carbyne**), **Carbyne/Motorola/Hexagon**
  (gestión de llamadas NG911, varios US-cloud), y **Palantir** (fusión/razonamiento). Foso de
  IndraMind = **fusión multidominio + soberanía + doctrina vertical**. Y **no** reconstruir
  NG911: integrarlo como una fuente más y poner el valor encima. Refuerza ir **rápido y
  vertical**, porque los incumbentes están subiendo por el *stack*.

## Postura política (José lo pidió explícitamente)

- Soy **externo, por horas, sin intereses ni ganas de tenerlos**. Eso es mi activo: neutralidad.
- No vengo a ganar una guerra a Paradigma, sino a dar **criterio de peso** para desbloquear.
- Ser justo con Paradigma (buen equipo, buen líder, pero enfoque en centro de gravedad
  equivocado) da más autoridad que descalificar.

## Referencia estética (para *nuestra* presentación)

Merece la pena alinear el aspecto con el suyo (coherencia de marca IndraMind):

- **Tono:** oscuro, cinematográfico, «seguridad cognitiva». Fondos negro/azul marino con
  imágenes nocturnas de ciudad y sala de control. Acentos **cian/azul**, toques naranja/rojo.
- **Tipografía:** sans-serif limpia; wordmark **IndraMind** con «Security» en peso ligero.
- **Recurso emocional de cierre:** el **ojo rojo tipo HAL 9000** con anillos concéntricos
  («Una inteligencia viva… Viendo / Entendiendo / Recordando todo»). Potente; podemos hacer un
  guiño respetuoso.
- **Diapositivas de credibilidad:** fondo claro + tarjetas (recortes de prensa, verticales con
  iconos de línea fina).
- Fotogramas de referencia extraídos del vídeo, en el scratchpad de la sesión (21 escenas:
  portada, «guerra híbrida», los 4 dominios, las 3 demos, cierre HAL). **Pendiente:** decidir
  si guardamos una selección limpia en `docs/assets/`.

## Preparar antes del viernes

- [ ] Un guion visual de 6–10 diapositivas (visión → diagnóstico → ontologías → arquitectura
      3 niveles → PoC → equipo/tiempos), en la estética anterior.
- [ ] Un diagrama de la arquitectura (percepción → 3 niveles + escalera de atención).
- [ ] Cerrar el alcance concreto de la PoC de València con métricas conductuales.
- [ ] (Opcional pero potente) un mini-esqueleto de simulador + un pack de razonamiento como
      prueba de que «esto se puede montar en días».
