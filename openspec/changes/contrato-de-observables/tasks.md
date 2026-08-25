## 1. Requisitos previos

- [ ] 1.1 `nave-clase-y-reclasificacion` y `nave-consultables-y-pizarra` completadas y en verde
- [ ] 1.2 Las seis observables emitidas de verdad por el motor, no diseñadas sobre el papel

## 2. Antes de escribir

- [ ] 2.1 Releer `banco/contrato-observables.md` y comprobar si José ha movido su letra mientras tanto
- [ ] 2.2 Releer POC-007 punto 7 y POC-009, por el sobre del ensayo generativo
- [ ] 2.3 Comprobar si el esquema de instancia o `check_banco` se han decidido ya; si sí, la propuesta se acota

## 3. La propuesta

- [ ] 3.1 Las seis observables con su esquema literal, cada una anclada a la aserción del banco que la exigió
- [ ] 3.2 La granularidad de las instantáneas de pizarra, con el criterio de comparabilidad entre pasadas
- [ ] 3.3 El encaje con el esquema de instancia y con `check_banco`
- [ ] 3.4 Perímetro negativo explícito: **el transporte no se propone**, es construcción (ADR-035)
- [ ] 3.5 Las observables candidatas del borrador: decidir cuáles suben a mínimas y cuáles esperan, con motivo
- [ ] 3.6 Declarar la limitación de fondo: una implementación prueba existencia, no suficiencia; el contraste exige una segunda línea que hoy no existe

## 4. En el demostrador

- [ ] 4.1 El expediente se serializa conforme a lo propuesto y se valida contra su esquema
- [ ] 4.2 El runner asierta contra el expediente serializado, no contra objetos en memoria

## 5. Trámite

- [ ] 5.1 Fila en el inventario, commit, push
- [ ] 5.2 Puntero aquí, en commit aparte
