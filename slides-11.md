***
# Desde la perspectiva de infraestructura
---
## Desde la perspectiva de infraestructura

* Se intenta capturar una configuración funcional que permita:
  * Replicar un ambiente
  * Recuperación ante desastres
* Surge la posibilidad de versionar la infraestructura
  * Esto implica poder repetir la instalación de un server
* Surgen nuevas necesidades:
  * Orden en cuanto al inicio de servicios
  * Cambios de plataformas de virtualización por costos o funcionalidad
---
## Herramientas

* Gestión de las configuraciones usando Chef
* Gestión de la infraestrcutura usando chef-provisioning
* Docker en producción con Rancher
---
![Chef Logo](images/chef-white-logo.png)
---
## Chef

* Chef permite modelar la evolución de nuestra infraestructura y aplicaciones como
  si fueran código
* No impone restricciones
* Permite describir y automatizar los procesos e infraestructura
* La consecuencia es que la infraestructura se vuelve:
  * Versionable
  * Testeable
  * Replicable
  * Idempotente
---
## Conceptos de chef

* Para lograr su objetivo se utilizan definiciones reutilizables llamadas
  **cookbooks** y **recipes**
* Se programa en Ruby usando una DSL
---
## Arquitectura
<img alt="Chef architecture" src="images/chef-architecture.png" height="500" />
---
## Entidades de chef

* Roles
* Nodos
  * Atributos
* Data Bags

Además, es posible realizar búsquedas sobre estas entidades
---
## Ejemplo de una receta

