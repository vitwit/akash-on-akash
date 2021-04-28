#!/usr/bin/env bash
docker run \
  --env-file env/definet \
  --publish-all \
  --name regen-on-akash \
  --rm \
  regen-on-akash:latest
