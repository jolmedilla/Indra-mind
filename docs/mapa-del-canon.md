# El mapa del canon

> **Para entender `indramind-poc` antes de la reunión con José** · 18-ago-2026
> · Leído sobre `origin/main` en `72b550a`, con el índice en v3.36 y el maestro
> de requisitos en v0.5.3.

---

## 1 · Qué documentos hay, y cuál manda

El índice del canon (`docs/indice-del-canon.md`) es **la única lista válida** de qué existe y en qué versión va. No hay que fiarse de la memoria ni del listado de ficheros: si un documento no aparece en su tabla de artefactos canónicos, no genera obligación de nada.

Los seis artefactos canónicos son:

| Documento | Es la fuente de verdad de… | Estado |
|---|---|---|
| `requisitos-motor-cognitivo.md` | **El maestro.** Lo que el motor debe hacer y garantizar | v0.5.3 |
| `decisiones.md` | El registro de ADR: toda decisión firme de producto | ADR-001..054 |
| `decisiones-poc.md` | Las decisiones propias de la PoC | POC-001..005 |
| `indice-del-canon.md` | El inventario, las versiones y la matriz de propagación | vivo, v3.36 |
| `consultoria-cognitiva-metodo-implantacion.md` | El método de implantación | v0.2 |
| `hoja-de-ruta.md` | El plan: fases, puertas, hitos, deuda | vivo |

Todo lo demás —las notas de opinión, las actas, las fichas de corpus— vive en `docs/apoyo/` y **no obliga a nada**. Es material de apoyo, y el propio índice lo dice.

---

## 2 · El maestro por dentro: seis familias de identificadores

Aquí está el 90 % de lo que hay que entender. El documento de requisitos tiene once secciones, de las cuales **las normativas son la 1 a la 9**; el resumen ejecutivo (§0) y los pendientes (§10) son informativos.

Cada familia de identificadores vive en su sección y obliga de una manera distinta:

| Familia | Sección | Cuántos | Qué es |
|---|---|---|---|
| **C-xx** | §3 Capacidades | 21 | **Lo que el motor sabe hacer.** Comprender el mundo, gestionar el incidente, gobernar la sala, aprender de la operación |
| **INV-xx** | §4 Invariantes | 19 | **Lo que nunca puede dejar de cumplirse**, pase lo que pase |
| **CFG-xx** | §5 Configurabilidad | 9 | **Qué se puede cambiar sin tocar código**, y con qué ciclo de aprobación |
| **PRE-xx** | §6 Presupuestos | 9 | **Los límites de desempeño y coste** que hay que respetar |
| **AR-xx** | §7 Anti-requisitos | 7 | **Lo que el sistema no debe hacer**, explícitamente |
| **REQ-xx** | §8 Banco | 62 | **El contrato de aceptación**: los escenarios que hay que pasar |

Y dos secciones más que no son familias: **§2 es el glosario normativo**, con 68 entradas —ahí las palabras significan lo que dice, y no otra cosa—, y **§9 es el modelo de sala**: razonadores, cargos humanos y vistas.

La distinción que más se usa en las conversaciones es la de **capacidad frente a invariante**. Una capacidad dice «el motor sabe correlacionar eventos de fuentes independientes» (C-03); un invariante dice «rebobinar los mismos eventos con las versiones fijadas da exactamente las mismas salidas» (INV-05). Lo primero se puede hacer mejor o peor; lo segundo, o se cumple o el sistema está roto.

Esa asimetría es la que sostiene tu argumento del veredicto: **la arquitectura no está impuesta, está implicada.** Seis normas —el replay con diferencia cero (INV-05), el grado siempre determinista (INV-04), el etiquetado determinista o generativo (INV-10), lo que decide es reproducible (AR-03), el coste sublineal con exclusión de leer flujos completos con la generativa (PRE-04) y las invocaciones generativas acotadas y presupuestadas (PRE-05)— fuerzan una arquitectura sin describirla. Ninguna dice cómo organizar el código; todas dicen qué tiene que pasar al ponerlo a funcionar.

