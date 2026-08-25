# motor/resolucion-de-objeto Specification

## Purpose

De qué hecho del mundo habla cada evento. Es la realización de la capacidad C-03
del canon —correlacionar por espacio, tiempo y entidades— y lo que sostiene la ley
del objeto único (REQ-07, INV-11) para las fuentes que no declaran de qué hablan.

## Requirements

### Requirement: La entidad se resuelve, y hay dos maneras

Cada clase de evento SHALL declarar en su esquema cómo se resuelve su entidad:
**declarada**, cuando la fuente la trae puesta, o **geoespacial**, cuando la fuente
informa de un punto del mundo y no de un objeto conocido. La elección es
configuración semántica y no SHALL vivir en el pack.

#### Scenario: Una fuente anclada a un sitio

- **WHEN** llega una lectura de ocupación que declara `zona:plaza-ayuntamiento`
- **THEN** el objeto resuelto tiene esa cadena como identificador, de modo que todo
  lo que hay por encima se comporta igual que antes de existir la resolución

#### Scenario: Una fuente que no sabe de qué habla

- **WHEN** llega una llamada al 112 con un punto y su incertidumbre, sin entidad
- **THEN** el objeto se deduce por fusión, y recibe un identificador generado

### Requirement: La fusión la gobiernan las incertidumbres declaradas, no un radio inventado

Un evento SHALL unirse al objeto vivo más cercano cuya distancia al punto del
evento no supere la suma del radio del objeto, la incertidumbre que el propio
evento declara y la tolerancia que su esquema fija; y solo si no ha pasado más
tiempo del que declara la ventana de fusión. Si ninguno cumple, SHALL nacer un
objeto nuevo.

#### Scenario: Siete lecturas del mismo fuego

- **WHEN** se reproducen seis llamadas al 112 y una analítica de vídeo sobre la
  misma nave, con incertidumbres de entre 5 y 55 metros
- **THEN** nace exactamente un objeto, y los siete eventos se incorporan a él

#### Scenario: Dos hechos distintos y lejanos

- **WHEN** dos llamadas informan de puntos separados por 800 metros
- **THEN** nacen dos objetos, porque sus círculos de error no se tocan

#### Scenario: El mismo punto fuera de la ventana

- **WHEN** dos llamadas informan del mismo punto con media hora de diferencia y la
  ventana de fusión es de diez minutos
- **THEN** nacen dos objetos

### Requirement: El reparto en objetos no depende del orden de llegada

Cuando varios objetos cumplan las condiciones de fusión, SHALL ganar el más
cercano, y los empates exactos SHALL romperse por identificador.

#### Scenario: La misma cinta en otro orden

- **WHEN** los mismos eventos se resuelven en un orden distinto
- **THEN** el agrupamiento de eventos en objetos es el mismo, aunque los
  identificadores y el orden de la línea temporal reflejen el orden de llegada

### Requirement: El objeto es observable, con su línea temporal

El objeto SHALL exponerse en el expediente con su identificador, su geometría, sus
instantes primero y último, la lista ordenada de los identificadores de los eventos
que lo formaron, sus fuentes independientes y las claves de reparto por las que
entraron sus lecturas.

#### Scenario: La ley del objeto único, verificada desde fuera

- **WHEN** el banco exige que siete eventos produzcan un solo hecho del mundo
- **THEN** la comprobación se hace sobre la lista de objetos del expediente y sobre
  su línea temporal, sin creerse nada

### Requirement: Un objeto no es una detección

El objeto SHALL representar el hecho del mundo antes de que ninguna doctrina opine,
y no SHALL llevar clase, hipótesis ni grado. La resolución no SHALL consultar
ningún pack ni mirar el contenido semántico de los eventos.

#### Scenario: Resolución sin doctrina montada

- **WHEN** el motor se monta sin pack alguno
- **THEN** los objetos se resuelven igualmente y no se forma ninguna detección

### Requirement: La reentrega no hace crecer un objeto dos veces

Un evento ya incorporado a un objeto no SHALL incorporarse de nuevo si el mismo
evento se reentrega.

#### Scenario: Rebobinado del bus

- **WHEN** se reentrega el registro completo
- **THEN** la línea temporal de cada objeto es idéntica a la de la primera pasada
