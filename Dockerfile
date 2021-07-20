# Indicamos la imagen a utilizar si se pone solo el nombre sin indicar version, descarga la ultima disponible
FROM ubuntu

# Info acerca de la imagen
LABEL administrator="Diego Del Grippo"
LABEL version="5.0"
LABEL description="Tp DockerFile"

# Pasamos el argumento no interactivo
ARG DEBIAN_FRONTEND=noninteractive

# instalación de paquetes
RUN apt update && apt install -y wget vim apache2 mysql-server php libapache2-mod-php php-mysql && apt clean && apt autoremove

# Variables de entorno
ENV MYSQL_ROOT_PASSWORD 12345
ENV MSYQL_DB_NAME default
ENV APACHE_SERVER_NAME default

# Puntos de montaje
VOLUME ["/var/www/html"]

# Directorio 'app'
RUN mkdir -p /app

# Copiar archivos al directorio 'app'
COPY index.html /app

# Copiar default vhost al contenedor
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Copiar script de inicio al directorio raiz y dar permisos de ejecución
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Exponer puertos
EXPOSE 80

# Comando a ejecutarse cuando se crea el contenedor
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apachectl", "-D", "FOREGROUND"]
