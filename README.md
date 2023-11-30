# Despliegue Automatizado de WordPress con Vagrant y Puppet

Este repositorio contiene la implementación de un sistema automatizado para el despliegue de WordPress utilizando Vagrant y Puppet. Este enfoque permite una configuración coherente y fácilmente replicable de la infraestructura necesaria para ejecutar WordPress.

## Configuración del Proyecto

### Requisitos Previos

Asegúrate de tener instalados los siguientes elementos en tu máquina antes de comenzar:

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)

### Instrucciones de Uso

1. Clona este repositorio en tu máquina local:

    ```bash
    git clone https://github.com/tu-usuario/despliegue-wordpress-vagrant-puppet.git
    ```

2. Ingresa al directorio del proyecto:

    ```bash
    cd despliegue-wordpress-vagrant-puppet
    ```

3. Inicia la máquina virtual con Vagrant:

    ```bash
    vagrant up
    ```

4. Accede a WordPress desde tu navegador:

    [http://localhost:8080](http://localhost:8080)

5. Sigue las instrucciones para completar la instalación de WordPress.

## Estructura del Proyecto

- `Vagrantfile`: Configuración principal para la máquina virtual con Vagrant.
- `manifests/init.pp`: Archivo de configuración principal de Puppet.
- `var/www/html/`: Directorio donde se instala WordPress.

## Personalización

- Puedes ajustar la configuración de la máquina virtual en el archivo `Vagrantfile`.
- Las configuraciones específicas de Puppet se encuentran en el archivo `manifests/init.pp`.

## Contribuciones

Si encuentras errores o tienes mejoras sugeridas, siéntete libre de abrir un issue o enviar un pull request.
