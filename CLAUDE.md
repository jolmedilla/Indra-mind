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
- `indramind-poc/` — **Submódulo de git**, no una carpeta de este repositorio. Es el repo del cliente (`https://github.com/jruizcristina/indramind-poc.git`, rama `main`): el canon del motor cognitivo y la PoC vertical del caso de aglomeraciones.

## El submódulo `indramind-poc`

Es un repositorio aparte, con su propio historial, su propio `CLAUDE.md` y su propio gobierno. Este repositorio no guarda su contenido: guarda un puntero al commit en el que está.

- Tras clonar, la carpeta viene vacía hasta que se inicializa el submódulo. De eso se encarga solo el hook `SessionStart` de `.claude/settings.json`, que ejecuta `.claude/hooks/init-submodules.sh` al arrancar cada sesión; si falla —por ejemplo, por falta de credenciales para el repositorio privado— avisa y la sesión sigue sin el canon delante. A mano sería `git submodule update --init --recursive`.
- Para traer lo último del cliente, `git submodule update --remote indramind-poc`. Eso no lo hace el hook a propósito: mover el puntero es una decisión, y se commitea aparte.
- **Dentro del submódulo mandan sus reglas, no las de aquí.** Toda sesión que vaya a tocarlo empieza leyendo su `CLAUDE.md`, y después `docs/indice-del-canon.md`, `docs/decisiones.md` y `propuestas/README.md`. Ahí el canon es la fuente de verdad y las propuestas se tramitan por su bandeja.
- Los commits dentro del submódulo son suyos y se hacen desde dentro. Cuando avanza, este repositorio ve un cambio de puntero: eso se commitea aparte y con ese sentido, «actualizado el puntero del submódulo», nunca mezclado con cambios de los cuadernos.
- **Nada de lo que hay en este repositorio puede acabar dentro del submódulo.** `docs/` contiene citas privadas del cliente, valoraciones sobre terceros y cifras de facturación; el submódulo lo leen el cliente y su equipo. La frontera es en un solo sentido: de aquí se lee lo suyo, pero lo nuestro no baja.

## Notas para trabajar aquí

- **Empieza por `docs/memoria/README.md`.** Es el índice del contexto acumulado desde julio de 2026, y ahorra volver a derivar cosas ya decididas. El punto de continuación es `docs/memoria/indra-mind-estado-y-siguientes-pasos.md`. Ten en cuenta que es una instantánea fechada: si contradice al repositorio o a lo que diga el usuario, manda lo segundo.
- Antes de proponer arquitectura o tecnología, parte de lo que esté escrito en `docs/` sobre el producto; no inventes requisitos que el cliente no haya expresado.
- Este repositorio puede contener información de un cliente. Trátala como confidencial: no la publiques ni la envíes a servicios externos sin pedir permiso.
