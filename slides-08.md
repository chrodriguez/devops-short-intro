***
# DevOps
---
## Definición

<small class="fragment">
El término DevOps tiene varias interpretaciones por ser relativamente nuevo
y ciertamente amplio
<br />
**Básicamente DevOps promueve:**
</small>
<div class="fragment">
*Maximizar la colaboración entre las áreas de desarrollo e infraestructura*
</div>
---
## Objetivo

* Aplicar metodologías ágiles tanto en desarrollo como en infraestructura
* Lograr implementar flujos rápidos de trabajo planificado
* Incrementar la confiabilidad, estabilidad y seguridad de los ambientes
  productivos

---
## Orígenes

* Aproximadamente en el año 2009 ante la convergencia de diferentes movimientos:
  *  Las conferencias Velocity, en particular la presentación ["10 deploys per
  day - Dev & Ops cooperation at Flickr"](https://www.youtube.com/watch?v=LdOe18KhtT4)
  * Los movimientos de:
      * Infrastructure as code
      * Agile infrastructure
      * Agile system administration
      * [Lean Startup](http://theleanstartup.com/principles)
      * Integración y delivery continuo
---
## Orígenes
  * La global disponibilidad de tecnologías de cloud: PaaS/IasS
    * AWS EC2
    * Google Compue Engine
    * Microsoft Azure
    * Heroku
    * Digital Ocean
    * BudgetVM
    * Softlayer
    * Rackspace
---
## Caracterización

* DevOps es un movimiento , filosofía o práctica
* Que se ajusta perfectamente a las metodologías ágiles
  * Extiende y completa el proceso de integración y deployment continuo asegurando
    que el código esté listo para producción agregando valor para los clientes 
* Un nuevo rol profesional que surge de:
  * Desarrolladores que se interesan por demás en el deploy de las aplicaciones
    y operaciones de red y servicios
  * Administradores que son apasionados por escribir código moviendo su foco
    hacia desarrollo, promoviendo incluso pruebas de su infraestructura como si
    fuesen código
---
## Infraestructure as code

* IaC es el proceso por el cuál se aprovisionan máquinas físicas *(bare metal)* o
  virtuales, así como sus configuraciones
* Este aprovisionamiento se realiza a través de archivos de
  configuración que son interpretados por alguna herramienta de gestión del
  aprovisionamiento
* Estos archivos de configuración de la infraestructura se versionan en un SCM

---
## Herramientas

Existen diversos productos que promueven IaC
<table class="product_logos">
<tr>
<td> ![Chef Logo](images/chef-logo.png) </td><td> [Chef](https://www.chef.io/) </td>
</tr>
<tr>
<td> ![Puppet Logo](images/puppet-logo.png) </td><td> [Puppet Labs](https://puppet.com/) </td>
</tr>
<tr>
<td> ![Ansible Logo](images/ansible-logo.png) </td><td> [Ansible](https://www.ansible.com/) </td>
</tr>
<tr>
<td> ![Saltstack Logo](images/saltstack-logo.png) </td><td> [SaltStack](https://saltstack.com/) </td>
</tr>
</table>
---
## Test de la infraestructura
* Con las herraminetas anteriores es posible realizar tests de la
  infraestructura:
  * Tests de unidad:
      * [rspec-puppet](http://rspec-puppet.com/)
      * [ChefSpec](https://github.com/sethvargo/chefspec)
  * Tests de integración
      * [ServerSpec](http://serverspec.org/)

---
## Conceptos relacionados

* A continuación describiremos brevemente los siguientes conceptos:
  * Integración Continua
  * Delivery Continuo
  * Deployment Continuo
---
## Integración Continua

* Para comprender bien este concepto, tenemos que considerar el trabajo diario
  de un equipo de desarrolladores
* Cada desarrollador trabaja en una rama determinada en el SCM
* Si varios desarrolladores trabajan sobre una rama diferente, se ramifican las
  versiones produciéndose un problema a la hora de integrar ramas: *Merge hell*
---
## Proyecto con varias ramas

![git branches](images/branches-git.png)

<small class="fragment">
**¿Cómo es posible garantizar un merge satisfactorio en todos los casos?**
</small>
---
## Integración continua

* Promueve el frecuente merge con la rama principal
  * Tratando así de minimizar el **re-trabajo**
* Se realizan múltiples merge diarios donde cada desarrollador se compromete a
  seguir un flujo de trabajo completo donde se debe correr y pasar *todos* los
tests de **unidad e integración**
  * Esto se automatiza con herramientas de CI que *escuchan* cada commit en el
    SCM
---
## Herraminetas de CI

* [Travis](https://travis-ci.org/)
* [Semaphore](https://semaphoreci.com/)
* [Gitlab CI](https://about.gitlab.com/gitlab-ci/)
* [Jenkins](https://jenkins.io/)

---
## Delivery y deployment continuo

* Generalmente se confunden **delivery** y **deployment** continuo
  * Deployment continuo admite que cada cambio sea aplicado en producción
  * Delivery continuo permitiría que cada cambio se prepare para estar
    *disponible* para producción, pero el paso de ponerlo en producción requiere
de intervención humana

***
