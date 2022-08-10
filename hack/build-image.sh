#!/usr/bin/env bash
set -eux

echo
echo "Start build images, Repo: $1, Tag: $2"
echo

root_directory=$(echo "$PWD")
echo $root_directory

eval "ls $root_directory/opentelemetry"

for dir in ts-*; do
    if [[ -d $dir ]]; then
        if [[ -n $(ls "$dir" | grep -i Dockerfile) ]]; then
            mkdir -p $dir/target
            cp $root_directory/opentelemetry/opentelemetry-javaagent-all.jar $dir/target/otel.jar
            cp $root_directory/opentelemetry/json.jar $dir/target/json.jar
            cp $root_directory/opentelemetry/vaif.json $dir/target/vaif.json
            cp $root_directory/opentelemetry/enable.json $dir/target/enable.json
            echo "build ${dir}"
            docker build -t "$1"/"${dir}" "$dir"
            docker tag "$1"/"${dir}":latest "$1"/"${dir}":"$2"
        fi
    fi
done
