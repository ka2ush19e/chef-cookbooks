sudo service hadoop-0.20-mapreduce-tasktracker stop
sudo service hadoop-0.20-mapreduce-jobtracker stop
sudo service hadoop-hdfs-datanode stop
sudo service hadoop-hdfs-namenode stop

sudo service hadoop-hdfs-namenode start
sudo service hadoop-hdfs-datanode start
sudo service hadoop-0.20-mapreduce-jobtracker start
sudo service hadoop-0.20-mapreduce-tasktracker start
