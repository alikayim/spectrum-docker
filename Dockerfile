FROM stefanlehmann/centos-jenkins-docker-slave

USER root

ARG MAVEN_VERSION=3.5.4

ARG GRADLE_VERSION=4.2.1

ARG NODEJS_VERSION=v8.9.4

ARG YARN_VERSION=v1.3.2

ARG RUBY_VERSION=2.4.4

ENV BASH_ENV=/usr/local/bin/scl_enable ENV=/usr/local/bin/scl_enable PROMPT_COMMAND=". /usr/local/bin/scl_enable" PATH=$PATH:/opt/gradle/bin:/opt/maven/bin

RUN yum install -y install gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel sqlite-devel gnupg gpg2 --setopt=protected_multilib=false

RUN INSTALL_PKGS="java-1.8.0-openjdk-devel.x86_64" && x86_EXTRA_RPMS=$(if [ "$(uname -m)" == "x86_64" ]; then echo -n java-1.8.0-openjdk-devel.i686 ; fi) && yum install -y centos-release-scl-rh && yum install -y --enablerepo=centosplus $INSTALL_PKGS $x86_EXTRA_RPMS --setopt=protected_multilib=false && yum install -y openssl && yum install -y firefox && yum install -y xorg-x11-server-Xvfb && rpm -V ${INSTALL_PKGS//\*/} ${x86_EXTRA_RPMS//\*/} && yum clean all -y && curl -LOk https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && unzip gradle-${GRADLE_VERSION}-bin.zip -d /opt && rm -f gradle-${GRADLE_VERSION}-bin.zip && ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle && curl -LOk http://ftp.itu.edu.tr/Mirror/Apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip && unzip apache-maven-${MAVEN_VERSION}-bin.zip -d /opt && rm -f apache-maven-${MAVEN_VERSION}-bin.zip && ln -s apache-maven-${MAVEN_VERSION} /opt/maven && mkdir -p $HOME/.m2 && mkdir -p $HOME/.gradle  && yum install -y java-11-openjdk-devel && java -version

RUN curl -LOk https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

RUN yum install -y ./google-chrome-stable_current_*.rpm

 
COPY xvfb /etc/init.d/xvfb
RUN chmod 755 /etc/init.d/xvfb 
