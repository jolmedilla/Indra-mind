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

## Notas para trabajar aquí

- **Empieza por `docs/memoria/README.md`.** Es el índice del contexto acumulado desde julio de 2026, y ahorra volver a derivar cosas ya decididas. El punto de continuación es `docs/memoria/indra-mind-estado-y-siguientes-pasos.md`. Ten en cuenta que es una instantánea fechada: si contradice al repositorio o a lo que diga el usuario, manda lo segundo.
- Antes de proponer arquitectura o tecnología, parte de lo que esté escrito en `docs/` sobre el producto; no inventes requisitos que el cliente no haya expresado.
- Este repositorio puede contener información de un cliente. Trátala como confidencial: no la publiques ni la envíes a servicios externos sin pedir permiso.
