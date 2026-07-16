# Análisis competitivo

> **Fecha:** 2026-07-15 · Inteligencia de mercado para situar IndraMind. Redactado a partir de
> fuentes públicas (Ericsson Public Safety / Public Sector, Ericsson XR situational awareness,
> Vonage/Carbyne, Carbyne APEX/Universe). Complementa
> [`analisis-y-recomendacion.md`](analisis-y-recomendacion.md).

## Idea de cabecera

José vende que **«nadie está haciendo esto»**. Hay que **matizarlo con rigor**, porque en la
reunión alguien puede sacarlo: **nadie ofrece el *motor cognitivo de fusión multidominio*
completo que promete IndraMind, pero sí hay players grandes, financiados y ya desplegados que
ocupan capas adyacentes del *stack***. Confundir «nadie hace la fusión cognitiva» con «no hay
competencia» es un error estratégico. El foso de IndraMind hay que definirlo con precisión.

## El *stack* de seguridad/emergencias y quién ocupa cada capa

```
┌─────────────────────────────────────────────────────────────┐
│  MOTOR COGNITIVO / FUSIÓN MULTIDOMINIO  ← ambición IndraMind │
│  (correlación ciber+físico+operacional, razonamiento,        │
│   anticipación, conciencia situacional unificada)            │
│  Ocupación parcial: Palantir; incumbentes «subiendo» aquí    │
├─────────────────────────────────────────────────────────────┤
│  GESTIÓN DE INCIDENTES / CAD / PSAP / NG911                  │
│  ← SOLAPE MÁS DIRECTO con las demos de IndraMind (llamadas)  │
│  Carbyne, Motorola CommandCentral, Hexagon, NICE, RapidSOS,  │
│  Intrado/West                                                │
├─────────────────────────────────────────────────────────────┤
│  CONECTIVIDAD MISIÓN CRÍTICA (la «tubería»)                  │
│  Ericsson (4G/5G, MCPTT, network slicing), Nokia, FirstNet   │
└─────────────────────────────────────────────────────────────┘
```

## Ericsson — capa de conectividad (y expansión hacia arriba)

De sus páginas de Public Safety / Public Sector, su oferta es **fundamentalmente la
«tubería»**, no la aplicación cognitiva:

- Redes **4G/5G misión crítica**, MCPTT, **private LTE**, *network slicing* (p. ej. slice
  dedicado a ambulancias), redes desplegables (plataforma **THOR** con Verizon), Cradlepoint,
  Ericsson Security Manager, Radio Dot System (posicionamiento *indoor*).
- Se posicionan explícitamente como **habilitador**: «damos el *backbone* para que tú montes
  tus soluciones misión crítica». **No compiten con el motor cognitivo** — de hecho podrían ser
  *complementadores* / socios de infraestructura.
- **Pero ojo, dos señales de que Ericsson mira «hacia arriba»:**
  1. **XR situational awareness sobre 5G** (blog 2023): AR/XR para responders en campo
     (bomberos ven planos, peligros, rutas de escape), **fusión de sensores** (vídeo, IoT,
     LIDAR, térmica) y **IA predictiva**. Es **concepto/investigación**, no producto, y de
     **modalidad distinta** (visión de campo/wearable vs. sala de control), pero conceptualmente
     toca la «conciencia situacional».
  2. **Ericsson es dueña de Vonage, y Vonage impulsa a Carbyre** (siguiente punto) → Ericsson
     tiene presencia indirecta en la capa de gestión de emergencias.

**Lectura:** Ericsson es más **complementador (conectividad)** que competidor del motor
cognitivo, pero es un gigante con intereses crecientes en el dominio y con activos en la capa
de NG911 vía Vonage/Carbyne.

## Carbyne (Vonage / Ericsson) — el solape más directo

Carbyne es una plataforma **cloud-native de gestión de llamadas de emergencia NG911**
(suites **APEX** y **Universe**, «AI-powered 911 operations»). **Vonage** (propiedad de
Ericsson) la impulsa con sus **APIs de SMS/Messages** para conectar al llamante sin app.
Capacidades:

- **Localización precisa del llamante** (155 M puntos de localización/año), **vídeo en vivo**
  y chat instantáneo desde el móvil del ciudadano sin instalar nada.
