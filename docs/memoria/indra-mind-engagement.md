---
name: indra-mind-engagement
description: "The indra-mind project is Juanjo's freelance advisory engagement with Indra Mind"
metadata: 
  node_type: memory
  type: project
  originSessionId: 81a3551e-bf28-44aa-97bb-ca6e4ab02cf9
  modified: 2026-08-10T10:45:53.651Z
---

`indra-mind` (en `/Users/juanjo/Code/indra-mind`) es un proyecto de trabajo para la colaboración de Juanjo como **autónomo / asesor a tiempo parcial** con **Indra Mind**, un grupo dentro de Indra. Cliente / contacto: **José Ruíz Cristina** (le contrata para ayudar con el producto que desarrollan).

No tiene relación con su TFM (que vive en `/Users/juanjo/Code/tfm-master-de-datos-uned`, un proyecto LaTeX/R aparte).

**Estado a 2026-07-31 (avanzó):** la reunión inicial (mediados de julio, con el deck de `presentaciones/diagnostico-indramind.html`) fue **muy bien**. El encargo se concretó en dos conversaciones con José: **llamada tel. 29/07** y **videollamada 31/07** (minutas en Granola/Notion, base de datos «Juan's Granola Notes»; José = +34615437634 / jruizcr@servicios.indra.es). **Juanjo confirmado como colaborador externo para hacer una PoC** dentro de Paradigma.

**La PoC:** deadline **finales de septiembre** (antes de que el tema «explote» internamente); Juanjo estima **~4–6 h/semana**. Enfoque técnico: **test-driven** (escenarios primero, código mínimo después) + **ablaciones** (quitar un componente —p. ej. el razonador de dominio— y demostrar que el sistema empeora, para justificar la arquitectura mínima); **interfaz propia**, no una simple llamada a Claude; simular el mecanismo agente (carga contexto → razona → vuelca) con Claude antes de codificar.

**Repo/doc:** José ya tiene un **repo en GitHub** con documentación generada con Claude (arquitectura, glosario, **ADRs**, y **todos los planes de emergencia de España** como base de conocimiento; Claude mantiene un track de decisiones). Juanjo compartió su cuenta GitHub (jolmedilla) para acceso; José envía acceso + instrucciones por correo. **Tarea de Juanjo: revisar el repo (fin de semana + tardes) y contrastarlo con su propia arquitectura/plan** (lo de `docs/`).

**Debate abierto del 29/07 — separar requisitos de arquitectura.** Juanjo le planteó a José que su documento mezcla requisitos funcionales, no funcionales y decisiones de arquitectura, y propuso partirlo en dos (requisitos por un lado; arquitectura como consecuencia derivada). Él mismo identificó el riesgo: que el equipo interno se quede con lo funcional e ignore la arquitectura. Su postura final fue **preferir tenerlo todo junto respaldado por una demo que funcione** — si la PoC va, la carga de la prueba se invierte («igualámelo») — quedando abierto a la separación si se puede hacer sin fisuras. **Nota para futuras sesiones:** el canon ya lo resolvió mejor un día antes, con ADR-035 (dos ámbitos, motor cognitivo como norma íntegra y construcción libre, más la cláusula «no hay inviabilidad sin identificador»: toda alegación se formula contra filas del banco, invariantes o presupuestos). No hace falta reabrir el debate de la separación.

**Política (importante):** llamarlo **«requisitos», no «arquitectura»**, para que el equipo de producto de Paradigma no reclame la arquitectura como suya. La PoC debe parecer **hecha «a ratos»**, no un esfuerzo agresivo coordinado. Nueva persona: **Alex** (técnico interno de Paradigma, con vínculo al equipo de producto) hará de **árbitro/cara visible** para que la PoC no parezca una amenaza externa; revisa el repo en paralelo. Mismos requisitos/escenarios sirven para la PoC y para el equipo de producto (reconciliables).

**Logística:** tarifa **120 €/h**. Lo de facturar «a través de una empresa» quedó atrás: el canal acabó siendo **Malt**, y Juanjo se dio de alta como **autónomo el 9-ago-2026** — ver [alta-autonomo-y-contratacion-malt](alta-autonomo-y-contratacion-malt.md) para datos fiscales, tarifa con el fee y el presupuesto enviado. José viaja a Londres **mié–jue 5–6/08**. **Viernes 7/08: puesta en común Juanjo + Alex** para decidir si se avanza y cómo organizarse.

**Minutas de Granola:** viven en Notion, base de datos **«Juan's Granola Notes»** (`collection://d116fe2f-291b-8380-b8bf-07bb4b7a99a3`). Ojo: Notion guarda **el resumen de Granola, no la transcripción literal**; el verbatim está tras los enlaces `notes.granola.ai` de cada nota. `notion-query-meeting-notes` **no sirve** (exige plan Business); usar `notion-search` con `data_source_url` apuntando a esa colección.

**Nota de herramientas:** las herramientas del conector **Blueticks/WhatsApp sí aparecen** en Claude Code, pero el 31-jul-2026 no había **ningún motor de WhatsApp vinculado** a la cuenta: `engine status` devuelve `[]` y toda llamada da `503 unavailable — No WhatsApp engine is connected`. Hay que revincular la sesión escaneando el QR desde el panel de Blueticks; reintentar sin hacerlo no sirve de nada. Alternativa para ponerse al día: las **minutas de Granola en Notion**.

**Blueticks acabó conectando** el 31-jul por la noche, pero el plan gratuito limita a **5 peticiones por ventana de 6 horas**, y el historial cargado llegaba solo hasta ese mismo día a las 12:27 UTC. **Sigue pendiente leer el hilo con José desde el 7 de julio**: hay que llamar a `chats load_more_history` en una ventana nueva antes de gastar peticiones en otra cosa. De lo del 31-jul sí se rescataron las instrucciones del proyecto: ver [instrucciones-jose-proyecto-indramind](instrucciones-jose-proyecto-indramind.md). El repo de José ya está clonado y leído: ver [indramind-poc-repo-canon](indramind-poc-repo-canon.md).

Idioma de trabajo: **español**. Estructura: `docs/` (visión y arquitectura), `presentaciones/` (deck + notas de orador). Detalle del producto en [indra-mind-producto](indra-mind-producto.md).
