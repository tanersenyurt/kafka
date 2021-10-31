FROM openjdk:11-jre-slim
RUN useradd -ms /bin/sh appuser
WORKDIR /home/appuser
COPY kafka /home/appuser/kafka/
RUN chmod +x /home/appuser/kafka/bin/*.sh
ADD ./startup.sh startup.sh
RUN chmod +x /home/appuser/startup.sh
RUN chown -R appuser:appuser *
USER appuser


ENV KAFKA_HEAP_OPTS="-Duser.timezone=\"Europe/Istanbul\" -Xms256M -Xmx2G -Xverify:none -XX:+PrintFlagsFinal -XX:+UnlockDiagnosticVMOptions -XX:+UnlockExperimentalVMOptions -XX:MinRAMPercentage=50.0 -XX:MaxRAMPercentage=90.0 -XX:ActiveProcessorCount=4 -XX:-OmitStackTraceInFastThrow"
#ENV KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:/home/appuser/log-config/log4j.properties"
WORKDIR /home/appuser
EXPOSE 9092
ENTRYPOINT ["/home/appuser/startup.sh"]
