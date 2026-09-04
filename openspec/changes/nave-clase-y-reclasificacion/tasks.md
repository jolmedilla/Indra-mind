## 1. Antes de tocar nada

- [x] 1.1 Releer `REQ-07-VLC-01.md` del canon entero, y el ADR-054 sobre suscripciones compiladas y profundidad uno
- [x] 1.2 Leer los dos packs boceto y `pizarra-DET-4471.yaml`, que es el objetivo final de la rebanada 3

## 2. La clase de detección

- [x] 2.1 `Deteccion` gana clase vigente e historial de formación y reclasificaciones, con `pack@versión` por cada una
- [x] 2.2 El expediente lo expone como observable, no como estado interno

## 3. Los despertares

- [x] 3.1 Registrar cada invocación de pack con su disparador, instante y si escribió efecto
- [x] 3.2 Aserción nueva en el runner: despertares por pack, con su cuenta esperada

## 4. Patrones sobre detección, y profundidad uno

- [x] 4.1 La especie de patrón sobre detección, disparada por formación o reclasificación
- [x] 4.2 El corte de profundidad uno, con una comprobación que lo demuestre: la lectura de mercancías no despierta a nadie
- [x] 4.3 Comprobar el negativo de (b): ninguna llamada despierta al pack de mercancías

## 5. Dos packs sobre la misma pizarra

- [x] 5.1 El cargador monta los dos packs del caso desde el submódulo del canon
- [x] 5.2 Cada lectura queda firmada con su pack y versión, y jamás nace un segundo objeto

## 6. Cierre

- [x] 6.1 Las aserciones (b) y (c) en verde, y la métrica 7 + 1 = 8
- [x] 6.2 Actualizar el bloque `cobertura` de la instancia: (b) y (c) salen de la lista de pendientes
- [x] 6.3 Las cinco ejecuciones anteriores siguen dando lo mismo
- [x] 6.4 PR, fusión, puntero
