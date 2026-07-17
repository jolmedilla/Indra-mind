# Notas de orador — Deck de diagnóstico IndraMind

> Guion de apoyo para presentar [`diagnostico-indramind.html`](diagnostico-indramind.html)
> (Artifact: https://claude.ai/code/artifact/5fe58e2e-16f2-4364-854b-edc51110556f).
> Complementa [`preparacion-reunion.md`](../docs/preparacion-reunion.md) (mensajes clave,
> *challenge* de ontologías, manejo de objeciones) — aquí van las notas **slide por slide**.

## Contexto y tono

- **Audiencia:** José, Marcelo (jefe), un preventa «todoterreno» y un perfil de diseño/UX. Perfiles
  de negocio/producto, **no** ingenieros profundos. No **Paradigma**.
- **Tu papel:** autoridad técnica **externa e imparcial**. No vienes a ganar una guerra, sino a
  dar criterio de peso para desbloquear.
- **Tono transversal:** **desinflar el hype** y dar seguridad. Repite la idea de que esto **es
  viable, es un dominio conocido, y la dificultad está en el orden, no en la magia.**
- **Formato:** deck de scroll (se baja con rueda/flechas). Preséntalo en el navegador; ten un
  **PDF de respaldo** (Imprimir → Guardar como PDF) por si falla Teams/proyector.
- **Ritmo:** ~30–40 min de recorrido + debate. Las slides de **backup** (contador «B») solo se
  abren si alguien pide detalle técnico.

## El arco (la historia en una línea por slide)

1. Portada · 2. Por qué estoy aquí · 3. Qué es esto en realidad (conciencia situacional) ·
4. Veredicto: es viable · 5. El problema real: orden · 6. Ontologías, resueltas · 7. La
arquitectura · 8. El flujo · 9. Un caso real · 10. La competencia · 11. La soberanía ·
12. La PoC · 13. Equipo y tiempos · 14. Qué decidimos.

---

## 1 · Portada

**Objetivo:** marcar tono — serio, técnico, soberano.
**Qué contar:** te presentas y encuadras: *«Os traigo un diagnóstico técnico independiente:
qué es viable, qué no, y cómo lo construiría. Lo he preparado sin conocer el detalle del
enfoque actual, para no condicionarme.»*
**Clave:** subrayar **independiente / sin sesgo** — es tu activo.

## 2 · El encargo

**Objetivo:** dejar claro qué respondes hoy (y gestionar expectativas).
**Qué contar:** las tres preguntas — ¿es viable?, ¿es adecuado el enfoque actual?, ¿cómo lo
haría yo? *«Y lo hago desde fuera, por horas, sin intereses: mi valor es la neutralidad.»*
**Clave:** la neutralidad. Ayuda políticamente a José y Marcelo.

## 3 · Conciencia situacional (el encuadre)

**Objetivo:** dar autoridad y desinflar el hype de entrada.
**Qué contar:**
- *«Antes del veredicto, situemos qué es esto en realidad. No lo estamos inventando.»*
- Esto es un sistema de **conciencia situacional** (Common Operational Picture) — un dominio con
  **décadas de literatura**: PSIM, mando y control (C2), 112/NG911. (Señala los chips.)
- Lo establecido (banda «base») es **fusionar muchas fuentes en una foto única**. Eso ya existe.
- Lo que aporta IndraMind (banda «nuevo») es **subirlo un nivel**: el **razonamiento lateral**
  encima — correlacionar, anticipar, sugerir.
**Clave / frase:** *«La foto única ya existe. El diferencial está en el razonamiento que va
encima.»* Enlaza con la slide de competencia (los incumbentes están en la capa de abajo).

## 4 · Veredicto

**Objetivo:** dar la respuesta directa y tranquilizadora.
**Qué contar:** *«Es viable, y no es física nuclear.»* El razonamiento que buscáis es sencillo y
lateral — un LLM actual ya lo hace. El valor está en la **arquitectura** que lo integra y
orquesta en tiempo casi real. Las tres tarjetas: la magia real es la **orquestación**; el 80%
del trabajo es la **fontanería de datos**; y la carta ganadora es la **soberanía**.
**Clave:** «viable, pero no por la IA — por la arquitectura». Prepara la slide siguiente.

## 5 · Diagnóstico (el problema real)

**Objetivo:** el diagnóstico, sin señalar a nadie.
**Qué contar:** **fontanería primero, IA después.** Tarjeta verde: dónde está el valor
(integrar y correlacionar; sin eso la IA no tiene sobre qué razonar). Tarjeta roja: el patrón de
fallo — repartir por módulos y apostar por una ontología pesada **antes de definir qué es un
incidente** = la casa por el tejado.
**Clave / frase:** *«No es un problema de talento — es de orden: el fallo habitual es empezar
por la tecnología antes que por los datos y el dominio.»*
**Cuidado (político):** **no** menciones cifras del equipo actual (personas, coste, meses). El
deck ya está limpio de eso; tú también en el discurso. Mantente en lo arquitectónico.

## 6 · Ontologías (el *challenge* central)

**Objetivo:** zanjar el debate con autoridad, sin sonar dogmático. Es **la** palanca.
**Qué contar (en este orden):**
1. **Da la razón donde la tienen:** las ontologías como *motor de razonamiento* son un paradigma
   de los 80–90, superado por los transformers. En eso coincidimos todos.
2. **Reencuadra:** pero sí hacen falta **esquemas** para tres cosas que el LLM no sustituye:
   correlación determinista, identidad con procedencia, y memoria consultable con exactitud.
3. **Rebautiza:** no es «ontología», es un **modelo de eventos y entidades mínimo**; y el
   «grafo» es una **capacidad** (identidad + relaciones + procedencia), **no una tecnología** —
   puede ser Postgres.
**Clave / frase:** *«No me reafirmo en ontologías y grafos; me reafirmo en esquemas, identidad,
relaciones y procedencia.»*
**Detalle completo:** guion de 5 pasos en [`preparacion-reunion.md`](../docs/preparacion-reunion.md).

## 7 · Arquitectura de referencia

**Objetivo:** presentar el modelo mental — se lee **de abajo arriba**.
**Qué contar:** percepción compartida (N0) + **tres niveles de razonamiento**: especialista de
dominio (el mundo: ¿qué pasa?), director de incidente (el incidente: ¿qué hago?), coordinador de
operaciones (la operación: ¿qué importa ahora?). Arriba, la UX.
**Clave:** las etiquetas de la derecha — el especialista viene **de fábrica** (transferible entre
clientes); el director y el coordinador son **del cliente** (su doctrina). *«Implantar IndraMind
es codificar cómo opera esa organización — eso es soberanía y es lo que da recurrente.»*

## 8 · El flujo (diagrama)

**Objetivo:** enseñar cómo circula un evento, y los **tres planos**.
**Qué contar:** de izquierda a derecha — **Percepción** (determinista, por fuente) → **EVENTO
tipado** → **Correlación** (CEP, determinista) → **INCIDENTE CANDIDATO** → **Razonamiento** (LLM,
solo ante candidato) → especialista → fusión → director → coordinador → **operador (valida)**.
Abajo, el **estado compartido** que todos leen/escriben.
**Clave (dilo explícito):** *«Percepción y correlación son deterministas y auditables; la IA
entra solo al final, ante un candidato. La IA no vigila: razona.»* Menciona SOP = procedimiento
del cliente; y que los discriminantes son **tool-use** (búsqueda proactiva, a veces federada).

## 9 · Un caso concreto (Valencia)

**Objetivo:** que lo abstracto aterrice; anticipar la PoC.
**Guion paso a paso (detallado):** ver más abajo, **Anexo — Slide 9 al detalle**.
**Resumen:** 3 eventos (ocupación +7,6σ, metro +58%, acústico +6 dB) → el CEP ve que **convergen**
en zona+ventana → candidato → el especialista **razona, descarta hipótesis y proyecta** (75%
aforo ~20:15, confianza 0,78) → aviso al operador con **20+ min de antelación**, trazado.
**Los 3 mensajes:** (1) el valor está en la **correlación**, no en la señal suelta; (2)
**determinista primero, IA solo al final**; (3) de **detectar a anticiparse**, con control humano.

## 10 · Competencia

**Objetivo:** matizar el «nadie lo hace» con rigor (o te lo desmontan).
**Qué contar:** nadie ofrece el **motor cognitivo de fusión multidominio con soberanía**, pero
las capas de abajo están ocupadas: **conectividad** (Ericsson, dueña de Vonage/Carbyne),
**gestión de llamadas NG911** (Carbyne, Motorola, Hexagon — varios US-cloud), y en fusión/
razonamiento asoma **Palantir**.
**Clave / frase:** *«El foso: fusión multidominio, soberanía y doctrina vertical. Y no
reconstruir la centralita — integrarla como una fuente más. La ventana es real pero no infinita:
por eso, rápido y vertical.»*

## 11 · Soberanía

**Objetivo:** el argumento comercial más fuerte para sector público.
**Qué contar:** *«Tu dato no sale de tu casa.»* No replicamos el padrón ni la DGT; guardamos
identidades y relaciones, y el resto lo consultamos **bajo demanda, con auditoría**. El dueño
sigue siendo el cliente. (Zona izquierda = plataforma soberana; derecha = sistemas del cliente.)
**Clave / frase:** *«Minimización de datos = soberanía y RGPD by design. El día que el DPD
—Delegado de Protección de Datos— pregunte dónde están sus datos, esta respuesta gana la
reunión.»*

## 12 · La PoC (recomendación)

**Objetivo:** proponer el camino concreto y demostrable.
**Qué contar:** una **rebanada vertical fina** sobre Valencia (aglomeraciones), de extremo a
extremo, con datos simulados: simulador → percepción → baselines+CEP → especialista → estado
(SQLite/Postgres, **no grafo**) → panel. Éxito por **métricas conductuales**: ≥90% de eventos
reales detectados **con ≥20 min de antelación** (recall con plazo), **≤ N falsas alarmas/turno**
(punto pactado en la curva PR), 100% trazabilidad.
**Clave:** *«En semanas, no en años. Equipo pequeño + Claude. Y demuestra que la arquitectura
depende de funciones, no de tecnología pesada.»*
**Si preguntan por las métricas (perfil técnico):** no optimizamos un solo número — es un
trade-off recall-con-plazo vs. falsas alarmas, y el cliente elige el punto en la curva PR. Se
calcula **a posteriori por replay**: registramos verdad de referencia + emisiones con marca de
tiempo (en la PoC, el simulador es la verdad) y re-ejecutamos a distintos umbrales. Ojo
base-rate: en eventos raros, buena especificidad no implica buena precisión → mejor «falsas
alarmas/turno» que precisión a secas.

## 13 · Equipo y tiempos

**Objetivo:** contraste de enfoque, sin filtrar cifras internas.
**Qué contar:** big-bang (equipo grande, meses de arranque, difícil de demostrar) vs. **estilo
startup** (equipo pequeño, Claude a fondo, semanas hasta una v0.1, métricas).
**Clave / frase:** *«Los ‘dos años’ no son ingeniería del motor: son la **consultoría cognitiva**
de volcar la doctrina de cada cliente.»*
**Cuidado (político):** igual que la slide 5 — nada de personas/coste/meses del equipo actual.

## 14 · Cierre

**Objetivo:** aterrizar en decisión y próximos pasos.
**Qué contar:** tres pasos — (1) **zanjar el enfoque** (fusión y razonamiento sobre datos bien
modelados, no ontología pesada como motor); (2) **arrancar la PoC de Valencia**; (3) **definir
equipo y liderazgo técnico**.
**Clave / frase de cierre:** *«De datos integrados a inteligencia real — con criterio, no con
hype.»*

---

## Slides de backup (contador «B») — solo si preguntan

- **El modelo** — *«Si queréis ver el modelo: entidades, eventos y relaciones. Mínimo y
  gobernado, no una mega-ontología; puede vivir en tablas de Postgres.»*
- **Del evento a la conclusión** — *«Aquí tenéis un evento tipado real, la regla de correlación,
  y dónde aterriza cada pieza: el evento en series, la entidad y las relaciones en el registro,
  el incidente en la pizarra, y cada acceso en auditoría.»*
- **Dónde vive cada dato** — *«El esquema es transversal; las instancias se reparten: segundos →
  pizarra, meses → registro, bajo demanda → federado. Eso es la minimización de datos.»*
- **El registro de identidades** — *«Es una tabla de enlaces y punteros, no un almacén. El
  hash+sal del DNI sirve para enlazar (irreversible, solo se compara); el dato se recupera por
  el handle —el id del registro en esa fuente—, no por el DNI. Si la fuente solo acepta el DNI,
  se tokeniza en una bóveda aparte.»*
- **Seudonimización · RGPD** — *«Es re-identificable cruzando fuentes, así que sigue siendo dato
  personal: seudonimización + minimización, no anonimización. Guardamos identidades seudónimas y
  relaciones; el dato identificativo se queda en tu sistema, con auditoría.»* Aviso para ti: no
  digas «no tenemos datos personales» — un DPD lo rebatiría; di «minimización y seudonimización
  por diseño».

---

## Anexo — Slide 9 al detalle (paso a paso)

**Abrir:** *«Lo que visteis como diagrama, ahora con un caso real. Jueves por la tarde en el
centro de Valencia, sin ningún evento programado.»*

1. **N0 · Percepción — tres eventos tipados.** Ocupación de la plaza +7,6σ sobre lo normal;
   salidas del metro de Xàtiva +58%; acústico +6 dB sostenido 12 min. *«Dos cosas: cada señal
   por separado no es una alarma; y aquí no hay IA — son analíticas baratas y deterministas
   contra un baseline, siempre encendidas.»*
2. **CEP · Correlación — convergen → candidato.** *«El valor: cuando tres señales independientes
   convergen en la misma zona y ventana de 20 min, el sistema lo marca como candidato. Sigue
   siendo determinista y auditable — reglas, no un LLM. Es lo que un operador entre cinco
   pantallas no puede ver.»*
3. **N1 · Especialista — razona (aquí sí, IA).** *«Solo ahora se despierta la capa cognitiva.
   Compite hipótesis: ¿evento en agenda? no; ¿salida de espectáculo? no — las descarta. Emite
   ‘concentración espontánea’, confianza 0,78, nunca certeza absoluta. Y proyecta: 75% del aforo
   hacia las 20:15. Eso es anticiparse, no solo detectar.»*
4. **→ Operador — aviso anticipado y trazado.** *«Le llega con 20+ minutos de ventaja y toda la
   traza de por qué. Él valida y decide: el sistema propone, el humano dispone. Nada se ejecuta
   solo.»*

**Remate:** *«Es el mismo flujo del diagrama, con datos reales. Y es justo lo que os propongo
demostrar en la prueba de concepto.»*

**Si preguntan:**
- *¿Y si es falso positivo?* → hipótesis en competencia + discriminantes; la confianza permite
  priorizar.
- *¿Los baselines?* → del histórico, y se afinan en operación (backup).
- *¿Es tiempo real?* → casi real, y suficiente: aquí, 20 min de margen.
