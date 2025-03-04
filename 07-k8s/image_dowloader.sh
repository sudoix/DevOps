#!/bin/bash
#
# You can run `kubeadm config images list` on your Kubernetes cluster and get
# the list of Docker images and save it to the file and then pull all images on
# the server that can download images from the internet with this command:
# `for i in $(cat tmp) do; docker pull $i` and then use this script to save all
# docker images to the directory.

# for import docker images to kubernetes cluster:
# `sudo ctr -n=k8s.io image import image.tar`
# for i in `ls -1`; do ctr -n=k8s.io image import $i; done

# Constants
LISTS_FILE="lists"
OUTPUT_DIR="docker_images"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Use 'docker image ls' to list images and extract their repository and tag
docker image ls --format '{{.Repository}}:{{.Tag}}' > "$LISTS_FILE"

# Check if the file was created successfully
if [ -f "$LISTS_FILE" ]; then
    echo "List of Docker images saved in '$LISTS_FILE'"
else
    echo "Error: Failed to create the list of Docker images."
    exit 1
fi

# Read 'lists' file line by line and process each image
while read -r i; do
    # Extract the image name (last part after '/') without leading spaces
    image=$(echo "$i" | awk -F/ '{latest = $NF; sub(/^[ \t]+/, "", latest); print latest}')

    # Replace ':' with '-' in the image name
    image_with_hyphen=$(echo "$image" | sed 's/:/-/g')

    # Check if the image has already been pulled and saved
    if [ ! -f "$OUTPUT_DIR/${image_with_hyphen}.tar" ]; then
        echo "Pulling Docker image: $i"
        docker pull "$i"
        echo "Saving Docker image '$i' as '${image_with_hyphen}.tar'"
        docker save -o "$OUTPUT_DIR/${image_with_hyphen}.tar" "$i"
    else
        echo "Docker image '$i' already exists as '${image_with_hyphen}.tar'. Skipping."
    fi
done < "$LISTS_FILE"

echo "All Docker images processed and saved in '$OUTPUT_DIR'"
