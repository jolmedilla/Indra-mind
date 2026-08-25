## Purpose

Cómo esta línea realiza las cinco semánticas vinculantes del bus que fija ADR-008,
con una pieza en memoria que hace honesta la migración a Kafka.

## ADDED Requirements

### Requirement: Esquemas de evento versionados

El bus SHALL rechazar todo evento cuyo tipo y versión no estén registrados en el
catálogo de esquemas, y todo evento al que le falte un campo que su esquema
declare obligatorio.

#### Scenario: Un evento de clase desconocida

- **WHEN** se publica un evento de un tipo que no está en el catálogo
- **THEN** la publicación falla con un error que nombra el tipo y la versión, en
  lugar de entregarlo a los consumidores

### Requirement: Suscripciones equivalentes a grupos de consumo

El bus SHALL entregar cada evento una sola vez a cada grupo suscrito, y cada grupo
SHALL llevar su propio avance sobre el registro.

#### Scenario: El correlador consume como un solo grupo

- **WHEN** un perfil monta varios razonadores detrás del correlador
- **THEN** el bus ve **un** consumidor —el correlador— que reparte hacia dentro, y
  no un grupo por razonador

### Requirement: Particionado lógico con clave disponible al publicar

El bus SHALL repartir por la entidad del evento cuando la fuente la declara. Para
los eventos cuya entidad la resuelve la correlación aguas abajo, SHALL repartir
por una clave geográfica derivada de la posición, porque en el instante de
publicar el objeto todavía no existe.

#### Scenario: Una llamada al 112 sin entidad

- **WHEN** se publica un evento con geometría y sin entidad
- **THEN** la clave de reparto es la celda geográfica de su punto, y el bus la
  recuerda para que el reparto sea asertable desde el expediente

#### Scenario: Dos lecturas del mismo hecho a los dos lados de una frontera de celda

- **WHEN** dos eventos del mismo hecho físico caen en celdas distintas
- **THEN** el objeto sale igualmente resuelto —este bus es de una sola hebra— pero
  el objeto registra dos claves de reparto distintas, y una aserción del banco
  puede ponerlo en rojo

### Requirement: Ventanas sobre tiempo de evento

El bus SHALL responder ventanas mirando hacia atrás desde un instante declarado
por un evento, nunca desde la hora del reloj.

#### Scenario: Una ventana pedida por clave de reparto

- **WHEN** se pide la ventana de una clave de reparto
- **THEN** se devuelven los eventos de esa partición dentro del intervalo de tiempo
  de evento, y no los de un objeto, que es cosa del correlador

### Requirement: Retención con replay

El bus SHALL retener el registro completo de eventos publicados y SHALL poder
reentregarlo desde el principio, porque el replay es el mecanismo con el que se
ejecuta el banco.

#### Scenario: Reentrega del registro

- **WHEN** se rebobina el bus
- **THEN** los grupos reinician su avance y reciben los mismos eventos en el mismo
  orden, y el motor no distingue una entrega de una reentrega
