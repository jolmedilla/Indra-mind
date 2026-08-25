# motor/correlacion Specification

## Purpose

La capa que convierte cada evento en una observación situada: el objeto al que
pertenece y lo que se puede medir de ella sin saber de dominio. Realiza C-02
—desviaciones sobre las líneas base— y entrega el resultado a quien decida.

## Requirements

### Requirement: Primero el objeto, después la medida

El correlador SHALL resolver el objeto de un evento antes de calcular ninguna
medida sobre él.

#### Scenario: Una lectura cuantitativa

- **WHEN** entra una lectura con valor
- **THEN** primero se resuelve a qué objeto pertenece, y la desviación se calcula
  contra la línea base de ese objeto

### Requirement: La desviación puede no existir, y su ausencia no es normalidad

La observación SHALL admitir que no haya desviación calculable. Ningún consumidor
SHALL leer ese hueco como normalidad.

#### Scenario: Una lectura cualitativa

- **WHEN** entra una llamada al 112, que no trae número
- **THEN** la observación se entrega sin desviación, y ningún detector que exija
  desviación la considera

### Requirement: La ausencia declarada de dato se anota solo cuando hay dato que falte

El correlador SHALL anotar ausencia declarada de línea base únicamente cuando la
lectura traiga un valor numérico y no exista línea base contra la que compararlo.

#### Scenario: Una fuente cuantitativa sin baseline cargada

- **WHEN** entra una lectura con valor sobre un objeto sin línea base
- **THEN** se anota la ausencia, para que no se confunda con normalidad (INV-08)

#### Scenario: Una fuente cualitativa

- **WHEN** entra una lectura sin valor
- **THEN** no se anota ninguna ausencia, porque no falta un dato: la pregunta no
  aplica

### Requirement: El correlador es la única puerta a los datos crudos

Un razonador no SHALL acceder al bus ni a las líneas base. SHALL pedir al
correlador la ventana de observaciones de un objeto.

#### Scenario: Un razonador buscando convergencia

- **WHEN** un razonador necesita saber cuántas fuentes distintas se han desviado
  sobre un objeto
- **THEN** pide la ventana al correlador, que la responde desde lo ya observado

### Requirement: El correlador es barato y corre para todo

El correlador SHALL procesar todos los eventos de todas las fuentes vigiladas, y
los razonadores SHALL despertarse solo cuando haya algo que mirar. Esa separación
es la condición para que el coste crezca sublinealmente con las fuentes (PRE-04).

#### Scenario: Ruido de fondo

- **WHEN** entra una lectura dentro de lo normal
- **THEN** el correlador la sitúa y la anota, y ningún razonador forma nada
