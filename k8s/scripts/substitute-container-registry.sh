#!/bin/bash

if [ -z "$CONTAINER_REGISTRY_PREFIX" ]; then
    echo "Error: CONTAINER_REGISTRY_PREFIX is not defined."
    exit 1
fi

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <file-or-directory>..."
    echo "Example: $0 k8s/tmpl-deploy.yml k8s/"
    echo "This only substitutes \"CONTAINER_REGISTRY_PREFIX\" on manifests with the prefix \"tmpl-\" by \"$CONTAINER_REGISTRY_PREFIX\"."
    exit 1
fi

# loops between all arguments to the script
for i in "$@"; do
    # checks if the argument is a file
    if [ -f "$i" ]; then
        # replaces the container registry in the file
        sed -i "s|CONTAINER_REGISTRY_PREFIX|${CONTAINER_REGISTRY_PREFIX}|g" "$i"
    else
        # checks it is iterable
        for manifest in $(find "$i" -type f -name "tmpl-*.yaml"); do
            # replaces the container registry in the file
            manifest_dir=$(dirname "$manifest")
            generated_dir=$(echo "$manifest_dir/generated")
            mkdir -p "$generated_dir"
            new_manifest=$(echo "$manifest" | sed "s/tmpl-//g")
            new_manifest=$(echo "$new_manifest" | sed "s|$manifest_dir|$generated_dir|g")
            cp "$manifest" "$new_manifest"
            sed -i "s|CONTAINER_REGISTRY_PREFIX|${CONTAINER_REGISTRY_PREFIX}|g" "$new_manifest"
        done
        for manifest in $(find "$i" -type f -name "tmpl-*.yml"); do
            # replaces the container registry in the file
            manifest_dir=$(dirname "$manifest")
            generated_dir=$(echo "$manifest_dir/generated")
            mkdir -p "$generated_dir"
            new_manifest=$(echo "$manifest" | sed "s/tmpl-//g")
            new_manifest=$(echo "$new_manifest" | sed "s|$manifest_dir|$generated_dir|g")
            sed -i "s|CONTAINER_REGISTRY_PREFIX|${CONTAINER_REGISTRY_PREFIX}|g" "$new_manifest"
        done
    fi
done