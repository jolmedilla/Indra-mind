---
name: alta-autonomo-y-contratacion-malt
description: "Alta de autónomo (9-ago-2026) y contratación con Indra vía Malt: datos fiscales, tarifa con el fee del 2 %, presupuesto enviado el 10-ago y cabos sueltos"
metadata: 
  node_type: memory
  type: project
  originSessionId: e2e894d9-1423-40b3-827d-6e63a0238810
  modified: 2026-08-12T06:44:35.911Z
---

Estado al **10-ago-2026**. Sustituye a la vía de «facturar a través de una empresa» que aparecía en [indra-mind-engagement](indra-mind-engagement.md): el canal es **Malt**, y Juanjo factura como **autónomo español**.

## Alta fiscal (9-ago-2026)

- **036 de alta** presentado el 09-08-2026 (justificante 0367386298151). Un segundo 036 el mismo día es solo modificación de la casilla 142 (teléfonos y correos): irrelevante.
- **Epígrafe IAE 762, sección 2ª** — «Doctores, licenciados, ingenieros informáticos», tipo **PROFESIONALES**. Al ser persona física está **exento de IAE**, así que el «Certificado de situación en el censo de Actividades Económicas» dirá siempre *no figura*: eso no prueba nada y **no debe subirse a ningún sitio**, se lee como que no está de alta.
- **IVA régimen general**, establecido en TAI, no exento → repercute **21 %**. NIF-IVA **ES02531364F**. **Alta en el ROI** (casilla 582) el 09-08-2026.
- **IRPF estimación directa simplificada.** Casilla 600 (pagos fraccionados) sin marcar.
- Domicilio fiscal: C/ Francisco Navacerrada 11, 1º A, 28028 Madrid. Alta en **RETA** con fecha 09/08/2026.

El **certificado de situación censal** obtenido por la app de la AEAT sale en versión reducida (solo identidad y domicilio) y el censo tardó en propagar: para acreditar la actividad sirve el propio **036 de alta**.

## Quién es quién

- **Cliente final: INDRA SOLUCIONES TECNOLOGÍAS DE LA INFORMACIÓN, S.L.** — sociedad española, **no Minsait**. Pero **no es a quien se factura**: ver más abajo.
- **Manager en Malt: José Enrique Argibay del Olmo** (`jeargibay@minsait.com`). Pre-acepta el presupuesto y lo pasa a **subcontrataciones de Indra** para validación final.
- **José Ruíz Cristina** no tenía cuenta en Malt; Espe iba a invitarle para ponerle después como responsable de **validar las horas**.
- **Malt: M.ª Esperanza Jerez** («Espe», `esperanza.jerez@malt.com`), account manager. **Héctor Cárdenas** y **Alba Encabo** en el mismo equipo.

## La tarifa: 122,45, no 122,40

El fee del freelance es del **2 % y se descuenta del bruto**, así que para percibir 120 €/h netos hay que **dividir**: 120 / 0,98 = **122,45 €/h**. Espe escribió «122,4 €/h (120 + 2 %)», que es sumar y deja 119,95. Su propio ejemplo del 7-ago la contradice: «si lo acordado es que recibas 50 €/h netos, el presupuesto deberá reflejar 51,02 €/h» (= 50 / 0,98).

**El formulario de Malt es el árbitro:** la línea «Vas a recibir» calcula en vivo, y ahí se comprueba.

## Presupuesto enviado el 10-ago-2026

Tipo **«Por duración»** (recurrente, pago mensual contra informe de actividad), nunca «Por entregables»: las 10 horas atrasadas solo caben en el informe mensual, y por entregables se cobraría todo al final asumiendo el riesgo de aceptación.

| | |
|---|---|
| Nombre | IndraMind Security PoC |
| Fechas | 10/08/2026 → 28/02/2027 |
| Tarifa | 122,45 €/h |
| Horas presupuestadas | 184 h → 22.530,80 € sin IVA |
| **Volumen realmente previsto** | **~42 h** (4 h de julio + 38 h del 3-ago al 15-sep) → 5.142,90 € sin IVA = **5.040 € netos** |

El techo alto es deliberado: Indra abrió una necesidad de 7 meses y «1 día/semana», y el recurrente **solo factura lo declarado cada mes**. Se le explicó a Enrique por la mensajería de Malt.

Las **10 horas previas** (4 de julio + 6 de la semana del 3-ago) se declararon en **«Detalles del proyecto»**, no en «Tus Condiciones Generales de Uso»: ese campo se lee como condiciones impuestas por el freelance y subcontrataciones podría escalarlo a legal.

## Cabos sueltos

- **Autofacturación, y a quién se factura de verdad.** Héctor Cárdenas (Malt) el 10-ago: *«la plataforma emite la factura automáticamente, siendo **Malt Community** la entidad facturada, y luego se hace otra factura entre Malt y tu cliente»*. Es decir, **Juanjo no factura a Indra**: factura a Malt Community, y Malt factura a Indra. Si Malt Community es francesa, la operación es **prestación intracomunitaria B2B — inversión del sujeto pasivo, 0 % de IVA y sin retención de IRPF**, que es justo para lo que sirve el alta en el ROI. **En el presupuesto se puso 21 %**: hay que confirmar país y NIF-IVA de Malt Community y corregirlo antes de la primera factura.
- **Si no hay retención**, decae la exención del 70 % y toca **modelo 130** trimestral más modificar la casilla 600 del censo.
- Malt emite las facturas **en nombre de Juanjo**; no debe emitir ninguna él. Se descargan de «Facturas y pagos». **Documentación validada el 11-ago-2026.**
- **Espe avisó** de que no se pueden imputar horas antes del **alta en la plataforma interna de Indra**; la fecha de inicio del presupuesto es orientativa. Dejó por escrito, dos veces, que empezar a colaborar antes de la validación **no es el procedimiento correcto**.
- Se aceptaron las **Condiciones Generales de Uso de Indra sin leerlas**. Conviene descargar copia.
- Verificación de los datos de empresa en Malt: ~48 h desde el 10-ago.
