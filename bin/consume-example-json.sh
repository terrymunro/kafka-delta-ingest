#!/bin/bash

export AWS_ENDPOINT_URL=http://127.0.0.1:4566
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test

RUST_LOG=debug cargo run --features s3 ingest web_requests ./tests/data/web_requests \
  --allowed_latency ${1:-60} \
  --app_id web_requests \
  --transform 'date: substr(meta.producer.timestamp, `0`, `10`)' \
  --transform 'meta.kafka.offset: kafka.offset' \
  --transform 'meta.kafka.partition: kafka.partition' \
  --transform 'meta.kafka.topic: kafka.topic' \
  --auto_offset_reset earliest

