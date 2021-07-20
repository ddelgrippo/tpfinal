TP Final

Se decide crear una web con Apache todo bajo Docker y haciendo Deploy en Kubernetes en un laboratorio en VirtualBox local.

Repositorio GitHub:


https://github.com/ddelgrippo/tpfinal.git 


Entorno
El siguiente tutorial está diseñado para realizarse en:
- Arquitectura: Virtual Box VM 64 bits
- OS: Ubuntu mini básico de 64 bits
- Red: Adaptador de red en modo bridge (ver configuración de vm en virutal box)

Se utilizarán dos VM

Docker: Ubuntu Mini + Docker + SSH
Kubernetes: Ubuntu Mini + Microk8s + SSH


Imagen Docker
Nos logueamos en la VM Docker para crear la imagen con la web Apache. Descargamos de GitHub los archivos necesarios para realizar esta tarea.

- 000-default.con
- Dockerfile
- entrypoint.sh
- index.html

Build image
Construir la imagen con el nombre “apache-web”. 

          $ sudo docker build -t apache-web .


Export image
Exportamos al directorio “tmp” la imagen en un fichero tar.

          $ docker save apache-web > /tmp/apache-web.tar


Copy Image
Copiar el fichero tar al directorio de usuario home en la VM Kubernetes.

          $ scp /tmp/apache-web.tar xxx@xxx.xxx.xxx.xxx:/“directorio”


Kubernetes deployment
Nos logueamos en la VM Kubernetes para hacer un deploy

Import image
Importar la imagen “apache-web.tar”

          $ sudo microk8s ctr image import apache-web.tar 


Deploy app
Utilizamos el archivo .yaml que está en el repositorio github. 

- apache-web.yaml


            $ sudo microk8s kubectl apply -f apache-web.yaml


Redireccionar puertos hacia uno de los pods para acceso externo

$ sudo microk8s kubectl port-forward apache-web-xxxxxx 8080:80 --address 0.0.0.0


La app estará disponible mediante navegador web por la url 

http://xxx.xxx.xxx.xxx:8080/

