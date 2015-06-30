# Creates distributed cdh5
#
# docker build -t supermy/cloud-hregionserver:cdh5 .

FROM supermy/cloud-hbase:cdh5
MAINTAINER james mo <springclick@gmail.com>

# config hbase
ADD hbase-env.sh /etc/hbase/conf/hbase-env.sh
ADD hbase-site.xml.template /etc/hbase/conf/hbase-site.xml.template

ADD regionservers /etc/hbase/conf/regionservers

#hive-hbase-init
ADD pre-start-hive.sh /home/jamesmo/pre-start-hive.sh
ADD start-hive.sh /home/supermy/start-hive.sh
ADD hbase-init.rb /home/supermy/hbase-init.rb

ADD hive-init.sql /home/supermy/hive-init.sql
#ADD hbase-init.sql /home/supermy/hbase-init.sql

RUN chmod a+x /home/supermy/start-hive.sh
RUN chmod a+xr /home/supermy/hbase-init.rb
RUN chmod a+x /home/supermy/pre-start-hive.sh

#COPY gndata /home/supermy/

#hive-end

# config hadoop client
ADD core-site.xml.template /etc/hadoop/conf/core-site.xml.template
ADD hadoop-env.sh /etc/hadoop/conf/hadoop-env.sh

# supervisord
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# start hbase
ADD pre-start-hbase.sh /home/supermy/pre-start-hbase.sh
RUN chmod a+x /home/supermy/pre-start-hbase.sh

ENTRYPOINT /home/supermy/pre-start-hbase.sh && /home/supermy/pre-start-hive.sh

EXPOSE 60020 60030
