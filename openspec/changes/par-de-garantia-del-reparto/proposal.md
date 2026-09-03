## Why

**Es nuestro, y el canon ya lo dejó escrito esperándonos.** El ADR-064 —nacido de
la PROP-033 de esta línea— obliga a que el transporte no separe antes de
correlacionar, y sus Consecuencias mandaron a la sesión de aplicación dejar en
`banco/borradores/E-reparto-conservador.md` el borrador del **par de garantía**
del reparto conservador: historia y contrato, sin fila decidida.

Hace ocho días yo mismo dije que ese par no se podía escribir porque no existía la
promesa contra la que la variante infractora pudiera fallar. **Ahora existe**, y
el borrador también.

Esta línea es la única que puede ejercitarlo hoy, porque es la única que tiene el
reparto instrumentado: `reparto_unico` ya mide cuántas particiones atravesaron las
lecturas de un hecho, y el fuego desplazado 137 metros al este ya se comprobó que
lo pone en rojo dejando todo lo demás en verde.

## What Changes

- La variante **conforme** y la variante **infractora** como instancias
  ejecutables de esta línea, sobre el segmento consagrado y sobre una variación
  declarada de él.
- La variación no se hace copiando y editando la cinta del canon —eso heredaría el
  deber de barrido de ADR-061—: se declara como **superposición** sobre el
  segmento, con su desplazamiento escrito.
- El arnés aprende que una instancia puede declarar su **resultado esperado**:
  la infractora **falla por diseño**, y un verde suyo es el fallo.

## Capabilities

### New Capabilities

- `arnes/resultado-esperado`: una instancia declara si debe pasar o fallar, y el
  arnés interpreta el veredicto contra esa declaración. Es lo que convierte un
  control negativo en algo exigible y no en cortesía.
- `banco/superposiciones`: variar un segmento consagrado sin copiarlo, declarando
  la variación.

### Modified Capabilities

Ninguna del canon.

## Impact

`indramind-demostrador`: `banco/instancias/`, `src/runner.py`.

Y **una propuesta al canon**: el par de garantía pertenece al banco, así que su
letra normativa la escribe José. Lo que esta línea aporta es la demostración
ejecutable y la propuesta de las dos variantes a partir del borrador que ya
existe.

Lo que no garantiza: el par demuestra que **nuestra** realización del reparto es
detectablemente no conservadora en las fronteras de celda. No demuestra que otra
línea con otra realización pase o falle: para eso hace falta que otra línea
exista.
