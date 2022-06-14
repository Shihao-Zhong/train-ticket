FROM java:8-jre

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

ADD ./target/ts-cancel-service-1.0.jar /app/
#CMD ["java", "-Xmx200m",  "-jar", "/app/ts-cancel-service-1.0.jar"]

COPY ./target/otel.jar /app/otel.jar
COPY ./target/vaif.json /app/vaif.json
COPY ./target/enable.json /app/enable.json

CMD java -Dotel.traces.exporter=jaeger \
         -Dotel.exporter.jaeger.endpoint=http://jaeger:14250 \
         -Dotel.metrics.exporter=none \
         -Dotel.resource.attributes="service.name=ts-cancel-service" \
         -Dotel.instrumentation.vaif.config.path="/app/enable.json" \
         -Dotel.instrumentation.vaif.context_prop_config.path="/app/vaif.json" \
		 -Dapplication.name=ts-cancel-service \
		 -javaagent:/app/otel.jar \
         -Xmx200m \
		 -jar \
		 /app/ts-cancel-service-1.0.jar


EXPOSE 18885