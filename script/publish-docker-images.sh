#!/usr/bin/env bash
set -eux

root_directory=$(echo "$PWD")
echo $root_directory

echo
echo "Publishing images, Repo: $1, Tag: $2"
echo
for dir in ts-*; do
    if [[ -d $dir ]]; then
        if [[ -n $(ls "$dir" | grep -i Dockerfile) ]]; then
            echo "build ${dir}"
            mkdir -p $dir/target
            cp $root_directory/opentelemetry/opentelemetry-javaagent-all-work.jar $dir/target/otel.jar
            cp $root_directory/opentelemetry/json.jar $dir/target/json.jar
            cp $root_directory/opentelemetry/vaif.json $dir/target/vaif.json
            cp $root_directory/opentelemetry/enable.json $dir/target/enable.json
	    # Must use `buildx` as docker build tool
            docker build --push -t "$1"/"${dir}":"$2" "$dir"
        fi
    fi
done
