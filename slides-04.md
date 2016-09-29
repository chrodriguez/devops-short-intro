***
# La perspectiva de infraestructura
---
## La perspectiva de infraestructura
<small>
Los ejemplos expuestos no son aplicables a todos los casos, sino una enumeración
de problemas habituales en las áreas de infraestructura
</small>

* Según el tipo de organización, este área puede atender servicios críticos
  como: DNS, Mail, Web institucional, comunicaciones, virtualización, gestión de
  usuarios vía SQL/LDAP/ADS
* Varias organizaciones gestionan sus servicios en forma manual
---
## La perspectiva de infraestructura
* El área de desarrollo es un área más a la que se le brinda servicio
* Las políticas de homogeneizar lenguajes, frameworks, servicios o cualquier
  herramienta informática han fracasado en pos de arquitecturas heterogéneas
* Atender la seguridad que se ve comprometida cuando se permite el hosting
  manipulado por el área de desarrollo
* Política de backups clara para los servicios pero no para las aplicaciones
* Estadísticas y monitoreo de servicios, pero no aplicaciones
---
### Servicios críticos
* Hoy día, servicios como el DNS o Mail se consideran funcionales per se.
* En el caso del DNS, utilizar TTL pequeños promueve la resilencia
* Las organizaciones ya utilizan virtualización como una simplificación de sus
  Datacenters, gestión de la infraestructura, snapshots de VMs y migraciones en
  caliente
  * Algunas organizaciones desconfían de la virtualización para algunos
    servicios críticos para su negocio. Por ejemplo base de datos.
---
### Servicios críticos
* Es común que la gestión de cuentas de usuarios siga siendo una tarea más del
  área de infraestructura
* Mantener actualizadas las versiones de cada servicio crítico evitando posibles
  vulnerabilidades

<small>
Atender a todas las cuestiones mencionadas demanda tiempo y esfuerzo que no
dejan lugar para la investigación de nuevas tendencias, prácticas ágiles o
automatización
</small>
---
### Gestión manual de los servicios e infraestructura
* En los grupos de desarrollo, es habitual programar o automatizar
  cualquier paso repetible, pero no siempre aplica esto mismo en infraestructura
* Las tareas repetitivas se suelen automatizar con scripts en shell que utilizan
  herramientas auxiliares: awk, perl, python, sed, php, bc, etc
  * Soluciones muy acopladas que no pueden reusarse en todos los casos
---
### El cliente más demandante: desarrollo
* El área de desarrollo es un área más a la que se le brinda servicio
* Entre los servicio ofrecidos, pueden mencionarse:
  * **Hosteo de aplicaciones:** infraestructura deja un hueco donde desarrollo
    puede subir código. Se debe determinar la forma en que se dan los accesos y
    a qué se da acceso
  * **Virtualización:** se ofrece un servicio de virtualización del tipo PAAS.
    Desarrollo gestiona su infraestructura
  * **Deploy de aplicaciones:** Sería como el caso de hosteo de aplicaciones,
    pero además, es responsabilidad del área de infraestructura ejecutar el
    deployment en producción
---
### El cliente más demandante: desarrollo
* Continuando con los servicios que se brinda a desarrollo:
  * **Gestión de ambientes:** a medida que se van consolidando mejor los grupos
    de desarrollo e infraestructura, surge la posibilidad de aislar ambientes,
    como por ejemplo: pruebas, desarrollo, staging, QA, producción
  * **Servicios para la gestión de proyectos:** es común que además de los
    servicios críticos, el área de infraestructura brinde servicios que permitan
    a los desarrolladores manejar tickets, versionado, chat, irc, integración continua, etc
---
### Ambientes heterogéneos

* Hasta no hace mucho tiempo e incluso en la actualidad, existen organizaciones que siguen
  imponiendo la homogeneización de sus ambientes
* Los hechos demuestran que la homogeneización de herramientas informática fracasaron en pos
  de arquitecturas heterogéneas
---
### Ambientes heterogéneos

* La heterogeneidad trae problemas al área de infraestructura
  * Surgen nuevas tendencias que se convierten en requisitos para los nuevos
    desarrollos: Ruby, NodeJS, Erlang, Redis, Memcached, Websockets, MongoDB, Hadoop, Spark, etc
  * Cómo conocer qué es lo mejor para cada caso:
      * ¿Cómo monitorear?
      * ¿Cómo backupear?
      * ¿Es seguro?
---
### Compromiso de la seguridad por hosting
* Cuando las aplicaciones se hostean en servidores propios sin un conocimiento
  claro de cómo se realizó el desarrollo se corre un alto riesgo
* Se disponen de varias herramientas que permiten resguardar la seguridad
  general
  * Asegurar estos ambientes complica la infraestructura
  * Si el hosting es compartido en un mismo servidor, es necesario garantizar la
    independencia de los aplicativos
---
### Política de backups para las aplicaciones
* Infraestructura posee políticas de backups claras para sus servicios críticos
* Cuando se deben definir para una aplicación, el área de desarrollo conoce
  mejor qué backupear
  * Desconociendo este dato, generalmente se utilizan snapshots o backups
    de **toda la aplicación**
* Dependiendo del esquema de trabajo empleado para obtener el desarrollo, puede
  que se logre disponer de un versionado de la aplicación que garantice que el
  código completo puede obtenerse *tal cual la copia está en producción*
  * En este caso, el backup se limita a las bases de datos empleadas y los datos
    generados
---
### Estadísticas y monitoreo de aplicaciones
* En infraestructura, las estadísticas y monitoreo se realiza sobre lo que es de
  su interés. Generalmente esto excluye las aplicaciones
* Conocer el comportamiento de una aplicación (estadística), nos permite tomar
  decisiones y ver cuál es el comportamiento normal de la misma. Sin embargo,
  para ello los desarrollos deben:
  * Hacer buen uso y manejo de **Logs**
  * Usar herramientas de profiling que permitan recolectar datos útiles para
    evaluar el comportamiento de una aplicación
---
### Y mucho más...

* El área de infraestructura tiene que atender otras muchas cuestiones como por
ejemplo:
  * Vencimientos de certificados
  * Gestión de SPAM para evitar la llegada, así como el bloque de nuestros MTA
    por el envío de SPAM desde nuestros servidores
  * Problemas de hardware habituales
  * Pruebas de restauración de backups
  * Migraciones de datos entre productos. Por ejemplo, una organización pudo
    haber utilizado en toda su historia, diferentes productos para su correo
    electrónico: uw-imap, cyrus, courier y dovecot
***
