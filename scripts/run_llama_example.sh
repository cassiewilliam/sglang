#!/bin/bash

export PYTHONPATH=$(pwd)

python3 python/sglang/bench_serving.py --backend sglang --dataset-name random --random-input 1024 --random-output 1024 --num-prompts 100 --request-rate 4 --output-file online_sglang.jsonl