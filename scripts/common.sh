#!/bin/bash

#java
JAVA_VERSION="8"
JAVA_UPDATE="91"
JAVA_ARCHIVE="jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz"
JAVA_HOME="jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}"

#hadoop
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_CONF=$HADOOP_PREFIX/etc/hadoop
HADOOP_VERSION=2.6.0
HADOOP_ARCHIVE=hadoop-${HADOOP_VERSION}.tar.gz
HADOOP_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/${HADOOP_ARCHIVE}
HADOOP_RES_DIR=/vagrant/resources/hadoop

#ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config

function resourceExists {
	FILE=/vagrant/resources/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

#echo "common loaded"