#!/usr/bin/env bash
docker run \
  --env-file env/definet \
  --publish-all \
  --name sentinel-on-akash \
  --rm \
  sentinel-on-akash:latest
