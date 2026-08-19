---
name: indra-mind-estado-y-siguientes-pasos
description: "Punto de continuación del trabajo de IndraMind: estado al 19-ago-2026, con la construcción en solitario, los tres repositorios montados y el hilo del product owner"
metadata: 
  node_type: memory
  type: project
  originSessionId: e2e894d9-1423-40b3-827d-6e63a0238810
  modified: 2026-08-19T08:10:15.853Z
---

Estado al **19-ago-2026**. Contexto general en [indra-mind-engagement](indra-mind-engagement.md); el canon en [indramind-poc-repo-canon](indramind-poc-repo-canon.md); cómo quiere José que se trabaje en [instrucciones-jose-proyecto-indramind](instrucciones-jose-proyecto-indramind.md); lo administrativo en [alta-autonomo-y-contratacion-malt](alta-autonomo-y-contratacion-malt.md).

## El reparto vigente: Juanjo construye solo

Alejandro Asensio lo comunicó el **17-ago-2026**, tras hablarlo con José: se mantiene el enfoque, pero **Juanjo construye solo todo el producto de la PoC — motor y packs**, en un repositorio nuevo y aislado. Las propuestas al canon siguen yendo contra el repositorio funcional. Alejandro queda en **seguimiento y validación de la solución**, con reunión semanal. Sus palabras: «mi figura es más de seguimiento y validación que de construcción».

Antes de eso hubo un tropiezo que conviene recordar: el 12-ago se acordó un reparto en la reunión de toma de contacto, Juanjo lo dio por bueno y empujó el esqueleto al repositorio de José, y el 14-ago Alejandro aclaró que había pedido **pausar** hasta hablar con José. Se revirtió `main`, el trabajo pasó a una rama y la PR quedó cerrada. Lección: cuando alguien dice «lo hablo con X», eso es una pausa, no un visto bueno.

## Los tres repositorios

- **`indra-mind`** — los cuadernos privados de asesoría. Contiene `docs/memoria/`, copia versionada de esta memoria, y dos submódulos.
- **`indramind-poc`** (submódulo) — el canon del cliente. Fuente de verdad. No se escribe salvo por la bandeja.
- **`indramind-demostrador`** (submódulo) — la construcción, `jolmedilla/indramind-demostrador`, privado, con Alejandro y José como colaboradores. Ahí viven `/src`, `/packs` y `/banco/instancias`.

Las URL de los submódulos divergen a propósito: HTTPS en `.gitmodules` (lo que viaja y lo único que funciona en la web), SSH en la configuración local. **No es una incoherencia que arreglar**, y `git submodule sync` la deshace en silencio.

## El compromiso, con su letra exacta

**Firme:** H1 en verde con sus ablaciones, y **H2 hasta donde llegue**, para **mediados de septiembre**. Es lo que se puso por escrito a Alejandro y José.

- **H1** = el razonador de dominio en verde: detección anticipada por convergencia (REQ-01) y el espejo de la mascletà (REQ-02), cada uno con su ablación en dos perfiles.
- **H2** = el razonador de incidente: ante una detección, proponer misiones dentro del presupuesto de latencia (PRE-02, ~60 s).

**No firme:** en la reunión del 19-ago José preguntó cuándo se visualizaría algo tipo H4 para enseñar al CEO, **enmarcándolo expresamente como horquilla** —«sin compromiso, es por saber, por hacerme una idea mental»; «no necesito que sea octubre escrito en piedra, pero que no sea enero»—. Juanjo contestó «creo que a finales de octubre podría cerrarlo». **Eso es un rango, no un compromiso**, y queda pendiente rehacer la estimación con fundamento la semana del 24 o la siguiente, y actualizarle.

Ojo: el veredicto dejaba H3 y H4 **fuera** de forma explícita. Si la estimación nueva los mete dentro, es una ampliación de alcance y conviene nombrarla como tal.

## Lo que José quiere de esto (reunión del 19-ago)

