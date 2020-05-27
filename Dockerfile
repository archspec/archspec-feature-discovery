FROM registry.access.redhat.com/ubi8/go-toolset AS builder
WORKDIR /go/src/github.com/ArangoGutierrez/spack-feature-discovery
COPY . .

# build spack-feature-discovery
RUN go build -o spack-feature-discovery cmd/sfd/main.go

# Create production image for running the side car container
FROM registry.access.redhat.com/ubi8/ubi
COPY --from=builder /go/src/github.com/ArangoGutierrez/spack-feature-discovery/spack-feature-discovery /usr/bin/spack-feature-discovery

# Install Spack
RUN dnf install git -y
RUN cd / && git clone https://github.com/spack/spack && cd spack && \
    git checkout releases/v0.14 && \
    . share/spack/setup-env.sh

ENTRYPOINT ["/usr/bin/spack-feature-discovery"]
