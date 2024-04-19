#!/bin/bash

# Avoid possible network issue
unset http_proxy https_proxy

export TG_WEBUI=$HOME/ai/tg-webui
cd $TG_WEBUI
# Activate virtual environment
source $TG_WEBUI/.venv/bin/activate

ls-models()
{
	local dir="${1:-$TG_WEBUI/models}"

	echo "Available models in $dir:"
	for dir in $dir/*; do
        if [ -d "$dir" ]; then
            echo "$(basename "$dir")"
        fi
    done
    for file in $dir/*.gguf; do
        if [ -f "$file" ]; then
            echo "$(basename "$file")"
        fi
    done
}

MODEL_NAME="$1"

if [ -z "$MODEL_NAME" ]; then
	python server.py --api --api-port 11451
elif [ -d "$TG_WEBUI/models/$MODEL_NAME" ]; then
	python server.py --api --api-port 11451 --model "$MODEL_NAME"
else
	echo "Model file does not exist..."
	ls-models
fi
