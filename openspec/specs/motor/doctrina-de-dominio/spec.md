# motor/doctrina-de-dominio Specification

## Purpose

Qué parte del razonamiento vive en el pack y no en el código. Realiza la
bipartición de ADR-022: la doctrina de razonamiento es configuración versionada
con dueño y ciclo propios, y el motor aporta la capacidad, no el contenido.

## Requirements

### Requirement: Las hipótesis y sus discriminantes los declara el pack

El pack SHALL declarar qué explicaciones compiten, con su prior, y por cada una
sus discriminantes: el consultable que los responde, el modo, la dirección para el
caso verdadero y para el falso, el peso, y la plantilla del motivo de descarte. El
código no SHALL contener nombres de hipótesis, grados ni motivos.

#### Scenario: Una explicación nueva en el dominio

- **WHEN** se añade una tercera explicación a la doctrina de aglomeraciones
- **THEN** se edita únicamente el pack, y ningún fichero de código

### Requirement: Los consultables son capacidad del motor, no doctrina

El motor SHALL saber interrogar un conjunto conocido de consultables, y SHALL
fallar de forma explícita cuando la doctrina cite uno que no sabe interrogar.

#### Scenario: Un consultable que el motor no conoce

- **WHEN** el pack cita un consultable no implementado
- **THEN** el razonador falla diciendo que añadir un consultable es trabajo de
  construcción y no de pack

### Requirement: Un consultable se pregunta una vez por caso

Cuando varias hipótesis se apoyen en el mismo discriminante, el razonador SHALL
consultarlo una sola vez y usar la misma respuesta para todas.

#### Scenario: Dos hipótesis sobre la misma agenda

- **WHEN** dos explicaciones se discriminan por el mismo consultable
- **THEN** las dos ven la misma respuesta, de modo que sus motivos no puedan
  contradecirse

### Requirement: Nunca una explicación única habiendo alternativas

Toda conclusión no trivial SHALL presentar las alternativas consideradas, y toda
descartada SHALL conservar escrito su motivo con la consulta que lo sostiene
(INV-03). Que esto se cumpla SHALL depender de que el pack declare más de una
hipótesis con sus motivos, y no de una comprobación en el código.

#### Scenario: Convergencia sin evento autorizado

- **WHEN** no hay acto autorizado que explique la convergencia
- **THEN** gana la explicación de aglomeración no prevista y la alternativa queda
  tachada citando la consulta a la agenda

#### Scenario: Un perfil sin doctrina que preguntar

- **WHEN** el perfil de umbrales simples forma su única explicación declarada
- **THEN** no hay alternativa ni motivo, y eso es visible en la salida en lugar de
  estar escondido en el código

### Requirement: El motivo de descarte lo escribe la doctrina y lo completa el mundo

La plantilla del motivo SHALL vivir en el pack, y los datos que la completan SHALL
salir de la respuesta del consultable.

#### Scenario: Un acto autorizado en la agenda

- **WHEN** la agenda declara un acto que cubre la zona y el instante
- **THEN** el motivo escrito cita el nombre del acto y su ventana, tomados de la
  respuesta y no inventados
