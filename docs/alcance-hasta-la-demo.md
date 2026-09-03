# Qué se puede demostrar, y cuándo

> **Material de trabajo para la reunión del 4-sep-2026 con José y Alejandro** ·
> Escrito el 3-sep-2026 contra el canon en `b3fd346` y la línea de construcción de
> Juanjo en `7d5fd8a`.
>
> No es un compromiso. Es el material con el que decidir el alcance, y nace de un
> pendiente propio: la horquilla de «finales de octubre» se dio el 19-ago sin
> datos y cuando el alcance era otro.

---

## 1 · Lo que cambió, en una tabla

| | 19-ago-2026 | 3-sep-2026 |
|---|---|---|
| Plan del banco | filas por lotes, sin película | **storytelling** con prólogo, tres actos, epílogo y gesto en vivo |
| Filas obligatorias | 22 | **25** (+15 deseables) |
| Instancias previstas | «12–15» | **18**, con su suite candidata |
| Instancias con ensayo generativo | ninguna decidida | **6**, contador sellado en N=6 |
| Instancias escritas | 1 | **1** |

El alcance creció; lo escrito, no.

## 2 · El dato que más condiciona la fecha, y no depende de esta línea

De las dieciocho instancias, **una está escrita** (`REQ-07-VLC-01`) y **diecisiete
están «por redactar»**. Las instancias son materia del canon y las escribe el
responsable del plano funcional, no una línea de construcción.

Esto no es un reproche: es que **hay dos caminos críticos y solo uno es nuestro.**
Por muy rápido que vaya el motor, una instancia sin escribir no se puede ejecutar.
Y la suite se congela en la consolidación de septiembre.

## 3 · La matriz: qué exige cada instancia y qué existe hoy

Estado de la capacidad en la línea de Juanjo: **✓** construida y con spec ·
**≈** a medias · **✗** no existe.

### Prólogo — la madrugada de la nave

| Instancia | Filas | Lo que exige del motor | Hoy |
|---|---|---|---|
| `REQ-07-VLC-01` | REQ-07 | resolución de objeto ✓ · clase y reclasificación ✗ · despertares con disparador ✗ · dos packs sobre la misma pizarra ✗ · consultables con resultado literal ✗ · pizarra ✗ · proyecciones ✗ · atención con vencimiento y vía ✗ · criticidad ✗ | **≈** solo la aserción (a), y a la altura del objeto |
| `REQ-03-VLC-01` | 03, 28, 33 | consultables automáticos antes de emitir ✗ · discriminante físico pendiente con su misión ✗ · cadena de evidencia navegable ✗ · auto-ejecución registrada ✗ | ✗ |
| `REQ-47-VLC-01` | 47, 48 | **capa generativa** ✗ · heurística del pack con autor y versión ✗ · timbre solo por cláusula con anclaje ✗ | ✗ |
| `REQ-50-VLC-01` | 50, 48 | **capa generativa** ✗ · gravedad solo con ancla real ✗ · válvula con tope ✗ | ✗ |

### Acto I — el día de la mascletà

| Instancia | Filas | Lo que exige del motor | Hoy |
|---|---|---|---|
| `REQ-02-VLC-01` | 02 | convergencia multi-fuente ✓ · agenda como discriminante ✓ · política de interrupción ✓ | **≈** la conducta está; falta la cinta y la instancia canónica |
| `REQ-38-VLC-01` | 38, 63 | declaración operativa en caliente ✗ · vigencia y vencimiento automático ✗ · expectativa incumplida ✗ · ventana de riesgo ✗ | ✗ |
| `REQ-65-VLC-01` | 65 | estado declarado frente a calculado, juntos y distintos ✗ | ✗ |

### Acto II — la tarde de la concentración

