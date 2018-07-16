FROM jenkins/jenkins:lts

USER root

RUN apk -U add docker
# Setup Jenkins

RUN apk add --update shadow \
    && groupadd -g 50 staff \
    && usermod -a -G staff jenkins
USER jenkins
RUN /usr/local/bin/install-plugins.sh \
blueocean \
docker-plugin \
docker-slaves \

COPY resources/basic-security.groovy /usr/share/jenkins/ref/init.groovy.d/basic-security.groovy
COPY resources/maven-global-settings-files.xml /usr/share/jenkins/ref/maven-global-settings-files.xml
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
USER root
