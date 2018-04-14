#!/bin/bash
docker build . -t mcpackbuilder
docker run --rm -v $(pwd)/input:/input -v $(pwd)/output:/output mcpackbuilder /usr/bin/java -jar "/launcher-tools/launcher-builder.jar" --version "${VERSION}" --input "/input" --output "/output" --manifest-dest "/output/${MANIFEST_DEST}"
