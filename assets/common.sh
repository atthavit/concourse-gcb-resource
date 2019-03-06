#!/usr/bin/env bash
set -e

setup_gcloud() {
    local payload
    payload=$1
    json_key="$(jq -r '.source.json_key // ""' < "$payload")"
    project="$(jq -r '.source.project // ""' < "$payload")"

    if [ -n "$json_key" ]; then
        KEY_FILE="$(mktemp "$TMPDIR/gcb-resource-keyfile.XXXXXX")"
        echo "$json_key" > "$KEY_FILE"
        gcloud auth activate-service-account --key-file="$KEY_FILE"
    fi
    gcloud config set project "$project"
}

echodebug() {
    echo -e "\e[01;36m$*\e[0m"
}