| Instancia | Filas | Lo que exige del motor | Hoy |
|---|---|---|---|
| `REQ-24-VLC-01` | 24, 39 | salud de fuente con doble efecto ✗ · descuento de confianza señalado ✗ · evento-indicio ✗ · frescura y herencia de caducidad ✗ | ✗ |
| `REQ-20-VLC-01` | 20, 22 | comprensión de señal críptica ✗ · cuarentena ✗ · **capa generativa** ✗ · esquema versionado por ratificación ✗ | ✗ |
| `REQ-66-VLC-01` | 66, 55, 54, 37 | situación sin doctrina ✗ · caída total de la generativa ✗ · calificación conjunta ✗ · marcado ✗ · **capa generativa** ✗ | ✗ |
| `REQ-01-VLC-01` | 01, 08, 64, 11 | convergencia ✓ · proyección con banda y horizonte ✗ · consecuencia declarada pegada al triplete ✗ · aguante ante caída de fuente ✗ | **≈** solo la anticipación |
| `REQ-09-VLC-01` | 09, 56 | umbral de interrupción por grado ✗ · expediente silencioso consultable ≈ · descarte que conserva evidencia ✗ | ✗ |

### Acto III — la noche del incidente

| Instancia | Filas | Lo que exige del motor | Hoy |
|---|---|---|---|
| `REQ-13-VLC-01` | 13, 04, 25 | fusión silenciosa ✓ · **misiones propuestas** ✗ · misión de verificación con ratificador ✗ · presupuesto de latencia medido ✗ | ✗ |
| `REQ-05-VLC-01` | 05, 35 | arbitraje escalado ✗ · comparativa del recurso escaso ✗ · el silencio del humano no cambia nada ✗ | ✗ |
| `REQ-49-VLC-01` | 49, 37, 57 | **capa generativa** ✗ · valoración que espera a que abras ✗ · consulta que declara la ausencia ✗ | ✗ |
| `REQ-60-VLC-01` | 60, 18 | eclipse de sala ✗ · obligación de atención con plazo ✗ | ✗ |

### Epílogo y gesto

| Instancia | Filas | Lo que exige del motor | Hoy |
|---|---|---|---|
| `REQ-12-VLC-01` | 12, 34 | ciclo de corrección de doctrina ✗ · replay con doctrina corregida D1→D2 ✗ · serie temporal de la confianza ✗ | ✗ |
| `REQ-21-VLC-01` | 21 | mapeo asistido en vivo ✗ · **capa generativa** ✗ | ✗ |

**Resumen:** de dieciocho, **ninguna pasa hoy entera**. Una va por su primera
aserción de cinco y otra tiene la conducta pero no la cinta.

## 4 · Los bloques de trabajo, ordenados por lo que desbloquean

| # | Bloque | Desbloquea | Por qué va donde va |
|---|---|---|---|
| A | **La pizarra completa**: clase y reclasificación, despertares, dos packs, consultables, atención, criticidad, proyecciones | 1 entera, y es cimiento de casi todo | Sin pizarra no hay dónde escribir lo que las demás producen. Es también lo que cierra la instancia de aceptación común |
| B | **Razonador de incidente**: misiones, ratificador, presupuesto de latencia | 1 entera (`REQ-13`), y una rebanada de `REQ-07` | **Es el compromiso firme de mediados de septiembre** |
| C | **Capa generativa**: punto único, marcado, anclajes, válvula, presupuesto, pasada cacheada | **6 instancias**, 4 de ellas obligatorias | Es el bloque que más desbloquea, y el único eje que la línea no ha tocado |
| D | **Salud, frescura y aguante de fuente** | `REQ-24` entera, y un tercio de `REQ-01` | Barato y aparece en dos actos |
| E | **Proyecciones y consecuencia declarada** | completa `REQ-01`, la pieza central del acto II | Necesita la pizarra (A) |
| F | **Declaración operativa y estado declarado** | `REQ-38`, `REQ-65` — deseables puras | Recortables sin tocar el umbral |
| G | **Razonador de sala**: arbitraje, comparativa, eclipse, obligaciones con plazo | `REQ-05`, `REQ-60` | Tercer razonador; nada de esto existe |
| H | **Ciclo de corrección de doctrina** D1→D2 | `REQ-12`, el cierre del epílogo | Es el golpe de efecto de la demo, y depende de que el replay sea sólido |
| I | **Inspector: cadena de evidencia navegable** | `REQ-03`, y es la superficie que se enseña | Media capa de demostración |

