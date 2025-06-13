FROM rust:1.86-bullseye AS player-builder
COPY pty-replay-web /pty-replay-web
WORKDIR /pty-replay-web
ENV SQLX_OFFLINE=true
RUN cargo build --release

FROM archlinux:base-20250608.0.361578 AS base
COPY --from=player-builder /pty-replay-web/target/release/pty-replay-web /pty-replay-web
COPY --from=player-builder /pty-replay-web/static /static
ENV STATIC_DIR=/static
ENTRYPOINT ["/pty-replay-web"]
