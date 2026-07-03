#!/usr/bin/env bash
set -e
set -o pipefail

branch=$(git symbolic-ref --short HEAD)
version_filename=VERSION/$branch

old_version=$(< $version_filename)
new_version=$(($old_version + 1))
new_tag=eu.gcr.io/pubfront/lcp-dashboard:$branch-$new_version

docker build --platform linux/amd64 -t $new_tag .
docker push $new_tag

echo $new_version > $version_filename
echo "Built and pushed $new_tag"
