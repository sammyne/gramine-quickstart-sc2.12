FROM sammyne/scala:2.12.15-jdk8-ubuntu20.04 AS app

WORKDIR /gramine

ADD hello-world .

RUN sbt assembly

WORKDIR /output

RUN cp /gramine/target/scala-2.12/hello-world-assembly-1.0.jar .

FROM sammyne/gramine:86f0d3f-ubuntu20.04 AS builder

RUN apt update && apt install -y openjdk-8-jdk

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /root/gramine/Examples/hello-world

ADD gramine .

COPY --from=app /output/* .

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8

RUN make SGX=1

WORKDIR /output

RUN cp -r /root/gramine/Examples/hello-world .

WORKDIR /output/

FROM sammyne/sgx-dcap:2.14.100.2-dcap1.11.100.2-ubuntu20.04

RUN apt update && apt install -y openjdk-8-jdk libprotobuf-c-dev

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /gramine

COPY --from=builder /usr/local/bin/gramine-sgx /usr/local/bin/gramine-sgx
COPY --from=builder /usr/local/lib/x86_64-linux-gnu /usr/local/lib/x86_64-linux-gnu

COPY --from=builder /output/* ./

CMD gramine-sgx java -Xmx8G -jar hello-world-assembly-1.0.jar