**Quiere manejar él los escenarios.** Sus palabras: «tenemos que partir de la misma definición de escenario; **el fichero lo tenemos que manejar los dos**, el pack de razonamiento y la cinta. Y yo se lo pasaré al Claude y tú al producto». Hace sus **pruebas en seco** con Claude público y así controla el relato — qué casos de uso y por qué.

**Consecuencia de diseño:** el YAML de las instancias no es solo entrada del runner, es un artefacto que José lee y edita a mano. Si se optimiza para la máquina y se vuelve ilegible, se le rompe su forma de trabajar. Refuerza la prueba de experto (CFG-05).

**Prefiere cimientos a velocidad.** «Prefiero que los cimientos estén bien… que no esté demasiado trampeado, metido todo en un solo bloque». Le preocupa menos el 15 de septiembre que presentar algo que sea de verdad una base.

## El hilo del product owner

Lo abrió José en esa misma reunión, y es la parte con más consecuencias:

- Habló con **Marcelo** la semana del 11-ago y le presentó la visión.
- Hay una **posición de product owner quedando vacante**. Si Paradigma no la pone —y no parece— la pondrían ellos. «Tú serías ahí un candidato claro, y serías un candidato claro cuanto más cerca estés ahora de algo parecido a lo que queremos».
- Calendario que dibuja: decisiones **en torno al 15 de septiembre**; presentación a **finales de octubre**; un par de semanas de debate; y «eso desencadena el que te hagan una oferta para entrar».

**Ofreció una persona para la parte visual.** Aparcado de momento —primero trazas—, pero para la versión de finales de octubre hará falta algo presentable: el CEO tiene base técnica pero un volcado de trazas no le vale.

## Estado del canon (`origin/main` = `72b550a`)

Requisitos **v0.5.3** · **ADR-001..054** · POC-001..005 · banco **REQ-01..62** · glosario **68** · índice **v3.36**.

- **PROP-011 de José** (retoque de la frase de realizabilidad de §1) aceptada el 17-ago, **pendiente de su sesión de aplicación**. Ojo: usó el número 011, el mismo que habíamos reservado para una propuesta nuestra que murió en una rama sin llegar a la bandeja.
- **PROP-012, nuestra**, en `1-pendientes` desde el 19-ago: los dos capítulos de encuadre del entregable. José dijo en la reunión que la miraría.
- `banco/instancias` y `banco/suites` **siguen vacías en el canon**; las nuestras viven en el demostrador.

## Dónde está el código

**H1 funciona.** Las cuatro ejecuciones dan la tabla de ablación completa: con razonador, detección 35 min antes de la referencia humana y cero interrupciones el día de la mascletà; sin él, 5 min y falsa alarma. Doble pasada con diferencia cero en los cuatro casos (INV-05). El recorrido está explicado en `docs/como-funciona-el-demostrador.md`.

**Trabajo pendiente, en orden** (detalle en §7 de ese documento):

1. **Partir `dominio.py`** en correlador y razonador. Hoy una sola clase hace la evaluación de línea base, la correlación (C-03, que es el CEP), la formación de hipótesis (C-04) y la política de interrupción (C-09). Y la ablación es hoy un umbral distinto en el mismo código, lo que permite decir «habéis subido el listón»; si P0 es la **ausencia estructural** del razonador, la ablación es literalmente quitar una pieza. Juanjo se lo dijo a José: inyección de dependencia en vez del `if`.
2. **Un adaptador de tres verbos** —`sembrar`, `publicar`, `expediente`— para que el runner examine implementaciones ajenas. El acoplamiento no es de lenguaje sino **de forma**: hoy se da por supuesto que la puerta de entrada es un objeto con `publicar()`. Juanjo lo situó en la semana del 26-28 de agosto, por HTTP o bus estándar.
3. Una opción `--traza` en el runner. Barata y muy útil.

**PR #1 del demostrador** abierta, sin revisar, con revisión pedida a Alejandro. Documenta la regla de trabajar con pull requests. José aún no ha aceptado la invitación de GitHub.

