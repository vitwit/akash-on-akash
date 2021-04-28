#!/bin/bash

pushd /node

export REGEN_HOME="${PWD?}"


# This fails immediately, but creates the node keys
regen init "${REGEN_MONIKER:-unknown}" --home $REGEN_HOME

set -xe

# export bech addresses on http.
#
# note: should be unnecessary. rpc/status has:
#
# - node-id in `.node_info.id`
# - validator address in `.validator_info.address`,
#   but it is in hex and `regen keys parse` is broken (again).

if test -n "$ENABLE_ID_SERVER" ; then
  mkdir web
  regen tendermint show-node-id   > web/node-id.txt
  regen tendermint show-validator > web/validator-pubkey.txt
  pushd web
  # Run a web server so that the file can be retrieved
  python3 -m http.server 8080 &
  popd
fi

curl -s "${GENESIS_URL?}" > config/genesis.json

cat config.toml | python3 -u ./patch_config_toml.py > config/config.toml

# Copy over all the other files that the node needs
cp -v app.toml config/

# Run the node for real now 
exec regen start --home $REGEN_HOME
