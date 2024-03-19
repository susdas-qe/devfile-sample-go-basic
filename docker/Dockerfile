FROM registry.access.redhat.com/ubi9/go-toolset:latest

COPY . .
RUN go mod download
RUN git config --global --add safe.directory /opt/app-root/src
RUN go build -buildvcs=false -o ./main

FROM registry.access.redhat.com/ubi9/ubi-micro:latest

COPY --from=builder /opt/app-root/src/main . 

ENV PORT 8081
EXPOSE 8081

CMD [ "./main" ]
