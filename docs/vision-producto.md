# Visión del producto — Indra Mind

> Documento vivo. Aquí capturamos, con las palabras del cliente y luego refinado,
> en qué consiste el producto que desarrolla Indra Mind. Es la base sobre la que
> se apoyará cualquier recomendación de arquitectura.

## Qué es el producto

Producto de **gestión integral de alarmas y situaciones excepcionales** que aúna múltiples
fuentes de datos heterogéneas —sensores, sistemas de alarmas existentes, cámaras de
videovigilancia, datos públicos en tiempo real (redes sociales, etc.)— en un único sistema.

Hoy los clientes tienen centros de gestión de incidencias / catástrofes cuyos operadores
manejan una diversidad de sistemas que dan información **no relacionada**, y son ellos
quienes tienen que correlacionarla mentalmente. El nuevo producto, apoyado en IA/ML (o
cualquier tecnología útil), debe:

- Unificar todas esas fuentes y sistemas en una **visión única**.
- **Razonar** sobre la situación y **correlacionar** información diversa.
- **Buscar proactivamente** más información para relacionarlo todo.
- Mostrar **sugerencias**, adelantarse a los hechos.
- Reducir la carga cognitiva del operador para que **decida más rápido y se anticipe**.

## Usuarios y clientes

Instituciones con centros de gestión de catástrofes / emergencias: 112, policía,
ayuntamientos, protección civil, etc.

Clientes en conversación:
- **Policía de Dubái.**
- Centro de emergencias de la Comunidad Valenciana (el que gestionó la DANA de octubre de 2024).

## Organización y estado actual

- Existe un **grupo dentro de Indra ("Indra Mind")** que es el *dueño* del producto: tuvo la
  idea y lo está vendiendo a clientes. José Ruíz Cristina está en este grupo (perfil más
  comercial).
- Indra adquirió hace ~2 años **Paradigma Digital**. Se decidió que el producto lo
  desarrolle un grupo dentro de Paradigma, donde había una persona con conocimiento experto
  en **una tecnología concreta** (deliberadamente no documentada aún, para no sesgar el
  análisis inicial).
- Llevan **~5–6 meses** de desarrollo con un equipo de **~30 personas** y **aún no hay nada
  funcional**. José sospecha que se han **empecinado en un enfoque no adecuado**, pero como
  perfil comercial no se ve con autoridad técnica para hacer *challenge*.

## Qué esperan de Juanjo (el encargo)

Un experto **imparcial, externo, con autoridad técnica** que:
1. Diga **cómo se haría** un producto de este tipo.
2. Valore si la aproximación actual es adecuada y responda dudas generales.
3. Después, o bien haga de **puente técnico y supervisor** entre Indra y Paradigma (si
   siguen con Paradigma como implementador), o bien **lidere un nuevo equipo técnico** si
   deciden desarrollarlo ellos.

## Restricciones y plazos

- Sin restricciones fuertes conocidas más allá de **querer tener las cosas claras durante
  julio y agosto**, probablemente **implementando un prototipo sencillo** en ese plazo.

## Identidad y pitch del producto (del material del 14/07)

- Nombre comercial: **IndraMind Security** — *«Una plataforma cognitiva soberana para
  entornos críticos de seguridad»*.
- Es la **«joya de la corona» de Indra**: ~**200 M€** de inversión, el producto con más
  personas detrás. Ámbito: **seguridad integral** en 4 verticales — infraestructuras
  críticas, emergencias, seguridad ciudadana, control de fronteras. Escala ciudad/país.
- Narrativa de venta (de José): el mundo cambió a **«guerra híbrida»** (físico + digital +
  operacional); el humano ya no da abasto; la tecnología ya no ayuda, **define** tu
  seguridad. Los dos «productos» que promete IndraMind: (1) el **«sistema nervioso de la
  seguridad integral»** — no juntar datos sino **entenderlos** y construir **conciencia
  situacional compartida**; (2) hacerlo **desde la IA** («inteligencia viva» que lo ve,
  entiende y recuerda todo). Todo con **resiliencia y soberanía**.
- **Matiz clave:** IndraMind nació orientado a **soberanía + integración de datos**; la
  parte de **IA / motor cognitivo es un *pitch* propio de José**, y es justo **lo que aún
  no existe** y hay que diseñar. Ahí está el problema.
- Los «cuatro pilares» que cita el equipo técnico: **ontologías** (entender el mundo),
  **grafos** (inferir relaciones), **memoria** (aprender), **agentes** (razonar). José duda
  de que sean los pilares correctos.

## Demos existentes («cartón piedra» / mockups)

