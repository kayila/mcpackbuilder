FROM alpine/git:latest AS builder

# Where the git repo is located
ENV LAUNCHER_REPO https://github.com/kayila/Launcher.git
ENV LAUNCHER_BRANCH master

# Install openjdk
RUN apk add --no-cache bash openjdk8

# Make build dir
RUN mkdir -p /tmp/build

# Clone the repo
RUN git clone --depth 1 -b $LAUNCHER_BRANCH $LAUNCHER_REPO /tmp/build/launcher

WORKDIR /tmp/build/launcher

RUN ./gradlew clean build

FROM alpine:latest

RUN apk add --no-cache openjdk8-jre sed git openssh-client

RUN mkdir -p /launcher-tools /output /input

WORKDIR /input

COPY --from=builder /tmp/build/launcher/launcher-builder/build/libs/launcher-builder-*-all.jar /launcher-tools/launcher-builder.jar

# ENTRYPOINT [ "/usr/bin/java", "-jar", "/launcher-tools/launcher-builder.jar" ]
# 
# CMD [ "--version", "latest", "--input", "/input", "--output", "/output", "--manifest-dest", "/output/your_modpack.json" ]
