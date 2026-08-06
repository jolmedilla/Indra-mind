# Índice del entregable para Paradigma

> **Propuesta · 6-ago-2026** · Desarrolla el punto 3.a de
> [`veredicto-sobre-el-canon.md`](veredicto-sobre-el-canon.md): derivar del canon un documento
> corto y verificable, en vez de entregar el canon.
>
> Esto es **solo el índice**. Se lleva a la reunión para que se vea el tamaño y se decida; el
> documento en sí se construye después, y en una semana está.

## La idea en dos frases

Casi todo el contenido está **copiado**, no escrito: son las secciones normativas del maestro de
requisitos, tal cual. Lo que hay que redactar de nuevo son dos capítulos de encuadre, y ocupan tres
páginas entre los dos.

Y tiene una propiedad deliberada: **no contiene ni un solo cuerpo de ADR.** Todo lo que hay dentro
es un requisito, una garantía, un anti-requisito o una prueba. Nada que se pueda leer como «nos han
diseñado el sistema».

## El índice

| § | Contenido | Origen | Págs. |
|---|---|---|---|
| **0** | **Cómo leer este documento.** La frontera de dos ámbitos: qué os obliga (el motor cognitivo), qué es vuestro (la construcción: tecnologías, estructura interna, topología) y quién juzga (el banco). Y la regla: **no hay inviabilidad sin identificador** | **A redactar** (ADR-035) | 1½ |
| **1** | **Qué es el motor cognitivo.** La escalera de objetos —evento → detección → incidente → operación → sala—, el espejo máquina/persona, y la separación determinista/generativa | §2 del maestro, aligerado | 2 |
| **2** | **Lo que el motor debe garantizar: los invariantes.** INV-01..19, con su columna de verificación | §4 **verbatim** | 3 |
| **3** | **Lo que el motor debe poder hacer: las capacidades.** C-01..21, en sus cuatro grupos | §3 **verbatim** | 3 |
| **4** | **Lo que el motor NO es: los anti-requisitos.** AR-01..07 | §7 **verbatim** | 1 |
| **5** | **Los presupuestos.** PRE-01..09, cada uno con su estatus: compromiso del motor o parámetro de despliegue | §6 **verbatim** | 1 |
| **6** | **Qué se cambia sin tocar código.** CFG-01..09: la bipartición doctrina / configuración semántica | §5 **verbatim** | 1½ |
| **7** | **El contrato de aceptación: el banco.** Las 61 filas en sus seis familias, con su métrica | §8 **verbatim** | 12 |
| **8** | **Cómo se demuestra y cómo se discute.** El contrato del arnés (solo puerta delantera; el arnés es dueño del reloj; el expediente es la única superficie de aserción), los perfiles de ablación, y el procedimiento de alegación: contra filas, invariantes o presupuestos concretos, resuelto con evidencia sobre el banco | **A redactar** (`banco/README.md` + ADR-035) | 1½ |
| **9** | **Glosario mínimo.** Solo los términos necesarios para leer lo anterior | §2, subconjunto | 2 |
| **A** | **Anexo · Dónde está el porqué.** Los 50 ADR, solo número y título, en una tabla. Para que puedan pedir el que les interese | `decisiones.md`, índice | 1½ |

**Total: unas 30 páginas**, de las cuales 12 son el banco — que es el punto.

## Lo que queda fuera, y por qué

| Fuera | Motivo |
|---|---|
| Los cuerpos de los 50 ADR | Son el *porqué*. Se ofrecen a demanda por el anexo: «¿por qué esto es así? pide el ADR-nn» |
| El corpus de contraste (36 fichas) y los planes territoriales (20) | Es material de apoyo: se cita, no se obedece. Munición de reserva si alguien discute una decisión concreta |
| La nota del CECOES, el informe FAST | Ídem |
| El método de consultoría | Es cómo se implanta en cliente, no qué debe hacer el producto |
| La hoja de ruta y los hitos | Es plan interno. Que Paradigma vea las fechas de la PoC no ayuda |
| Los POC-001..005 | Son decisiones de la PoC, no norma. ADR-035 (5): la PoC transfiere demostración, **no jurisdicción** |

## Una decisión que hay que tomar: los visuales

Tres de los 21 harían mucho por la legibilidad y no cuestan nada porque ya existen:
**v01** la escalera de objetos, **v03** el espejo máquina/persona, **v12** la frontera de lo
generativo.

A favor: atacan directamente el problema de que el canon no se lea. En contra: son de la edición
interna y habría que revisar que no lleven nada que no deba salir. Yo los metería, con una pasada
de revisión previa.

## El trabajo real, honestamente

- **Copiar y maquetar:** §2 a §7 y §9 salen del maestro. Es ensamblaje.
- **Redactar:** los capítulos 0 y 8, unas tres páginas. Son los que dan el marco, y son los
  importantes — el 0 porque es el que evita la pelea de jurisdicción, y el 8 porque es el que
  convierte «no se puede» en una alegación que hay que probar.
- **Editar:** §1 y §9 salen del glosario normativo, que es la parte más densa del maestro. Hay que
  aligerar la prosa sin tocar el significado, y eso sí requiere criterio.
- **Generar el PDF:** con `tools/publicar.sh` y weasyprint, que es la cadena que ya existe
  (ADR-014: los formatos de frontera se generan bajo demanda desde el maestro Markdown).

## Cómo entraría en el repo

Como documento nuevo en `docs/`, y por tanto **por la bandeja de propuestas**: una propuesta que
declare el fichero destino, con el veredicto de José por ser materia funcional. El contenido es
derivación de material que él ya ratificó, así que la propuesta es de forma y de perímetro —qué
entra y qué no—, no de fondo.
