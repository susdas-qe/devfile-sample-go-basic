FROM registry.access.redhat.com/ubi9/go-toolset:latest As builder
COPY . .
RUN  git config --global --add safe.directory /opt/app-root/src
RUN  go mod download
RUN  go build -buildvcs=false -o ./main
RUN  make prepare_release

FROM registry.access.redhat.com/ubi9/ubi-micro:latest

ENV PORT 8081
EXPOSE 8081

LABEL description="Terraform Provider RHCS"
LABEL io.k8s.description="Terraform Provider RHCS"
LABEL com.redhat.component="terraform-provider-rhcs"
LABEL distribution-scope="release"
LABEL name="terraform-provider-rhcs" release="2.1" url="https://github.com/jinqi7/terraform-provider-rhcs"
LABEL vendor="Red Hat, Inc."
LABEL version="2.1"

COPY --from=builder /opt/app-root/src/releases /releases
CMD [ "./main" ]