```ruby
package 'nginx'

service 'nginx' do
  action [:enable, :start]
end

template '/etc/nginx/sites-enabled/www.conf' do
  source 'nginx-default.conf.erb'
  variables(
    server_name: 'www.mikroways.net',
    document_root: '/var/www'
  )
  notifies :restart, 'service[nginx]', :immediately
end
```
<small class="fragment">
[Ver ejemplo completo](images/samples/04-chef/recipes/default.rb)
<br />
*Es posible probar las recetas con una versión de chef llamada
chef-zero/chef-solo*
</small>
---
## TDD
* Ejemplo de [test de unidad](images/samples/04-chef/spec/unit/recipes/web-server-test_spec.rb)
  * Basados en [ChefSpec](https://github.com/sethvargo/chefspec)
  * `rspec`
  * `rubocop`
  * `foodcritic`
* Ejemplo de [test de
  integración](images/samples/04-chef/test/integration/default/serverspec/integration-web-server_spec.rb)
  * Basados en [Test Kitchen](http://kitchen.ci/)
  * Probamos un test implementado con [ServerSpec](http://serverspec.org/) en
    plataformas Debian 7 y Ubuntu 14.04
  * `kitchen`
---

## Desplegando el potencial de chef

* Bootstrap de nodos
  * Usaremos knife-ec2
* Búsquedas
* Ambientes
* ssh en paralelo
* Búsquedas en recetas
  * _Ejemplo con ha-proxy_

---
## Bootstrap de nodos

* Usaremos Amazon EC2 y un plugin de chef que simplifica y unifica las tareas de
crear y bootstrapear un nodo 
* Crearemos antes un rol que describe un web server. Esto nos permitirá realizar
  búsquedas

```bash
# Crea/actualiza el rol web-server
knife role from file roles/web-server.rb
# Crea dos nodos llamados web-01 y web-02 en amazon con el rol
# web-server
knife ec2 server create -I ami-b1a652d1 -f m1.small --ssh-user ubuntu \
  -N web-01 -r 'role[web-server]'
knife ec2 server create -I ami-b1a652d1 -f m1.small --ssh-user ubuntu \
  -N web-02 -r 'role[web-server]'
## Listamos las instancias de Amazon EC2
knife ec2 server list
```

<small>
*__Algunos detalles que se omiten se toman de la configuración de knife__*
</small>

---
## Un poco de knife

```bash
knife status
knife role list
knife node list
knife search '*:*'
knife search 'platform:ubuntu AND (name:web-01 OR role:web-server)'
knife ssh -x ubuntu 'role:web-server' sudo service nginx stop
knife exec -E 'search(:node, "role:web-server").each do |node| 
  puts(
    node.name => {
      ip: node.cloud.public_ipv4,
      mem: node.memory.total,
      cpu: node.cpu.total
    }
  )
end'
```

<small>
*__Lo interesante es que uno puede usar búsquedas en las recetas__*
</small>

---
## Creamos un proxy reverso

<small>
*__Esta receta utiliza búsquedas para configurar los backends de haproxy__*
</small>

```ruby
all_web_servers = search(:node, "role:web-server")
members = []
all_web_servers.each do |web|
  members <<
  {
    "hostname"  => web['cloud']['public_hostname'],
    "ipaddress" => web['cloud']['public_ipv4'],
    "port"      => 80,
    "ssl_port"  => 80
  }
end
node.default['haproxy']['members'] = members

include_recipe 'haproxy'

```

```bash
knife ec2 server create -I ami-b1a652d1 -f m1.small --ssh-user ubuntu \
  -N proxy -r 'recipe[myhaproxy]'
```

<small>
Probar con **curl** y eliminar con
<br />
`knife ec2 server delete <INSTANCE-ID> -P`
</small>

---
## Chef no es el único

* Y... ¿por qué chef?
* Hoy día Ansible es la alternativa más elegida
* Puppet es la principal competencia

***
***
# chef-provisioning
---
## Introducción
* Chef provisioning extiende chef permitiendo crear VMs en diferentes plataformas
de virtualización
  * Vagrant
  * AWS
  * Azure
  * DigitalOcean
  * VMWare
  * XenServer
  * Google Compute Engine
  * IBM SoftLayer
  * Y varios más
---
## ¿Qué es entonces?
* Permite configurar nuestro cluster de máquinas de forma agnóstica de la
  plataforma
* Evita el uso reiterativo de knife para iniciar VMs 
---
## Ejemplo

```ruby
chef_role 'web-server' do
  run_list ["recipe[apt]","recipe[web-server]"]
end

machine_batch do
  machine 'web-01' do
    run_list ['role[web-server]']
  end
  machine 'web-02' do
    run_list ['role[web-server]']
  end
end

machine 'proxy' do
  run_list ['recipe[myhaproxy]']
end

```

*__Corremos en nuestra PC__*

```bash
chef-client -z -r 'my-infra::chef,my-infra::aws,my-infra'
```
---
## Eliminando todo
```ruby
chef_role 'web-server' do
  action :delete
end

machine_batch do
  action :destroy
  machines 'web-01', 'web-02', 'proxy'
end
```

*__Corremos en nuestra PC__*

```bash
chef-client -z -r 'my-infra::chef,my-infra::aws,my-infra::delete'
```

---
## Y ahora con Vagrant

```bash

chef-client -z -r 'my-infra::chef,my-infra::vagrant,my-infra'

```

Esto es muy importante, porque sólo cambiando el driver de aprovisionamiento,
podemos reusar nuestra infraestructura definida

<small class="fragment">
Podemos incluso tener un cluster con VMs de diferentes proveedores
</small>


---
## Terraform

<a href="https://www.terraform.io/">
<img alt="Terraform logo" src="images/terraform-logo.png" height="300px" />
</a>

*__La alternativa a chef-provisioning__*

***
***
# Clusters de contenedores

<img src="images/docker-cluster.png" height="350"/>
---
## Alternativas en boga

* [Docker Swarm](https://docs.docker.com/swarm/)
* [Rancher Cattle](http://rancher.com/)
* [Kubernetes](http://kubernetes.io/)
* [Mesos](http://mesos.apache.org/)
---
## Además se habla mucho de

* [Rancher OS](http://rancher.com/rancher-os/)
* [CoreOS](https://coreos.com/)
* [Boot2docker](http://boot2docker.io/)

---
## Características

* Schedulling de contenedores
  * Importancia de los labels en docker
* Service discovery
  * Zookeper
  * Consul
  * Etcd
* Complicaciones:
  * Volúmenes compartidos
  * Monitoreo y Logs
---
# Rancher
---
## Rancher

* Permite configurar ambientes
  * Con Cattle, Swarm, Kubernetes y ahora Mesos
* Los ambientes se componen de nodos
* Los contenedores se manejan con stacks
  * Usan docker-compose v1
  * Provee un catálogo de aplicaciones
  * Permite extender el catálogo con uno propio
* Simplifica la integración con registries privadas
* Proxy reverso basado en service discovery
* Simple escalamiento de contenedores

---
## Ejemplo

* Deployamos un wordpress desde el catálogo
  * Fijamos que sólo corra la db en un nodo determinado
* Escalamos el servicio

---
## Otro ejemplo

* Creamos una aplicacion propia
  * El nombre del directorio es importante: nombre del stack
  * Creamos
    [`docker-compose.yml`](images/samples/07-rancher/my-custom-app/docker-compose.yml)
  * Iniciamos el stack: `rancher-compose up`
  * *Verificamos*
  * Upgradeamos: `rancher-compose up -u my-app`
  * *Verificamos*
  * Realizamos un rollback

***
