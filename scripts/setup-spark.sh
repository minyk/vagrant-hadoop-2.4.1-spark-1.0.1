#!/bin/bash
source "/vagrant/scripts/common.sh"

function installLocalSpark {
	echo "install spark from local file"
	FILE=/vagrant/resources/$SPARK_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteSpark {
	echo "install spark from remote file"
	curl -o /vagrant/resources/$SPARK_ARCHIVE -O -L $SPARK_MIRROR_DOWNLOAD
	tar -xzf /vagrant/resources/$SPARK_ARCHIVE -C /usr/local
}

function setupSpark {
	echo "setup spark"
	cp -f /vagrant/resources/spark/slaves /usr/local/spark/conf
	cp -f /vagrant/resources/spark/spark-env.sh /usr/local/spark/conf
	cp -f /vagrant/resources/spark/spark-defaults.conf /usr/local/spark/conf
	cp -f /vagrant/resources/spark/log4j.properties /usr/local/spark/conf
	cp -f /vagrant/resources/spark/metrics.properties /usr/local/spark/conf
	cp -f /vagrant/resources/spark/fairscheduler.xml /usr/local/spark/conf
}

function setupEnvVars {
	echo "creating spark environment variables"
	cp -f $SPARK_RES_DIR/spark.sh /etc/profile.d/spark.sh
}

function installSpark {
	if resourceExists ${SPARK_ARCHIVE}; then
		installLocalSpark
	else
		installRemoteSpark
	fi
	ln -s /usr/local/spark-${SPARK_VERSION}-bin-hadoop2.6 /usr/local/spark
}

echo "setup spark"

installSpark
setupSpark
setupEnvVars