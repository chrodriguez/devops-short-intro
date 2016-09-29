***
# La perspectiva de desarrollo
---
## La perspectiva de desarrollo

* Ambientes complejos:
  * Arquitecturas de N capas
  * Micro servicios
  * Muchas *inter*dependencias en un desarrollo moderno
* Gestión de los proyectos: procedimientos y flujos de trabajo
* La forma en que se deployan nuevos productos o actualizan versiones
* Usando metodologías ágiles se maximiza la velocidad de nuevos releases.
  * Ésto impulsa nuevos deployments en algún ambiente (testing, staging, QA) o
  directamente en producción
---
## La perspectiva de desarrollo

* Si se aplica TDD, se requiere mantener una infraestructura donde los
  tests contribuyan con la gestión de los proyectos
  * Que los tests pasen antes de un merge
  * Integración continua
* Lenguajes y herramientas modernas disponibles en el ambiente de desarrollo pero
  diferentes en producción
* Gestión de versiones
  * [Semantic Versioning](http://semver.org/) para el código
  * ¿Qué pasa con la base de datos?
* Replicar el ambiente de producción para analizar problemas, así como probar
  una actualización de versiones
* Necesidad de estadísticas y monitoreo

---
### Ambientes complejos
* Las aplicaciones ya no son las tradicionales arquitecturas de tres capas
* Las herramientas a utilizar ya no sólo se conforman de **un** lenguaje,
  una base de datos SQL y un framework
* Necesidad de ambientes independientes entre los desarrolladores
  * Algunas organizaciones promueven un ambiente común de desarrollo donde toda
    la complejidad se concentra en un cluster compartido por N desarrolladores
* Dificultad para involucrar nuevos integrantes
  * Exceso de tiempo para aprender a gestionar la infraestructura en vez de
    programar
---
### Gestión de proyectos
* Independientemente de la gestión de proyectos teórica y comercial hacemos
  hincapié en los procedimientos para trabajar
* Respetar estándares de codificación
* Utilizar alguna herramienta de versionado de código: GIT
  * [git-flow](https://github.com/nvie/gitflow): *trabajo con estrategias de branches y manejo de releases*
  * Permisos sobre las branches: *desarrolladores con más experiencia revisan el
    código de programadores con menos experiencia. Por ejemplo: [flujo tipo GitHub](https://guides.github.com/introduction/flow/)*
---
### Gestión de proyectos
* Relacionar los tickets/versiones del producto en producción, con los 
  procedimientos/flujos definidos anteriormente
  * Esto mismo sugiere git-flow con los [hotfix
    branches](http://nvie.com/posts/a-successful-git-branching-model/#hotfix-branches)
* Aplicar buenas prácticas de calidad 
  * TDD con alta cobertura
  * Tests de aceptación
* Aspiraciones para alcanzar:
  * Integración continua
  * Delivery continuo
  * Deployment continuo
---
### Deployments
* Poner una versión de un producto nuevo en producción puede
  * Ser simple si el ambiente ya existe y no requiere nuevas dependencias
  * Ser complejo si el producto a instalar requiere nuevas dependencias
* Revisar si cada una de las dependencias satisfacen sus requerimientos
  * ¿El código provee de ésta información?
* Automatizar los deployments simplificando las tareas repetitivas
  * Usar scripts caseros o herramientas de automatización como Capistrano,
    Ansible, Chef, Puppet, Salt, etc
---
### Metodologías Ágiles
* El [manifiesto ágil](http://www.agilemanifesto.org/iso/es/) hace énfasis en
  los siguientes valores:
  * Individuos e interacciones
  * Software funcionando
  * Colaboración con el cliente
  * Respuesta ante el cambio
* Aplicando esta metodología se promueve lanzar nuevas versiones en períodos muy
  cortos de tiempo, lo cuál termina manifestando un cuello de botella en las
  oficinas de IT.
  * Responder a los requerimientos ágiles requiere una operatoria ágil desde IT
  * Empiezan a darse deployments con frecuencias diarias e incluso varios al día
---
### TDD

* Cuando elevamos los requerimientos de QA es bueno aplicar tests
* Los tests deben controlarse por QA, en cada etapa del desarrollo, estableciendo
  políticas de aceptación para cada etapa
---
### TDD
* Ejemplos de políticas:
  * El código no es revisado antes de mergerarse si no pasan los test de unidad,
    funcionales e integración. Tampoco si el analizador de código no garantiza
    se respetan estándares
  * Un release no pasa a producción si no pasa todos los tests de unidad,
    funcionales e integración
* Es importante poder aplicar [Integración Continua](https://en.wikipedia.org/wiki/Continuous_integration). 
  Sin embargo, armar un ambiente de éste tipo no es trivial y depende del área
  de IT
---
### Versiones de librerías y lenguajes
* Es común que los desarrolladores surfeen la cresta de las olas
  * Utilizan versiones muy actuales de determinados productos que complican
    los ambientes
  * Algunos lenguajes no permiten, *de forma simple*, tener en el sistema más de una versión de una
    misma librería o lenguaje. Por ejemplo PHP
* Esto crea diferencias entre el ambiente de desarrollo y producción
  * Justamente, ésta es la brecha que debemos achicar
---
### Gestión de versiones

* Si bien el código se maneja con versiones y GIT/SVN mantiene una
  identificación de cada commit, se necesita manejar un versionado de releases
  amigable
* [Semantic Versioning](http://semver.org/) contribuye a entender qué significa
  que un release 2.5.1 pase a la versión 2.5.2 o 2.6.0
* ¿De qué forma es posible mantener la traza del modelo de datos respecto de las
  versiones de código?
---
### Acceso al ambiente de producción

* Siempre es necesario acceder a un recurso en producción
* Acceso al dump o código completo
  * El código no debería ser necesario si se utilizan versiones que respetan el
    versionado *semver* o desde un SCM
  * Los datos de una aplicación en producción (no la base de datos) pueden ser
    necesarios para realizar una prueba
* A veces, por requerimientos de seguridad o legales, la información debe
  obtenerse ofuscada
* Otras veces, alcanza con un dato antiguo que puede extraerse desde un backup
---
### Replica del ambiente de producción

* Poder obtener un ambiente similar al productivo tiene un valor muy grande para
  desarrollo dado que permite:
  * Verificar problemas offline
  * Probar nuevos releases antes de pasarlos a producción
  * Al cliente verificar en una instancia previa al pasaje a producción
    de un cambio
  * Verificar tiempos de actualización
  * etc
---
### Estadísticas y monitoreo

* Las estadísticas generalmente se utilizan por IT para conocer cómo se comporta
  un servidor o recurso
* Desde desarrollo hay varios aspectos que pueden medirse para luego ayudar a identificar
  problemas:
  * Profiling de cada middleware de una aplicación: ORM, servicios externos,
    renderizado, caching, tiempos de respuesta, etc
  * Errores en la aplicación
* Contar con la información estadística nos permite conocer el comportamiento
  normal de nuestra aplicación
  * Desconocer estos datos es manejar con el parabrisas lleno de barro
---
### Estadísticas y monitoreo
* Cuando un valor se aleja de la media o el desvío estándar por más de un tiempo
  aceptable, entonces podemos establecer una alerta
* Generalmente el monitoreo y las alertas se establecen sobre los servicios o
  sobre los recursos que son cruciales, y ante el mínimo problema se notifica a
  determinados usuarios
  * Esto produce innumerables alertas que terminan siendo ignoradas
* El monitoreo debería concentrase en lo que es de valor para el usuario que
  utiliza el recurso y no en las partes que constituyen el servicio
***
