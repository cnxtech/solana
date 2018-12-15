#!/usr/bin/env bash
#
# This script is used to upload the full buildkite pipeline. The steps defined
# in the buildkite UI should simply be:
#
#   steps:
#    - command: "ci/buildkite-pipeline-upload.sh"
#

set -e
cd "$(dirname "$0")"/..

buildkite-agent pipeline upload ci/buildkite.yml

if [[ $BUILDKITE_BRANCH =~ ^pull ]]; then
  # Add helpful link back to the corresponding Github Pull Request
  buildkite-agent annotate --style "info" \
    "Github Pull Request: https://github.com/solana-labs/solana/$BUILDKITE_BRANCH"
fi
