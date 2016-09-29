***
# Necesidad de ambientes independientes
---
## Introducción

* No disponer de ambientes implicaría:
  * Tener código versionado o no
  * La única versión que es igual a producción, es la de producción
      * Porque alguien cambió algo en producción que no funcionaba
      * Porque luego de cambiar algo en producción, no se actualizó el código
        versionado
  * Las pruebas se realizan en la pc del desarrollador o directamente en
    producción

<small class="fragment">
Pareciera ser imposible que esto suceda, pero muchas organizaciones siguen
gestionando sus desarrollos de esta forma
</small>
---
## Ambientes

* Es común ver alguno de estos ambientes en una organización:
  * **Desarrollo:** el ambiente de desarrollo es en el cuál los desarrolladores
    construyen el software
  * **Testing:** es el ambiente donde se publica el software en fase de pruebas
    para que sea probado por un grupo definido de personas, entre las que
    se incluye el usuario final o representantes del mismo
---
## Ambientes
  * **Pre-producción:** es la instancia previa a producción, y consiste en un
    ambiente replicado e idéntico al productivo. En este entorno se verifica
    el correcto funcionamiento de la aplicación y se realizan los ajustes necesarios
    en caso de no ser así, evitando que los problemas se descubran en el pasaje
    a producción
  * **Producción:** es el ambiente que tiene todos los servicios productivos.
    Este ambiente cuenta con políticas estrictas en cuanto al acceso y la
    administración del mismo.
***