## La regla de precedencia (sigue vigente)

**El canon de José es base de trabajo y vocabulario común, NO una autoridad ante la que nuestro análisis se retire.** De sus palabras del 29 y 31-jul: «si es que las toma todas, yo le hago preguntas y va tomando las decisiones, **por lo menos yo le aporto poco**»; «si no tiene que ser eso, **me lo diga alguien que no tenga un interés en torpedear el tema**».

**Trampa a evitar:** ADR-035 (7) impone a `motor-cognitivo-explicado.md` el estatuto «si discrepa del canon, manda el canon». Es para un fichero *de dentro* del canon. No trasplantarlo a nuestros documentos.

## Lección de método que costó trece días

El índice del entregable se redactó el **6-ago** y se quedó en los cuadernos «hasta que se decidiera». Nunca entró en la bandeja. El **17-ago** José generó por su cuenta una edición para el equipo de construcción. Trabajo duplicado por dos caminos.

**Una propuesta que no entra en la bandeja no existe.** Se propone el mismo día que se piensa: una propuesta es inerte, no obliga a nada, y desde PROP-007 toda sesión declara la bandeja al arrancar.

## Conceptos ya establecidos, para no re-derivarlos

- **El «motor cognitivo» es el producto entero**, no la parte determinista ni un componente (ADR-035).
- **Dos ejes ortogonales:** el normativo (motor = obliga · construcción = libre) y el arquitectónico (determinista · generativo). El segundo vive **dentro** del primero.
- **La arquitectura no está impuesta: está implicada.** Seis normas expresadas como propiedades observables la fuerzan sin describirla — INV-05 (replay, diff = 0), INV-04 (grado siempre determinista), INV-10 (etiquetado), AR-03, PRE-04 (coste sublineal) y PRE-05.
- **«No hay inviabilidad sin identificador»** (ADR-035, 4) nada tiene que ver con el prefijo INV: significa que no se puede alegar que algo no se puede hacer sin citar una fila, un invariante o un presupuesto concreto, y se resuelve con evidencia sobre el banco.
- **Tres niveles:** la **norma** (INV/C/PRE/AR) → la **fila del banco** (REQ-nn, prosa genérica) → la **instancia** (`REQ-xx-REF-nn`, YAML ejecutable). Encima, las **suites**: listas versionadas por uso. **El uso vive en la suite, no en el identificador** — por eso el bloque `ablacion` que hoy está dentro de las instancias probablemente deba mudarse.
- **Banco vs arnés:** el banco son las preguntas del examen; el arnés es el examinador. «El arnés interpreta las instancias; el motor jamás las lee».
- **Las tres propiedades del arnés:** solo puerta delantera, el arnés es dueño del reloj de tiempo de evento, y el expediente es la única superficie de aserción. **No están en el maestro** — viven en `banco/README.md`, comprobado por búsqueda literal.

## Pendiente

- **Rehacer la estimación** de hitos con fundamento y actualizar a José (semana del 24 o la siguiente).
- **Partir `dominio.py`**, que es lo siguiente en el código.
- **«Ablación» no convence a ninguno de los dos.** José, en la reunión: «si se te ocurren palabras mejores, eso pasa por el repo funcional y lo vamos cambiando». Invitación abierta a proponer terminología por la bandeja.
- **Dos huecos con nuestro nombre en §10 del maestro**, ambos abiertos por el propio ADR-052: el modelo de **retención y purga** («su propuesta hermana debe venir después») y la **resolución aproximada** («deberá venir como propuesta con su propio encaje en INV-07»).
- **La cola de bloques de ratificación aparcados** tiene cumplida su condición: José la aparcó el 3-ago hasta que hubiera «una fila recorrida de punta a punta», y hay dos.
- Confirmar con Héctor Cárdenas si las facturas autofacturadas llevan retención — ver [alta-autonomo-y-contratacion-malt](alta-autonomo-y-contratacion-malt.md).
