FROM registry.access.redhat.com/ubi8/go-toolset AS builder
WORKDIR /go/src/github.com/ArangoGutierrez/spack-feature-discovery
COPY . .

# build archspec-feature-discovery
RUN go build -o archspec-feature-discovery cmd/sfd/main.go

# Create production image for running the side car container
FROM registry.access.redhat.com/ubi8/ubi 
COPY --from=builder /go/src/github.com/ArangoGutierrez/spack-feature-discovery/archspec-feature-discovery /usr/bin/archspec-feature-discovery

# Install Spack
RUN dnf update -y && dnf install git python38 python3-pip -y
RUN pip3 install --no-cache-dir archspec
RUN dnf clean all

RUN useradd afd-side-car
USER afd-side-car
ENTRYPOINT ["/usr/bin/archspec-feature-discovery"]
