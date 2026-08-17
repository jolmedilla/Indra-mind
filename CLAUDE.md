# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Qué es este proyecto

Repositorio de trabajo para la colaboración de Juan José Olmedilla como **autónomo / contractor / asesor** con **Indra Mind**, un grupo dentro de Indra. Cliente / contacto principal: **José Ruíz Cristina**. Dedicación a tiempo parcial.

No es (todavía) un proyecto de software. Su propósito es gestionar todo lo relativo al encargo: análisis, decisiones de arquitectura, documentación y presentaciones. Es posible que más adelante se añada un prototipo / prueba de concepto; cuando eso ocurra, la elección de tecnología se documentará aquí.

## Idioma de trabajo

Español. Toda la documentación, notas y comunicación se redactan en español salvo que se indique lo contrario.

## Fase actual

**Asesoría de arquitectura.** El objetivo inmediato es ayudar a Indra Mind a dilucidar la arquitectura que debe seguir su producto y preparar una recomendación para una reunión con José, su jefe y al menos otra persona del equipo (prevista para finales de esta semana o principios de la próxima).

Entregables de esta fase:
- Visión del producto capturada en `docs/`.
- Recomendación de arquitectura y camino a seguir.
- Posible presentación en `presentaciones/`.

Fase siguiente (probable, primer mes o dos): prototipo o PoC sencillo. Tecnología por decidir.

## Estructura

- `docs/` — Notas de arquitectura, visión del producto, análisis y decisiones.
- `docs/memoria/` — El contexto de trabajo acumulado: quién es quién, qué se decidió y por qué, y qué sigue sin saberse. Es una copia versionada de la memoria que Claude Code mantiene fuera del repositorio, para que sobreviva a un clonado en otra máquina.
- `presentaciones/` — Material para las reuniones con el cliente.
- `indramind-poc/` — **Submódulo de git**. Es el repo del cliente (`jruizcristina/indramind-poc`, rama `main`): el **canon** —requisitos, invariantes, decisiones y el banco como contrato— y su bandeja de propuestas. Es la fuente de verdad y no se escribe en él salvo por la bandeja.
- `indramind-demostrador/` — **Submódulo de git**. Es el repo de **construcción** de la PoC (`jolmedilla/indramind-demostrador`, rama `main`), propiedad de Juanjo y compartido con Alejandro Asensio y José Ruíz. Ahí viven el motor, el runner, los packs y las instancias del banco.

## Los dos submódulos

Son repositorios aparte, cada uno con su historial, su `CLAUDE.md` y su gobierno. Este repositorio no guarda su contenido: guarda un puntero al commit en el que está cada uno.

**La diferencia entre ellos es de materia, y conviene no confundirla.** `indramind-poc` es el canon: lo que el motor debe hacer y garantizar. `indramind-demostrador` es la construcción: cómo se hace. Lo que afecte al canon —terminología, invariantes, filas del banco, alcance— no se escribe en el demostrador: se propone contra `indramind-poc` por su bandeja, y lo ratifica José. Ese reparto lo fijaron Alejandro y José el 17-ago-2026, cuando la construcción pasó a hacerla Juanjo en solitario y el papel de Alejandro quedó en seguimiento y validación.

Todo lo que sigue vale para los dos.

- Tras clonar, la carpeta viene vacía hasta que se inicializa el submódulo. De eso se encarga solo el hook `SessionStart` de `.claude/settings.json`, que ejecuta `.claude/hooks/init-submodules.sh` al arrancar cada sesión; si falla —por ejemplo, por falta de credenciales para el repositorio privado— avisa y la sesión sigue sin el canon delante. A mano sería `git submodule update --init --recursive`.
- Para traer lo último, `git submodule update --remote <nombre>`. Eso no lo hace el hook a propósito: mover el puntero es una decisión, y se commitea aparte.
- **Las URL de los submódulos divergen a propósito, y no hay que «arreglarlas».** `.gitmodules` la declara en HTTPS porque es lo que viaja con el repositorio y lo único que funciona en la versión web, donde no hay claves. En la máquina de Juanjo, `.git/config` y el remoto del clon apuntan a SSH, que es como prefiere trabajar en local. Ver las dos configuraciones distintas no es una incoherencia que corregir. Ojo con `git submodule sync`, que reescribe la local a partir de `.gitmodules` y deshace ese reparto en silencio.
- Dentro del submódulo, `git submodule update` deja el HEAD **desacoplado** en el commit que el padre fija, así que `git pull` se queja de que no estás en una rama. Es el diseño, no un fallo: el padre pinta un commit, no una rama. Antes de trabajar dentro, `git checkout main`; si se commitea con el HEAD desacoplado, esos commits quedan colgando de ninguna rama.
- **Dentro de un submódulo mandan sus reglas, no las de aquí.** Toda sesión que vaya a tocarlos empieza leyendo su `CLAUDE.md`. En `indramind-poc`, además, `docs/indice-del-canon.md`, `docs/decisiones.md` y `propuestas/README.md`: ahí el canon es la fuente de verdad y las propuestas se tramitan por su bandeja.
- Los commits dentro del submódulo son suyos y se hacen desde dentro. Cuando avanza, este repositorio ve un cambio de puntero: eso se commitea aparte y con ese sentido, «actualizado el puntero del submódulo», nunca mezclado con cambios de los cuadernos.
- **Nada de lo que hay en este repositorio puede acabar dentro de un submódulo.** `docs/` contiene citas privadas del cliente, valoraciones sobre terceros y cifras de facturación; los dos submódulos los leen el cliente y su equipo, incluido el demostrador, que es de Juanjo pero está compartido con ellos. La frontera es en un solo sentido: de aquí se lee lo suyo, pero lo nuestro no baja.

## Notas para trabajar aquí

- **Empieza por `docs/memoria/README.md`.** Es el índice del contexto acumulado desde julio de 2026, y ahorra volver a derivar cosas ya decididas. El punto de continuación es `docs/memoria/indra-mind-estado-y-siguientes-pasos.md`. Ten en cuenta que es una instantánea fechada: si contradice al repositorio o a lo que diga el usuario, manda lo segundo.
- Antes de proponer arquitectura o tecnología, parte de lo que esté escrito en `docs/` sobre el producto; no inventes requisitos que el cliente no haya expresado.
- Este repositorio puede contener información de un cliente. Trátala como confidencial: no la publiques ni la envíes a servicios externos sin pedir permiso.
