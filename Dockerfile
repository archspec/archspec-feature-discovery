FROM registry.access.redhat.com/ubi8/go-toolset AS builder
WORKDIR /go/src/github.com/ArangoGutierrez/spack-feature-discovery
COPY . .

# build spack-feature-discovery
RUN go install github.com/ArangoGutierrez/spack-feature-discovery

# Create production image for running the side car container
FROM registry.access.redhat.com/ubi8/ubi

COPY --from=builder /go/bin/spack-feature-discovery /usr/bin/spack-feature-discovery

# Install Spack
RUN git clone git@github.com:spack/spack.git && cd spack && \
    git checkout releases/v0.14.2 && \
    . share/spack/setup-env.sh

ENTRYPOINT ["/usr/bin/spack-feature-discovery"]