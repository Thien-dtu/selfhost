FROM ghcr.io/immich-app/postgres:14-vectorchord0.3.0-pgvectors0.2.0@sha256:fa4f6e0971f454cd95fec5a9aaed2ed93d8f46725cc6bc61e0698e97dba96da1

USER root
RUN chown 1000:1000 /usr/lib/postgresql/14/lib/vectors.so && \
    chmod 644 /usr/lib/postgresql/14/lib/vectors.so
USER 1000:1000