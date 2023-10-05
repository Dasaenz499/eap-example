#Dockerfile for EAP 6.4

FROM ubi7/ubi:7.7

MAINTAINER Antonio Royo aroyo@redhat.com

ENV JBOSS_HOME /opt/rh/jboss-eap-7.3

#####comandos previos Actualizaciones

RUN yum -y update && \
yum -y install sudo openssh-clients telnet unzip java-1.8.0-openjdk-devel && \
yum clean all

RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
sed -i 's/.*requiretty$/Defaults !requiretty/' /etc/sudoers

# add a user for the application, with sudo permissions
RUN useradd -m jboss ; echo jboss: | chpasswd ; usermod -a -G wheel jboss

##########manejar el archivo .zip

# create workdir
RUN mkdir -p /opt/rh

WORKDIR /opt/rh

ADD jboss-eap-7.3.0.zip /opt/rh/

RUN unzip jboss-eap-7.3.0.zip

#Crear un usuario Jboss

RUN $JBOSS_HOME/bin/add-user.sh admin admin@2021 --silent

#Agregar Java Web Application en la carpeta de despliegues de Jboss

#ADD SampleWebApp.war /opt/rh/jboss-eap-7.3/standalone/deployments

#ADD jboss-helloworld-rs.war /opt/rh/jboss-eap-7.3/standalone/deployments
ADD helloworld-html5.war /opt/rh/jboss-eap-7.3/standalone/deployments

# set permission folder
RUN chown -R jboss:jboss /opt/rh

#Exponer puertos
EXPOSE 8080 9990 9999


ENTRYPOINT ["/opt/rh/jboss-eap-7.3/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

USER jboss
#CMD /bin/bash
