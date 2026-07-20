# --- Build stage: compile the source into a runnable JAR ---
# (We build from source so code fixes in PaymentController take effect, instead
#  of copying a pre-built JAR from releases/.)
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn -q -B -DskipTests package

# --- Runtime stage ---
FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-17-jdk wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/data && chmod -R 777 /app/data
COPY --from=build /build/target/paymentservicejava-*.jar /app/paymentservice.jar

WORKDIR /app
RUN wget -O dd-java-agent.jar https://dtdg.co/latest-java-tracer

# Datadog tracer (APM single-step instrumentation also injects it at runtime)
ENV DD_PROFILING_ENABLED=true
ENV DD_LOGS_INJECTION=true
ENV JAVA_OPTS=-javaagent:dd-java-agent.jar

ENTRYPOINT ["java","-jar","/app/paymentservice.jar"]
EXPOSE 9090
