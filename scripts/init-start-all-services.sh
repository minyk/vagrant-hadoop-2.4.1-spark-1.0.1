#!/bin/bash
source "/vagrant/scripts/common.sh"

function formatNameNode {
	$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format myhadoop -force -noninteractive
	echo "formatted namenode"
}

function startHDFS {
	$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR --daemon start namenode
	$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR --hosts $HADOOP_CONF_DIF/workers --workers --daemon start datanode
	echo "started hdfs"
}

function startYarn {
	ssh node2 '$HADOOP_YARN_HOME/bin/yarn --config $HADOOP_CONF_DIR --daemon start resourcemanager'
	ssh node2 '$HADOOP_YARN_HOME/bin/yarn --config $HADOOP_CONF_DIR --hosts $HADOOP_CONF_DIR/workers --workers --daemon start nodemanager'
	ssh node2 '$HADOOP_YARN_HOME/bin/yarn --config $HADOOP_CONF_DIR --daemon start proxyserver'
	ssh node2 '$HADOOP_YARN_HOME/bin/yarn --config $HADOOP_CONF_DIR --daemon start timelineserver'
	ssh node2 '$HADOOP_HOME/bin/mapred --config $HADOOP_CONF_DIR --daemon start historyserver'
	echo "started yarn"
}

formatNameNode
startHDFS
startYarn