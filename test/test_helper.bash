payload_file() {
    payload=$(mktemp $TMPDIR/gcb-resource-request.XXXXXX)
    echo $1 > $payload
    echo $payload
}

json_equal() {
    a=$(jq -n "$1")
    b=$(jq -n "$2")
    echo $a
    echo ----
    echo $b
    [ "$a" = "$b" ]
}
