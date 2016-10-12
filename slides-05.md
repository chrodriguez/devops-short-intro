***
# Puesta en producción
### El momento en que desarrollo e infraestructura interactúan
---
## Puesta en producción
* Deben definirse procedimientos para:
  * Deploy de nuevas aplicaciones
  * Upgrade de aplicaciones existentes
  * Rollback de aplicaciones actualizadas
* Considerar la forma en que se actualizan bases de datos
---
### Deploy de nuevas aplicaciones

* Instalar una nueva aplicación en producción es el caso ideal donde se arranca
  sin historia previa
* Se deben estipular una serie de pasos que deben seguirse:
  * La aplicación corre con un usuario determinado
  * Se debe crear una estructura de directorio previa
  * Instalación de servicios que son requeridos
      * Rotación de logs
      * Servicios asincrónicos
      * Creación de usuarios y bases de datos necesarios
  * Escalado de la aplicación
  * Definir y aplicar las políticas de backups
  * Estadísticas y monitoreo
---
### Upgrade de aplicación existente
* Revisar si alguno de los puntos considerados en el caso anterior varía
* Actualizar el código, preservando en lo posible la versión anterior
* Integrar de ser posible con algún esquema de proxy reverso que permita
  trabajar en caliente y realizar [blue green deployments](http://martinfowler.com/bliki/BlueGreenDeployment.html)
  * Relación con [A/B Testing](https://en.wikipedia.org/wiki/A/B_testing)
---
### Rollback de aplicación actualizada
* Ante algún fallo inmediato detectado luego de realizar un upgrade, se desea
  volver atrás
* Siempre que no se haya realizado algun cambio en la base de datos destructivo
  que no requiera restaurar la base de datos, entonces debería ser simple
  realizar un rollback
* Si se preserva el código de la versión anterior, entonces con link simbólicos
  se puede realizar un rollback rápidamente
* Si se utiliza blue green deployments, entonces sólo se cambia el proxy reverso
---
### Actualizaciones de las bases de datos
* El versionado del código resuelve la simplicidad de actualizar y realizar
  rollbacks
  * Con las bases de datos no sucede lo mismo
* Versionar la estructura de la base de datos con el código no aporta demasiado
  * Necesitamos saber cómo aplicar un parche a un modelo en un momento y poder
    deshacerlo en caso de roolback
  * Tratar que estos parches sean idempotentes
  * No siempre sucede que un parche a una base de datos tenga vuelta atrás
* Algunos parches pueden ser costosos en bases de datos grandes
---
### Otras cuestiones a considerar en la puesta en producción
* Ante un cambio de versión es aconsejable notificar a los usuarios con
  anticipación de la interrupción del servicio
  * Esto requiere conocer el dominio de usuarios afectados
  * Programar el envío masivo de correos
  * Planificar y notificar con anticipación mejoran la calidad del servicio
* Gestión de contratos
  * Dependiendo de la relación comercial que exista con los clientes, el hosteo
    de una aplicación podrá tener un vencimiento que deberá deshabilitar el acceso
    hasta no regularizar la situación
***