---

## 3 · Banco, arnés y packs: tres cosas que se confunden

Esta es la parte que más conviene tener clara mañana, porque son tres artefactos distintos con tres dueños distintos.

### El banco tiene dos niveles, y solo uno es normativo

**La fila** (`REQ-nn`) vive en §8 del maestro, es **prosa genérica** y es normativa. Dice, por ejemplo, que ante eventos convergentes de fuentes independientes en una zona sin evento autorizado en la agenda, el motor debe emitir una detección con hipótesis en competencia, grados y evidencia trazada, antes de la referencia humana declarada (REQ-01).

**La instancia** (`REQ-xx-REF-nn`) vive en `/banco/instancias`, es **YAML ejecutable** y es un caso concreto de esa fila: con sus versiones clavadas, su cinta de eventos y sus aserciones legibles por máquina. Es lo que tú acabas de escribir.

Encima de ambos están las **suites**: listas versionadas de instancias agrupadas por uso —aceptación de la PoC, ablaciones—. Y una regla que conviene recordar porque afecta a una decisión que tienes pendiente: **el uso vive en la suite, no en el identificador**. Por eso el bloque `ablacion` que metiste dentro de las instancias probablemente deba mudarse.

### El arnés es código, y no es el banco

El banco son las preguntas del examen; **el arnés es el examinador**. La frase del canon es tajante: «el arnés interpreta las instancias; el motor jamás las lee».

Y le impone tres propiedades de rango de producto, que ya conoces porque el runner las cumple: solo puerta delantera, el arnés es dueño del reloj de tiempo de evento, y el expediente es la única superficie de aserción.

**Lo que importa para ti:** `banco/README.md` declara que **el esquema concreto de instancia y el validador `check_banco` son decisión de construcción de la PoC**. Es decir, son tuyos, no hace falta veredicto de José para moverlos. Lo que sí es suyo es el contenido de las filas y el alcance.

### Los packs son doctrina, no código

Viven en `/packs`, en YAML, organizados por razonador. Son **configuración versionada con ciclo de aprobación** (CFG-03/04), no lógica de programa. Lo que separa un pack de un dato de instalación es lo que acordaste con Alejandro: la regla de umbral y el tipo de evento son doctrina y viajan en el pack; la entidad concreta y su línea base son de cada cliente.

---

## 4 · Cómo se gobierna: dos planos y una bandeja

**Dos planos, y la frontera es por materia, no por fichero** (ADR-050):

- El **plano funcional** —lo que el motor debe hacer y garantizar, el banco como contrato, la doctrina, la terminología vinculante y el alcance de la PoC— es de **José**. Nada de esa materia se toca sin su veredicto expreso.
- El **plano de método y espacio documental** —estructura de carpetas, reglas de trabajo, convenciones de nombres, `/tools` y el mecanismo de propuestas— es de **Alejandro** (ADR-051 lo confirmó).

Ante la duda, o si algo toca los dos planos, **la materia es funcional**.

**La bandeja** (`/propuestas`) está fuera de `/docs` a propósito, para que ninguna sesión reciba como canon algo sin ratificar (ADR-049). El estado **es la carpeta**: una propuesta cambia de estado moviéndose entre `1-pendientes`, `2-aceptadas`, `3-aplicadas` y `4-descartadas`, y ese movimiento es la huella del veredicto. Todo veredicto se firma con nombre y fecha dentro del propio fichero.

**La matriz de propagación** del índice dice qué hay que actualizar cuando un documento sube de versión. Y `node tools/check_canon.js` comprueba la coherencia: que no falten identificadores, que no haya huecos, que el índice cuadre.

---

## 5 · Dónde está el canon hoy

| | |
|---|---|
| Maestro de requisitos | **v0.5.3**, ratificada el 10-ago (PROP-009), aplicada con ADR-054 |
| ADR | **001..054** |
| Decisiones de PoC | **POC-001..005** (el POC-006 que anuncia la hoja de ruta aún no existe) |
| Banco normativo | **REQ-01..62** |
| Glosario | **68 entradas** |
| Índice | **v3.36** |
| Bandeja | vacía de pendientes; PROP-011 de José **aceptada el 17-ago y pendiente de aplicar** |
| `banco/instancias` y `banco/suites` | **vacías en el canon** — las tuyas viven en el demostrador |

