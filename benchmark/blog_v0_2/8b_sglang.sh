# Create dummy weights:
# 1. Create a folder `~/llama-3.1-405b-fp8-dummy` and create `config.json` and tokenizer under this folder.
# 2. Get `config.json`` from ./config.md
# 3. Download the tokenizer
#   wget https://huggingface.co/neuralmagic/Meta-Llama-3.1-8B-Instruct-quantized.w8a8/resolve/main/tokenizer.json
#   wget https://huggingface.co/neuralmagic/Meta-Llama-3.1-8B-Instruct-quantized.w8a8/resolve/main/tokenizer_config.json

# Launch vllm
# python3 -m vllm.entrypoints.openai.api_server --model ~/llama-3.1-405b-fp8-dummy/ --load-format dummy --disable-log-requests --tensor-parallel-size 8 --max-model-len 10000

# offline
python3 -m sglang.bench_serving --backend sglang --dataset-name random --num-prompts 4000 --random-input 1024 --random-output 1024 --output-file offline.jsonl
python3 -m sglang.bench_serving --backend sglang --dataset-name random --num-prompts 5000 --random-input 1024 --random-output 512 --output-file offline.jsonl
python3 -m sglang.bench_serving --backend sglang --dataset-name random --num-prompts 1000 --random-input 4096 --random-output 2048 --output-file offline.jsonl
python3 -m sglang.bench_serving --backend sglang --dataset-name random --num-prompts 2000 --random-input 4096 --random-output 1024 --output-file offline.jsonl
python3 -m sglang.bench_serving --backend sglang --dataset-name random --num-prompts 6000 --random-input 256 --random-output 512 --output-file offline.jsonl
python3 -m sglang.bench_serving --backend sglang --dataset-name sharegpt --num-prompts 3000 --output-file offline.jsonl

# online
python3 -m sglang.bench_serving --backend sglang --dataset-name random --random-input 1024 --random-output 1024 --num-prompts 300 --request-rate 1 --output-file online.jsonl
python3 -m sglang.bench_serving --backend sglang --dataset-name random --random-input 1024 --random-output 1024 --num-prompts 600 --request-rate 2 --output-file online.jsonl
python3 -m sglang.bench_serving --backend sglang --dataset-name random --random-input 1024 --random-output 1024 --num-prompts 1200 --request-rate 4 --output-file online.jsonl
python3 -m sglang.bench_serving --backend sglang --dataset-name random --random-input 1024 --random-output 1024 --num-prompts 2400 --request-rate 8 --output-file online.jsonl
python3 -m sglang.bench_serving --backend sglang --dataset-name random --random-input 1024 --random-output 1024 --num-prompts 3200 --request-rate 16 --output-file online.jsonl
