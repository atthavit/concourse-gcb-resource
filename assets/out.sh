#!/usr/bin/env bash
set -e

build_substitutions() {
    local payload
    payload=$1
    source_subs="$(jq -r '.source.substitutions // ""' < "$payload")"
    params_subs="$(jq -r '.params.substitutions // ""' < "$payload")"
    if [[ -n "$source_subs" || -n "$params_subs" ]]; then
        echo $source_subs $params_subs | jq -s 'add | {"--substitutions": .} // ""'
    else
        echo ""
    fi
}

build_cloudbuildyaml() {
    local payload
    payload=$1
    source_cloudbuild_path="$(jq -r '.source.cloudbuild_path // ""' < "$payload")"
    source_cloudbuild_content="$(jq -r '.source.cloudbuild_content // ""' < "$payload")"
    cloudbuild_path="$(jq -r '.params.cloudbuild_path // ""' < "$payload")"
    cloudbuild_content="$(jq -r '.params.cloudbuild_content // ""' < "$payload")"
    if [ -n "$cloudbuild_content" ]; then
        cloudbuild_path=$(mktemp $TMPDIR/gcb-resource-cloudbuild-params.XXXXXX)
        echo "$cloudbuild_content" > "$cloudbuild_path"
    elif [ -n "$cloudbuild_path" ]; then
        true
    elif [ -n "$source_cloudbuild_content" ]; then
        cloudbuild_path=$(mktemp $TMPDIR/gcb-resource-cloudbuild-source.XXXXXX)
        echo "$source_cloudbuild_content" > "$cloudbuild_path"
    elif [ -n "$source_cloudbuild_path" ]; then
        cloudbuild_path="$source_cloudbuild_path"
    else
        cloudbuild_path=""
    fi
    echo $cloudbuild_path
}
