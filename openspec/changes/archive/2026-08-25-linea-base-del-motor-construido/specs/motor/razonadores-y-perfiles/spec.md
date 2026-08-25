## Purpose

Qué se enchufa detrás del correlador y cómo se declara. Es lo que hace
**estructural** la ablación: un perfil no es un parámetro, es una composición de
piezas.

## ADDED Requirements

### Requirement: Un perfil es una lista de razonadores, no un parámetro

El pack SHALL declarar, por cada perfil, la lista de razonadores que lo componen.
Quitar una pieza SHALL hacerse no montándola, y no reconfigurándola.

#### Scenario: La ablación del razonador de dominio

- **WHEN** se ejecuta la misma cinta con el perfil de umbrales simples y con el
  perfil completo
- **THEN** la diferencia entre ambos es qué clase está enchufada detrás del
  correlador, y no el valor de ningún umbral compartido

#### Scenario: Un perfil con varios razonadores

- **WHEN** un perfil declara más de un razonador
- **THEN** el correlador los monta todos y les entrega cada observación en el orden
  en que el perfil los declara

### Requirement: Los razonadores montables viven en una tabla

El montaje SHALL resolver cada nombre de razonador contra un catálogo de fábricas
con firma común, y no mediante una cadena de condiciones. Un razonador que el pack
pida y el motor no conozca SHALL producir un error que nombre los que sí conoce.

#### Scenario: Un razonador desconocido

- **WHEN** un perfil declara un razonador que este motor no sabe montar
- **THEN** el montaje falla nombrando el razonador pedido y la lista de los
  disponibles

### Requirement: El correlador es un solo consumidor del bus

Sea cual sea el número de razonadores montados, el correlador SHALL suscribirse al
bus una sola vez, con el nombre del perfil, y repartir hacia dentro.

#### Scenario: Dos razonadores en el mismo perfil

- **WHEN** un perfil monta dos razonadores
- **THEN** los dos ven el mismo evento en el mismo momento, porque el avance sobre
  el registro es uno solo

### Requirement: El motor puede montarse sin doctrina

El motor SHALL poder montarse sin pack. Entonces no hay razonadores, el correlador
escucha todas las clases que la configuración semántica declara, y se resuelven
objetos sin concluir nada.

#### Scenario: Asertar la ley del objeto único sin packs

- **WHEN** una instancia no fija ningún pack
- **THEN** el motor resuelve objetos, no forma detecciones, y el banco puede
  asertar sobre los objetos

### Requirement: Una detección por hecho físico

Todo razonador SHALL formar como mucho una detección por objeto, adjuntar la
evidencia de la ventana que sostiene la conclusión, y pasar por la política de
interrupción antes de robar la atención de nadie.

#### Scenario: Tres fuentes sobre la misma zona

- **WHEN** tres fuentes independientes se desvían sobre el mismo objeto
- **THEN** nace una sola detección, y las lecturas posteriores no crean otra
