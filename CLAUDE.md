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

## OpenSpec: dónde vive el trabajo en curso

Desde el 25-ago-2026 este repositorio lleva **OpenSpec** (`@fission-ai/openspec`),
en `openspec/`. Existe para que el trabajo en curso no se pierda entre sesiones y
para que las tareas estén ordenadas en vez de repartidas por la prosa.

**El contexto del proyecto vive en el bloque `context` de `openspec/config.yaml`**,
no en un `project.md`: esta versión no lo usa, y las skills leen el `config.yaml`.
Ahí está lo que una sesión fría necesita saber — la topología de los repositorios,
quién ratifica qué, el vocabulario vinculante, cómo se ejecuta el banco y los
compromisos vivos —. Si algo de eso cambia, se actualiza ahí.

**Hay tres sitios donde vive «qué estamos haciendo», y no deben solaparse.** Esta
es la regla, y es la que impide que OpenSpec se convierta en un tercer proceso
que compita con los dos que ya funcionan:

| Dónde | Qué le toca |
|---|---|
| **La bandeja del canon** (`indramind-poc/propuestas/`) | Todo lo que cambie **qué debe hacer** el motor. Obligatoria y ratificada por José. OpenSpec no la sustituye ni la duplica: cuando un cambio necesite tocar el canon, su `tasks.md` incluye «abrir PROP-nnn» como tarea, y el contenido normativo se escribe allí. |
| **`openspec/changes/`** | Nuestro trabajo de **construcción**: las rebanadas del motor, los refactores, las propuestas que redactamos, las tareas en curso con su estado. |
| **`docs/memoria/`** | El contexto **narrativo** acumulado: quién es quién, qué se decidió y por qué, las lecciones de método, el contexto político. **Ya no es la lista de tareas**: eso se mudó a `openspec/changes/`. |

**En `openspec/specs/` no van los requisitos del producto.** Son de José y viven
en el canon. Ahí van las **capacidades de construcción de nuestra línea** — el
arnés y sus propiedades tal como las implementamos, la resolución de objeto, el
combinador, la traza —. Es el mismo corte que hace POC-007: el canon posee qué
debe hacer el motor; cada línea posee cómo lo hace. Escribir ahí un requisito del
producto sería crear la copia de segunda mano que los dos repositorios existen
para evitar.

**Y OpenSpec no se instala en los submódulos.** En el canon, porque tiene su
mecanismo ratificado y colisionaría. En el demostrador, porque su `README` dice
que allí no se reproduce nada del canon a propósito, y una carpeta de
especificaciones es exactamente eso. Además, muchas tareas cruzan los dos
submódulos, y el único sitio desde el que se ven los dos es este.

## Quién fusiona, y quién decide

**En `indramind-demostrador`, la sesión abre la pull request y para ahí.** No la
fusiona nunca por su cuenta, aunque el cambio esté en verde, aunque lo haya
escrito ella entera y aunque el banco pase. Tampoco borra ramas del remoto. Nada
de `gh pr merge` ni de `git push origin --delete`.

El `CLAUDE.md` de ese repositorio dice que «quien construye fusiona cuando el
cambio está listo, sin esperar», y eso es cierto y no se toca: está escrito para
que el trabajo no se pare cuando el revisor está ocupado o de vacaciones. Pero
significa que **Juanjo no depende de Alejandro** para decidir cuándo entra un
cambio; no que la decisión la tome la sesión. El 25-ago-2026 se fusionaron cuatro
pull requests seguidas sin que Juanjo tocara nada, y no era lo que se quería.

**Esta regla vive aquí y no allí a propósito.** Es cómo se trabaja con la sesión,
no política del proyecto, y el demostrador lo leen el cliente y su equipo. Lo
mismo vale para cualquier otra regla sobre cómo colabora Juanjo con Claude: la
frontera de un solo sentido que gobierna todo este repositorio también se aplica
a las reglas.

Después de que Juanjo fusione, sí toca actualizar el puntero del submódulo aquí,
en commit aparte y con ese sentido.

## Dos cuentas de GitHub en la misma máquina

La que sale por defecto es la equivocada. **Antes de cualquier `gh`, comprobar la
cuenta activa**, porque suele quedarse en `jolmerlyn`, que es de otro cliente:

```sh
gh auth status
gh auth switch --hostname github.com --user jolmedilla
```

Los tres repositorios llevan ya la identidad de git correcta —`Juan J. Olmedilla
Arregui <juanjo@olmedilla.com>`— por un `[include] path = ~/.gitconfig-personal`
en su `.git/config`. Si aparece un clon o un submódulo nuevo, hay que ponérselo,
o los commits saldrán con el correo y la **clave GPG de otro cliente**:

```sh
git -C <repo> config --local include.path '~/.gitconfig-personal'
```

## Notas para trabajar aquí

- **Mira `openspec/changes/` al arrancar**, con `openspec list`, para ver qué hay en curso y con qué tareas.
- **Empieza por `docs/memoria/README.md`.** Es el índice del contexto acumulado desde julio de 2026, y ahorra volver a derivar cosas ya decididas. El punto de continuación es `docs/memoria/indra-mind-estado-y-siguientes-pasos.md`. Ten en cuenta que es una instantánea fechada: si contradice al repositorio o a lo que diga el usuario, manda lo segundo.
- Antes de proponer arquitectura o tecnología, parte de lo que esté escrito en `docs/` sobre el producto; no inventes requisitos que el cliente no haya expresado.
- Este repositorio puede contener información de un cliente. Trátala como confidencial: no la publiques ni la envíes a servicios externos sin pedir permiso.
