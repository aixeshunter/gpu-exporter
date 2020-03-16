FROM quay.io/prometheus/golang-builder as builder

RUN go get -v -u github.com/prometheus/promu
ADD . /go/src/github.com/aixeshunter/gpu-exporter
WORKDIR /go/src/github.com/aixeshunter/gpu-exporter
RUN /go/bin/promu build -v

FROM debian:stable

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=utility

COPY --from=builder /go/src/github.com/aixeshunter/gpu-exporter/gpu-exporter /bin/gpu-exporter

EXPOSE      9470
USER        nobody
ENTRYPOINT  [ "/bin/gpu-exporter" ]