Ojo con lo último de la bandeja: José aceptó ayer una PROP-011 suya —un retoque de la frase de realizabilidad de §1— y **la sesión de aplicación está pendiente**. Es el mismo número que habíamos reservado para la nuestra, que murió en la rama sin llegar a la bandeja. No hay colisión, pero conviene saberlo por si sale.

---

## 6 · Lo que está abierto, y que es material de reunión

§10 del maestro lista quince pendientes. Nada de ahí es norma, y ninguno bloquea la PoC. Los que te tocan de cerca:

**Modelo de retención y purga.** Es la única consulta abierta desde julio y la más expuesta: resolver la tensión entre la minimización con retención definida (INV-07), el replay que exige conservar eventos (PRE-06), la auditoría de accesos (INV-06) y el valor probatorio del expediente (REQ-31). **Aquí tienes hueco declarado**: el ADR-052 —el tuyo— dice literalmente que esta decisión deja el modelo de retención «mejor planteada» y que «su propuesta hermana debe venir después». Es una invitación escrita.

**Resolución aproximada.** También del ADR-052: afirmar que dos observaciones sin clave fuerte común son el mismo actor quedó sin régimen propio y «deberá venir como propuesta con su propio encaje en INV-07». Segundo hueco con tu nombre.

**Ley de despertar vertical.** El ADR-054 acotó la ley de despertar de los patrones al peldaño de la detección y dejó expresamente fuera la de los razonadores de incidente y de sala. **Eso es tu hito 2.** Cuando construyas el razonador de incidente vas a tropezar con esta ausencia.

**Promoción a operación y absorción como hilo.** Las dos únicas relaciones de §9 sin fila propia en el banco.

---

## 7 · El hallazgo: la condición que José puso está a punto de cumplirse

Esto es lo que yo llevaría preparado para mañana.

En §10 hay una fila llamada «Bloques de ratificación de la revisión v0.5 (aparcados)». Es una cola larga: candidatos a fila de banco y traslados salidos del corpus de contraste, de los planes territoriales, de la visita al CECOES 112 de Canarias, del acta v0.4, de la nota FAST y del guión de la demo. Docenas de decisiones de detalle esperando.

Y el motivo del aplazamiento está declarado con nombre y fecha:

> **Decisión de José (3-ago-2026, acta v0.5, asiento V5-08):** son veredictos de detalle que se toman mejor **tras una primera iteración de la PoC, con una fila recorrida de punta a punta**; encolar no es decidir — nada queda decidido ni a favor ni en contra.

**Tú acabas de recorrer dos filas de punta a punta.** REQ-01 y REQ-02, con instancia ejecutable, cinta de eventos, aserciones verificadas y ablación en dos perfiles. La condición que José puso para desatascar esa cola es exactamente lo que ya existe.

No hace falta que lo plantees como una reclamación. Basta con decírselo: *«pusiste esos bloques a esperar a que hubiera una fila recorrida de punta a punta. Ya hay dos. ¿Cuándo los miramos?»* Le estás devolviendo su propia condición cumplida, y de paso le enseñas que lo construido sirve para algo más que para la demo.

---

## 8 · Tres cosas que llevaría claras a la reunión

**Que el esquema de instancia es tuyo.** `banco/README.md` lo declara decisión de construcción, así que puedes moverlo sin pedir permiso. Lo que sí conviene es enseñárselo, porque será la forma que hereden todas las filas que él escriba después.

**Que hay dos huecos con tu nombre en §10**, retención y purga y resolución aproximada, ambos abiertos por tu propio ADR-052. Si buscas qué proponer después del hito 1, están ahí escritos.

**Y que la cola aparcada tiene ya su condición cumplida**, que es el punto 7.
