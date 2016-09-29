***
# Soluciones y más problemas
---
## Introducción

En este apartado veremos qué metodologías y/o herramientas han surgido
para **solucionar** algunas de las necesidades mencionadas según la perspectiva
de desarrollo e infraestructura
<div class="fragment">
Asimismo, mostraremos que estas soluciones introdujeron nuevos **problemas**
</div>
---
## Virtualización

* Existen diferentes alternativas de virtualización, que pueden ser unas mejores
  que otras según la licencia disponible, las necesidades o contexto de uso
* El uso de cualquier herramientas disponible para virtualizar, ofrece
  mejoras substanciales para:
  * Backup de VMs
  * Simplifican la gestión de servidores, *ahora virtuales*, que cuando se
    realizaba físicamente
  * Migraciones en caliente de VMs entre equipos físicos
  * Mejor aprovechamiento de recursos de hardware
  * Instalación de SO basada en templates que permite disponer rápidamente de
    servidores pre-instalados
---
## Complicaciones con la virtualización

* Sin una solución de storage no es posible aprovechar muchas de las ventajas de
  éstas herramientas
* Generalmente la características más atractivas se proveen en versiones licenciadas
* La virtualización genera más servidores que cuando se utilizaban servidores
  físicos:
  * Esto se debe a que un servicio aislado es más seguro e independiente, con lo
    cuál su reemplazo o actualización se simplifica
  * Por esta razón, crece el uso de VMs, dificultando el mantenimiento de su inventario
    que rápidamente se desactualiza
---
## Un servidor que hostea múltiples aplicaciones
* Cuando varias aplicaciones comparten requerimientos, es tentador reutilizar el
  mismo servidor para hostear múltiples aplicaciones
  * Se simplifica la gestión del servidor
  * Se compromete la seguridad de todas las aplicaciones instaladas
* Para determinar cómo compartir un mismo servidor entre aplicaciones, es
  conveniente realizar un análisis del que se obtenga una matriz de aplicaciones
  agrupadas según criticidad
---
## Nuevas tendencias
* Surgen herramientas que requieren investigación antes de su puesta en
  producción
  * nginx, HA-proxy, traefik, varnish
  * Montar aplicaciones en lenguajes poco usuales
      * Python, Ruby, Erlang, Node
  * Bases de datos NoSQL
    * MongoDB, Redis
  * Sistemas de colas AMQP: RabbitMQ, Qpid
---
## Alta disponibilidad / Failover / Actualizaciones
* Los stacks de un servicio determinado se compone de partes diferentes que
  podemos requerir garantizar alta disponibilidad y/o failover
* Actualizar un servicio es una tarea artesanal y costosa
  * Sobre todo si es un servicio distribuido con muchas dependencias
***