## 5 · Los tres escenarios

**La unidad.** Los bloques se estiman en **sesiones de trabajo**, y una sesión es
lo que produjo el 25-ago: la resolución de objeto, la doctrina fuera del código y
la traza, tres pull requests. Con seis horas semanales declaradas —más holgura en
octubre, después del TFM— eso es **aproximadamente una sesión por semana**.

Coste estimado: A ≈ 2 · B ≈ 2 · C ≈ 3 · D ≈ 1 · E ≈ 1 · F ≈ 1 · G ≈ 2 · H ≈ 2 ·
I ≈ 2 → **16 sesiones de motor**. Más las transcripciones ejecutables de las
dieciocho instancias (≈ 9) y las propuestas al canon (≈ 2): **27 sesiones**.

| | Semanas disponibles | Qué entra | Qué queda fuera |
|---|---|---|---|
| **Finales de octubre** | ~8 | A, B, D, E y las transcripciones de lo que haya escrito: **el prólogo determinista y la pieza central del acto II** | Todo lo generativo, el acto III entero, el epílogo y el gesto en vivo |
| **Finales de noviembre** | ~13 | lo anterior más **C**: entran las cuatro obligatorias generativas y el acto II queda entero | El acto III, el epílogo, el inspector |
| **Finales de diciembre** | ~17 | lo anterior más G o H, no las dos | Una de las dos, el gesto en vivo y las deseables puras |

**La suite completa no cae dentro de ninguno de los tres.** A este ritmo son unas
veintisiete semanas: **finales de febrero**.

## 6 · Lo que yo recomendaría decir

**Que finales de octubre no da para el demostrador entero, y que decirlo hoy vale
más que descubrirlo en noviembre.** José dejó la fecha discutible por acuerdo, y
él mismo puso el criterio el 19-ago: *«prefiero que los cimientos estén bien… que
el día que lo presentemos sea, de verdad, una base»*.

Tres maneras de cerrar el hueco, y no son excluyentes:

1. **Recortar el alcance de la demo.** Las cuatro deseables puras
   —`REQ-38`, `REQ-65`, `REQ-60`, `REQ-21`— salen sin tocar el umbral vinculante,
   y con ellas el bloque F entero. Eso es una demo más corta, no una demo peor.
2. **Mover la fecha a finales de noviembre**, que es lo que hace falta para que
   entre la capa generativa. Y la capa generativa es justo lo que distingue este
   producto de un PSIM: sin ella, la demo enseña un correlador determinista muy
   bien hecho.
3. **Meter más manos.** POC-007 admite N líneas de construcción, y hoy hay una.
   Alejandro estaba en seguimiento y validación porque trabajar los dos a la vez
   era caro; con el canon mucho más asentado que en agosto, esa razón es más
   débil que entonces.

**Y una que no cuesta calendario:** las diecisiete instancias sin redactar son el
otro camino crítico, y no es nuestro. Cuanto antes existan, antes se pueden
ejecutar. Vale la pena preguntar qué necesita José para escribirlas y si algo de
eso lo puede adelantar esta línea.

## 7 · Lo que esta estimación no garantiza

- **La suite es candidata, no congelada.** El Acto I y el gesto en vivo no están
  ratificados. Si la composición cambia, esto cambia.
- **La prosa no mide esfuerzo.** Dos escenas del mismo tamaño en el storytelling
  pueden costar muy distinto; los bloques se han estimado por capacidad, no por
  escena.
- **La sesión como unidad viene de una sola muestra**, la del 25-ago. Es la mejor
  que hay y es poca.
- **No incluye la capa de demostración.** Lo que se enseña en pantalla no está
  contado aquí, y José ofreció una persona para eso. Para finales de octubre
  bastaban trazas; para lo que se presente al final, no.
- **La capa generativa introduce la primera dependencia externa real** —un modelo,
  con su latencia, su coste y su no determinismo—. El bloque C está estimado sin
  haber tocado nunca esa dependencia, así que es el número menos fiable de todos.
