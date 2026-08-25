# arnes/ejecucion-del-banco Specification

## Purpose

Cómo esta línea de construcción ejecuta una instancia del banco y declara verde o
rojo. El arnés es construcción y queda fuera del canon (ADR-035, POC-007): el
runner es de cada línea, y esto describe el nuestro.

## Requirements

### Requirement: Solo puerta delantera

El arnés SHALL introducir todo estímulo por el bus y los consultables, y no SHALL
usar ningún gancho de prueba que altere el comportamiento del motor. El motor no
sabe que está siendo examinado y jamás lee la instancia.

#### Scenario: La instancia no llega al motor

- **WHEN** el arnés ejecuta una instancia del banco
- **THEN** el motor recibe únicamente eventos publicados en el bus y respuestas de
  consultables, y ninguna referencia al fichero de la instancia

### Requirement: El arnés es dueño del reloj de tiempo de evento

El arnés SHALL tomar todos los instantes de la cinta de la instancia o del
segmento, y el motor no SHALL consultar la hora del sistema. Sin esto no hay
replay, y sin replay no se puede verificar INV-05.

#### Scenario: Dos pasadas de la misma cinta

- **WHEN** la misma cinta se reproduce dos veces con las mismas versiones fijadas
- **THEN** la huella de objetos y detecciones es idéntica entre las dos pasadas

### Requirement: El expediente es la única superficie de aserción

El arnés SHALL evaluar sus aserciones exclusivamente sobre lo que el expediente
expone, y no SHALL inspeccionar el estado interno de ningún componente del motor.

#### Scenario: Una aserción sobre la ley del objeto único

- **WHEN** una instancia exige que siete eventos produzcan un solo hecho del mundo
- **THEN** la comprobación lee la lista de objetos del expediente, no la estructura
  interna del resolutor

### Requirement: Aborto por versión fijada no coincidente

El arnés SHALL abortar la ejecución cuando una versión que la instancia fija no
coincida con el artefacto montado, en lugar de ejecutar con otra versión.

#### Scenario: El pack no es el que la instancia fija

- **WHEN** la instancia fija `aglomeraciones-valencia@0.2.0` y el fichero del pack
  declara otra versión
- **THEN** la ejecución termina con un error que nombra las dos versiones, y no se
  publica ningún evento

### Requirement: Ejecutar no es interpretar

El arnés SHALL declarar verde o rojo y no SHALL opinar sobre si ese resultado es
el deseado. Quién interpreta un rojo es la suite, no el instrumento.

#### Scenario: El rojo buscado de una ablación

- **WHEN** el perfil sin razonador de dominio falla las aserciones de la instancia
- **THEN** el arnés declara ROJO y termina con código de salida 1, sin calificar
  ese rojo de esperado ni de indeseado

### Requirement: Ejecución desde un segmento consagrado del canon

El arnés SHALL poder tomar la cinta de un segmento del canon en lugar de una cinta
escrita dentro de la instancia, resolviendo el canon por la opción de línea de
órdenes, por variable de entorno, o por el submódulo del repositorio. Los
segmentos no SHALL copiarse a este repositorio.

#### Scenario: La noche de la nave

- **WHEN** la instancia fija el segmento `VLC-nave-pinturas-01` y no trae cinta
- **THEN** el arnés lee la cinta y los datos de mundo del canon, traduce cada
  evento del formato del segmento al del motor, y los publica en orden de tiempo
  de evento

#### Scenario: El canon no está disponible

- **WHEN** el submódulo del canon está sin inicializar y no se indica otra ruta
- **THEN** el arnés termina con un mensaje que dice dónde buscaba y cómo
  inicializarlo, en lugar de fallar de forma opaca

### Requirement: Cobertura parcial declarada y visible

Una instancia que cubra solo parte de su contrato canónico SHALL declararlo, y el
arnés SHALL imprimir esa declaración en cada ejecución.

#### Scenario: Una transcripción incompleta en verde

- **WHEN** una instancia declara que cubre solo la aserción (a) de su contrato
- **THEN** el arnés imprime el aviso de cobertura parcial antes de las aserciones,
  de modo que su verde no pueda confundirse con la instancia entera

### Requirement: Traza legible bajo demanda

El arnés SHALL poder imprimir, antes del veredicto, el paso a paso de lo que hizo
el motor: cada lectura con su distancia a lo normal, el nacimiento de cada objeto,
cada detección con sus hipótesis en competencia y el motivo de las descartadas, y
cada interrupción con su destinatario. La traza SHALL leerse del expediente y no
SHALL alterar el comportamiento del motor.

#### Scenario: Un paso que el arnés no reconoce

- **WHEN** el expediente contiene un paso de traza de una clase que el arnés no
  sabe formatear
- **THEN** lo imprime igualmente con sus campos en crudo, en lugar de omitirlo
