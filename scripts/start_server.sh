#!/bin/bash

export PYTHONPATH=$(pwd)

python -m sglang.launch_server --model-path /home/workcode/models/Meta-Llama-3.1-8B-Instruct --enable-torch-compile --disable-radix-cache