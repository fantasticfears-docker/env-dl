# NAME:     fantasticfears/dl-zsh
# VERSION:  0.6.0
FROM fantasticfears/dllib-gpu:0.5

MAINTAINER Erick Guan <fantasticfears@gmail.com>

RUN echo "Configure oh-my-zsh"
RUN curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh || true

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

RUN cd / && \
    curl -OL http://mirror.vorboss.net/apache/hadoop/common/stable/hadoop-2.9.1.tar.gz && \
    tar xvf hadoop-2.9.1.tar.gz && \
    mv hadoop-2.9.1 hadoop && \
    rm -rf hadoop-2.9.1.tar.gz

# SSH server for hadoop
RUN apt-get update && apt-get install -y openssh-server	&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/* && \
        mkdir /var/run/sshd && \
	echo 'root:screencast' | chpasswd && \
        sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
        sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
        ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
        cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
        chmod 0600 ~/.ssh/authorized_keys && \
        /etc/init.d/ssh start

# Hadoop
RUN cd /hadoop && echo "export JAVA_HOME=/usr/lib/jvm/default-java/" >> etc/hadoop/hadoop-env.sh && \
    echo "<configuration> \
    <property> \
        <name>fs.defaultFS</name> \
        <value>hdfs://localhost:9000</value> \
    </property> \
</configuration>" > etc/hadoop/core-site.xml && \
   echo "<configuration> \
    <property> \
        <name>dfs.replication</name> \
        <value>1</value> \
    </property> \
</configuration>" > etc/hadoop/hdfs-site.xml && \
    bin/hdfs namenode -format
ARG HDFS_NAMENODE_USER="root"
ARG HDFS_DATANODE_USER="root"
ARG HDFS_SECONDARYNAMENODE_USER="root"
ARG YARN_RESOURCEMANAGER_USER="root"
ARG YARN_NODEMANAGER_USER="root"
RUN cd /hadoop && sbin/start-dfs.sh && \
    bin/hdfs dfs -mkdir /user && \
    bin/hdfs dfs -mkdir /user/erickg

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/
RUN chmod +x /root/run_jupyter.sh
RUN echo `date +%Y%m%d` > /BUILD_DATE

# Expose Ports for TensorBoard (6006), Ipython (8888), Hadoop (9870)
EXPOSE 6006 8888 9870

WORKDIR "/root"
CMD ["/sbin/init"]
