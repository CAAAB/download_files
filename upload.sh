#!/bin/bash

# Navigate to the repository directory
cd ~/Documents/Projects/flashinvaders/github/download_files

# Function to add and commit in batches
batch_upload() {
    batch_size=100
    total_files=$(ls images | wc -l)
    echo "Total files to upload: $total_files"

    for ((i=0; i<=$total_files; i+=batch_size))
    do
        echo "Processing batch: $i to $(($i + $batch_size))"
        git add images/* -N

        files_to_commit=$(git diff --name-only --cached | head -n $batch_size)

        if [ -n "$files_to_commit" ]; then
            echo "$files_to_commit" | xargs git add
            git commit -m "Added batch $i to $(($i + $batch_size))"
        fi
    done
}

# Run the batch upload function
batch_upload

# Push the changes to GitHub
git push origin main

