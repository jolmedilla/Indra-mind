## 1. Antes de tocar nada

- [ ] 1.1 Releer POC-003 (punto único), POC-009 (las dos capas del recorrido en seco), ADR-028 (la valoración en dos tiempos y los grados), ADR-048 (la válvula) y PRE-05 (el presupuesto)
- [ ] 1.2 Releer el «sobre del ensayo generativo» de `banco/contrato-observables.md`: es la lista de aserciones que hay que poder emitir
- [ ] 1.3 Leer las seis escenas del storytelling que lo exigen, para saber qué forma tiene cada invocación

## 2. El punto único

- [ ] 2.1 Un solo sitio por el que pasa toda invocación generativa, con su registro
- [ ] 2.2 Los momentos y la forma catalogada los declara el pack, no el código
- [ ] 2.3 La válvula, cerrada por defecto y abierta solo por cláusula declarada, con su tope

## 3. El sobre, que es lo asertable

- [ ] 3.1 Etiqueta de origen generativo en todo lo producido (INV-10, REQ-37)
- [ ] 3.2 **Cero grados escritos por la capa generativa**, comprobado con una aserción que pueda ponerse en rojo
- [ ] 3.3 Anclajes: lo afirmado cita eventos y consultas que existen, y se verifica que existen
- [ ] 3.4 Presupuesto de invocaciones respetado (PRE-05), asertable

## 4. El replay sigue siendo posible

- [ ] 4.1 Salidas enlatadas o cacheadas, fijadas por la instancia como una versión más
- [ ] 4.2 La pasada sin generativas, que es lo que verifica INV-05 y lo que REQ-53 exige sobre toda la suite
- [ ] 4.3 Comprobar que la doble pasada sigue dando diferencia cero con lo generativo dentro

## 5. La primera escena de verdad

- [ ] 5.1 Elegir la más barata de las seis para estrenar la capacidad, y decir por qué
- [ ] 5.2 Dejar escrito qué parte quedó validada por aserción (el sobre) y qué parte a juicio humano (la carta)

## 6. Cierre

- [ ] 6.1 PR abierta, y la fusiona Juanjo
