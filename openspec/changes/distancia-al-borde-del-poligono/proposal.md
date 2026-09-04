## Why

**Hay un registro falso que corregir, y una simplificación real que arreglar.**

En la sesión del 4-sep-2026 se dijo que la regla de los metros se había cambiado
para medir «con respecto a las esquinas», y quedó así en las notas: *«Cambio en la
regla de metros: distancia calculada ahora con respecto a las esquinas»*. **No se
cambió nada.** El código mide del punto del hecho al **primer vértice** del
polígono, y eso está declarado dentro de `motor/geo.py` como simplificación
conocida desde el día que se escribió.

La simplificación es real y está medida. El pack de mercancías peligrosas
pregunta si hay una instalación catalogada a menos de su umbral de distancia, y
la instalación es un polígono de cuatro vértices:

| | Distancia al fuego |
|---|---|
| vértice 1 (el que se usa) | **81,7 m** |
| vértice 2 | 114,2 m |
| vértice 3 | 117,0 m |
| vértice 4 | 85,8 m |
| **lo que dice la guía del caso** | **61 m** |

Un 34 % de error. **Hoy no cambia ningún veredicto**, porque el umbral son 150
metros y las dos cifras quedan por debajo: la condición se cumple igual y el pack
se despierta igual, así que la aserción (c) de la instancia cero está en verde.

**Pero muerde en dos sitios previsibles.** Un fuego a 140 metros del borde puede
dar 165 medido al vértice y decir que la condición no aplica cuando sí aplicaba.
Y la aserción **(e)** de `REQ-07-VLC-01` —la pizarra final completa— aserta la
distancia como valor: ahí el 81,7 chocará de frente con el 61 del caso.

O sea que esto no es limpieza: es un requisito de la rebanada que cierra la
instancia de aceptación común.

## What Changes

- La distancia de un punto a un polígono pasa a medirse al **segmento más cercano
  de su contorno**, no a un vértice arbitrario. Un punto dentro del polígono está
  a distancia cero.
- La simplificación declarada desaparece del módulo, y con ella su aviso.
- Se comprueba contra el número que el caso de referencia declara: **61 metros**
  de la nave al depósito INST-7788.
- Y se corrige el registro: en la próxima sesión hay que decir que **no se había
  cambiado**, y que ahora sí.

## Capabilities

### New Capabilities

Ninguna.

### Modified Capabilities

Ninguna del canon. En `openspec/specs/`, `motor/resolucion-de-objeto` no cambia:
la función de catálogo `distancia_geo` vive en la gramática y su spec se escribirá
cuando el intérprete de packs tenga la suya.

## Impact

`indramind-demostrador`: `src/motor/geo.py` y `src/motor/gramatica.py`.

Riesgo bajo y acotado: si el número correcto cae del otro lado de algún umbral,
cambiaría el veredicto de una aserción. Hoy no lo hace —de 81,7 a 61 con umbral
de 150—, pero hay que comprobarlo ejecutando, no razonándolo.

Lo que no garantiza: medir al contorno sigue siendo una aproximación plana sobre
coordenadas geográficas. A escala de un polígono industrial el error es
despreciable frente a las incertidumbres declaradas de las fuentes —de 5 a 55
metros—, pero deja de serlo con geometrías grandes, y eso conviene declararlo en
el módulo en lugar de callarlo.