- **Video Wallboard**: vídeo en vivo de **todos** los llamantes de la jurisdicción →
  «conciencia situacional» en emergencias a gran escala. **Responder Connect** lleva vídeo/
  localización a los responders en ruta.
- **Control Center**, ACD con enrutado por habilidades, **integraciones CAD**, y **API IoT**
  para integrar **cámaras de seguridad, vídeo de drones, datos de rideshare**.
- Métricas que presumen: información a responders **50% más rápida**, **42% menos** ambulancias
  innecesarias.

**Por qué importa:** esto **solapa directamente** con las partes de las demos de IndraMind de
**coger llamadas, triar, dar contexto al operador y agregar multi-fuente** (el escenario de
Dubai/112). Carbyne **ya está desplegado a escala** (condados de EE. UU., AT&T lo revende).
Lo que Carbyne **no** hace (por lo que se ve): la **fusión cognitiva multidominio**
(ciber+físico+operacional), el razonamiento lateral proactivo ni los tres niveles de
razonamiento. Y es **US-cloud**, lo que en sector público UE/Golfo es una **desventaja de
soberanía** — justo la carta fuerte de IndraMind.

## Otros a vigilar (conocidos del sector; verificar detalle)

Un experto los citará, conviene tenerlos mapeados antes de la reunión:

- **Palantir (Gotham/Foundry / AIP):** el competidor más directo de la ambición de **fusión +
  razonamiento** en defensa/seguridad pública. Es el nombre que más puede doler; hay que tener
  respuesta (foso de IndraMind = soberanía europea + verticalización en emergencias + coste).
- **Motorola Solutions** (CommandCentral, Vesta, PSAP/CAD): incumbente enorme en *public
  safety* de EE. UU.
- **Hexagon Safety & Infrastructure** (CAD/dispatch, *smart city*), **NICE Public Safety**
  (investigación/evidencia), **RapidSOS** (datos de emergencia), **Intrado/West** (NG911).

## Implicaciones para IndraMind (y para la reunión)

1. **Reformular el discurso de «nadie lo hace».** Mejor: *«nadie ofrece el motor cognitivo de
   fusión multidominio con soberanía; los incumbentes están en conectividad (Ericsson) o en
   gestión de llamadas NG911 (Carbyne, Motorola, Hexagon), y varios son US-cloud».* Esto es más
   creíble y más defendible ante un cliente o un comité técnico.

2. **Definir el foso con precisión — tres patas:**
   - **Fusión cognitiva multidominio** (ciber + físico + operacional correlacionados), que los
     de NG911 no hacen.
   - **Soberanía** (despliegue on-prem / nube soberana, dato en casa del cliente), donde los
     US-cloud pierden en UE/Golfo. Es la carta que «gana la reunión» con sector público.
   - **Verticalización + doctrina del cliente** (packs de razonamiento), difícil de replicar
     por un producto horizontal.

3. **Dónde NO competir:** no reconstruir NG911 / *call handling* desde cero (Carbyne y cía. lo
   tienen comoditizado y desplegado). Mejor **integrarlo como una fuente/capa más** y poner el
   valor **encima**, en la fusión y el razonamiento. Reinventar la centralita es quemar el
   presupuesto en terreno de otros.

4. **Riesgo estratégico a nombrar:** los incumbentes (sobre todo Ericsson vía Carbyne, y
   Palantir) están **subiendo por el stack** hacia la conciencia situacional con IA. La ventana
   de IndraMind (soberanía + fusión + vertical emergencias) es real pero **no infinita**: hay
   que llegar con una PoC creíble pronto. Refuerza el argumento de ir **rápido y vertical**.

## Fuentes

- Ericsson Public Safety — https://www.ericsson.com/en/industries/public-safety
- Ericsson XR situational awareness — https://www.ericsson.com/en/blog/2023/9/mission-critical-xr-based-situational-awareness-over-5g
- Ericsson Public Sector — https://www.ericsson.com/en/public-sector
- Vonage powers Carbyne (nota de prensa) — https://www.prnewswire.com/news-releases/vonage-powers-carbyne-next-generation-emergency-response-system-301193680.html
- Carbyne (plataforma / APEX / Universe) — https://carbyne.com/
