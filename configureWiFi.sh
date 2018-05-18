#!/bin/bash

#exit when a command fails
set -e

#exit when your script tries to use undeclared variables
set -u

#The exit status of the last command that threw a non-zero exit code is returned
set -o pipefail

#trace what gets executed
set -x

#if [[ $EUID -ne 0 ]]; then
#   echo "This script must be run as root" 1>&2
#   exit 1
#fi


# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app


#copio la UI personalizada
cp -v ${__dir}/ui/favicon.png /usr/local/share/wifi-connect/ui/img/ && \
	cp -v ${__dir}/ui/logo.svg /usr/local/share/wifi-connect/ui/img/ && \
	cp -v ${__dir}/ui/index.html /usr/local/share/wifi-connect/ui/ && \
#copio el systemd service y lo habilito 
  	cp -v ${__dir}/files/wifi-connect.service /etc/systemd/system/wifi-connect.service && \
  	systemctl enable wifi-connect && \
#copio el comando que consume el servicio y le pongo permiso de execute
  	cp -rv ${__dir}/files/start-wifi-connect /usr/local/bin/start-wifi-connect && \
  	chmod +x /usr/local/bin/start-wifi-connect