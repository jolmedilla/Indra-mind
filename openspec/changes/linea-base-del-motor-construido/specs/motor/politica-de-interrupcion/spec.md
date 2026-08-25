## Purpose

Detectar no es interrumpir. Realiza la capacidad C-09 del canon manteniendo
separadas dos decisiones de naturaleza distinta: qué está pasando, que lo dice un
razonador, y si eso merece robarle la atención a una persona.

## ADDED Requirements

### Requirement: La política vive aparte de los razonadores

La decisión de interrumpir SHALL tomarse en una pieza distinta de la que forma la
detección, y toda detección SHALL pasar por ella antes de que se entregue ninguna
interrupción.

#### Scenario: Una detección que no interrumpe

- **WHEN** un razonador forma una detección cuya explicación vencedora da cuenta de
  lo observado
- **THEN** la detección existe y queda consultable en el expediente, y no se
  entrega ninguna interrupción

### Requirement: Qué explicaciones no interrumpen lo declara el pack

El pack SHALL declarar las explicaciones cuya victoria no justifica interrumpir. El
código no SHALL contener esa lista.

#### Scenario: El acto autorizado de la agenda

- **WHEN** la explicación vencedora es la que el pack declara como explicativa
- **THEN** no se interrumpe, y queda anotado en la traza que la vigilancia continúa

### Requirement: La vigilancia continúa en los dos casos

Que no se interrumpa no SHALL suprimir ni reducir la vigilancia sobre el objeto. Lo
único que cambia es si suena algo.

#### Scenario: Después de no interrumpir

- **WHEN** una detección no interrumpe por estar explicada
- **THEN** las lecturas posteriores sobre el mismo objeto se siguen situando y
  anotando igual

### Requirement: La interrupción registra su destinatario

Cada interrupción entregada SHALL registrar el puesto al que se dirige, su instante
y el motivo, de modo que el banco pueda contarlas y asertar sobre ellas.

#### Scenario: Cero interrupciones por eventos autorizados

- **WHEN** el banco exige que ningún acto autorizado en agenda produzca
  interrupciones
- **THEN** la comprobación cuenta las interrupciones del expediente, que es cero