Hechas para preventa (casi ganan **Dubai Police**). Tres escenarios:
1. **Dubai Police / 112:** IndraMind triangula y **coge llamadas** (triaje de llamadas
   huecas), las pasa al operador con contexto. Panel **ultrawide** que ordena todo lo de la
   llamada (transcripción, personas implicadas, análisis de sentimiento). Proactivamente
   **busca al dueño del almacén** que arde. Da *insights* con **score de confianza** (95%:
   incendio no accidental ligado a vehículo robado hace 6 h; 60%: ligado a caso cerrado, red
   de asociados → organizado). «Modelo GPS»: propone → operador confirma → recalcula.
2. **Subestación eléctrica (infra crítica):** correlaciona **SOC (ciber) + PSIM (físico) +
   operacional (temperatura del transformador)**. Descarta falsos positivos (coche visto 3
   veces; equipo de mantenimiento que excede su ventana; +Tª entre 7000 alertas → traducida a
   lenguaje humano). **La magia:** correlaciona ciber+físico+operacional simultáneos → alza
   incidencia crítica de **sabotaje**, cosa hoy imposible (cada sistema «por su chimenea»).
3. **CISEM Callao (Madrid) / Ayuntamiento:** cámara detecta humo en metro (solo, sería falso
   positivo) → correlaciona con redes sociales + llamadas → incidencia crítica.

**Estética** (referencia para nuestra presentación): oscura y cinematográfica; fondos
negro/azul marino con ciudad nocturna y sala de control; acentos cian/azul + toques naranja;
sans-serif limpia; cierre con **ojo rojo tipo HAL 9000** («inteligencia viva»); diapositivas
claras con tarjetas de prensa para credibilidad. Fotogramas extraídos del vídeo (en
scratchpad de la sesión; pendiente de decidir si se guardan en el repo).

## Situación organizativa y política (crítico)

- Lo desarrolla un equipo de **Paradigma Digital** (adquirida por Indra hace ~2 años).
  Lo lidera un ingeniero **muy bueno pero no experto en IA** (viene de **Stratio**, Big Data),
  que empezó ~octubre y **rescató las ontologías** de su experiencia previa. Enfoque orientado
  a **investigación forense profunda/offline**, no a tiempo casi real.
- **~30 personas, ~6 meses, ~3 M€, nada funcional.** José: «han empezado la casa por el
  tejado», equipo repartido por módulos (GIS, misiones, Kafka) sin foto global.
- **José (comercial) y Marcelo (su jefe, comercial) no pueden hacer *challenge* técnico**
  —no es su rol, y Paradigma «manda»—. De ahí el encargo a Juanjo: autoridad técnica
  imparcial y externa. Intentos de reunión *off the record* con Paradigma fueron frenados.

## Encargo, plan y logística

- **Tarifa:** 120 €/h (pendiente de validar Marcelo). Escenario mínimo posible: 16–20 h /
  3–4 sesiones y el hilo muere; escenario máximo: Juanjo lidera el producto con equipo propio.
- **Primera reunión:** objetivo doble — (1) visión, problemas, viabilidad y arquitectura a
  alto nivel; (2) propuesta de PoC rápida (equipo, tiempos, camino). Duración ~2–4 h.
- **Cuándo:** **antes de que Marcelo se vaya de vacaciones** — como muy tarde el viernes de la
  semana siguiente; idealmente **este viernes**.
- **Asistentes:** José, **Marcelo** (jefe), un preventa «todoterreno» y una persona de
  **diseño de producto / UX**. **No** asiste el tech lead débil (de vacaciones 2 semanas) ni
  **Paradigma** (eso requiere una decisión firme previa).
- **PoC candidata:** **València — detección de aglomeraciones no planificadas** (contratada,
  sin firmar/empezar). Fuentes «peculiares» (ruido, etc.); hay permiso para **fabricar datos**
  si las dadas no bastan. José quiere «plan B»: 3 personas + Claude, julio–agosto, simulador +
  red de agentes + playbooks + GUI → **v0.1 del producto**, para contrastar con la demo de
  Paradigma de fin de julio (que «no tendrá razonamiento»). Ver
  [`analisis-y-recomendacion.md`](analisis-y-recomendacion.md) §6.

## Preguntas abiertas / pendientes

- **Ver la documentación técnica de Paradigma** (ontologías): la tiene el preventa de
  vacaciones; llegará en ~2 semanas. José prefiere **no condicionar** el análisis con ella
  todavía.
- ¿Quién **decide** finalmente? Hoy, difuso: Paradigma ejecuta pero «no cree»; Marcelo/José
  venden pero no mandan en técnica. Falta un *product owner* y un líder técnico con autoridad.
- Confirmar fuentes reales de la PoC de València y si permiten detectar aglomeraciones.
- Definir modelo de **licenciamiento** defendible (ver análisis §7) — secundario para José.
- Decidir si Juanjo entra ya en la PoC (con manos del equipo de José) o solo valida.
