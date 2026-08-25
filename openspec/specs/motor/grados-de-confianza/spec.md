# motor/grados-de-confianza Specification

## Purpose

El combinador como único autor de un grado. Realiza la exigencia de que el grado
de confianza sea siempre cálculo determinista (INV-04, AR-03, ADR-028), y hace
medible la métrica del banco «grados escritos fuera del combinador: 0».

## Requirements

### Requirement: Ningún grado se escribe fuera del combinador

Todo grado de confianza SHALL producirse llamando al combinador. Ninguna otra parte
del motor SHALL asignar un grado, ni siquiera cuando el cálculo sea trivial.

#### Scenario: Una hipótesis sin discriminantes que aplicar

- **WHEN** un perfil forma una explicación sin discriminantes
- **THEN** el grado resultante sale igualmente del combinador, con la lista de
  efectos vacía

### Requirement: La regla de combinación está declarada y es monótona

El combinador SHALL partir del prior de la doctrina y aplicar cada efecto: uno que
refuerza acerca el grado a la certeza y uno que descarta lo acerca al suelo, ambos
sobre lo que queda por recorrer. Un efecto que la doctrina declare y el combinador
no conozca SHALL producir un error.

#### Scenario: Acumulación de evidencia a favor

- **WHEN** varios discriminantes refuerzan la misma explicación
- **THEN** el grado crece sin alcanzar nunca la certeza absoluta

#### Scenario: Una explicación descartada

- **WHEN** un discriminante descarta una explicación
- **THEN** su grado baja sin llegar a cero, porque la hipótesis se tacha con su
  motivo y sigue consultable, no se borra (INV-03)

### Requirement: Los pesos son nombres de la doctrina, traducidos en un solo sitio

El pack SHALL declarar los pesos por nombre y SHALL declarar la escala que los
traduce a número, de modo que un autor de doctrina no tenga que pensar en
aritmética y la aritmética sea revisable en un solo sitio.

#### Scenario: Revisar cuánto mueve un discriminante alto

- **WHEN** se quiere cambiar cuánto pesa un discriminante alto en todo el dominio
- **THEN** se edita una sola entrada de la escala del pack

### Requirement: El grado es reproducible

Dos ejecuciones de la misma cinta con las mismas versiones fijadas SHALL producir
los mismos grados.

#### Scenario: Doble pasada

- **WHEN** se reproduce la cinta dos veces
- **THEN** los grados de todas las hipótesis coinciden exactamente
