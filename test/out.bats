load test_helper

source assets/out.sh
@test "merge substitutions from params and source" {
    payload=$(payload_file '{"source": {"substitutions": {"a":"A B C", "b": 2}}, "params": {"substitutions": {"b":3,"c":4}}}')
    run build_substitutions $payload
    json_equal "$output" '{ "--substitutions": { "a": "A B C", "b": 3, "c": 4 } }'
}

@test "return empty if substitutions from source or params is empty" {
    payload=$(payload_file '{"source": {}, "params": {}}')
    run build_substitutions $payload
    json_equal "$output" ''

    payload=$(payload_file '{"source": {"substitutions": {"a": 2}}, "params": {}}')
    run build_substitutions $payload
    json_equal "$output" '{ "--substitutions": { "a": 2 } }'
}

@test "cloudbuild.yaml from source.cloudbuild_path" {
    payload=$(payload_file '{"source": {"cloudbuild_path": "aaa"}}')
    run build_cloudbuildyaml $payload
    echo $output
    [ "$output" = 'aaa' ]
}

@test "cloudbuild.yaml from source.cloudbuild_content" {
    payload=$(payload_file '{"source": {"cloudbuild_content": '123', "cloudbuild_path": "aaa"}}')
    run build_cloudbuildyaml $payload
    echo $output
    [ $(cat "$output") = '123' ]
}

@test "cloudbuild.yaml from params.cloudbuild_path" {
    payload=$(payload_file '{"source": {"cloudbuild_content": '123', "cloudbuild_path": "aaa"}, "params": {"cloudbuild_path": "bbb"}}')
    run build_cloudbuildyaml $payload
    echo $output
    [ "$output" = 'bbb' ]
}

@test "cloudbuild.yaml from params.cloudbuild_content" {
    payload=$(payload_file '{"source": {"cloudbuild_content": '123', "cloudbuild_path": "aaa"}, "params": {"cloudbuild_path": "bbb", "cloudbuild_content": "456"}}')
    run build_cloudbuildyaml $payload
    echo $output
    [ $(cat "$output") = '456' ]
}
