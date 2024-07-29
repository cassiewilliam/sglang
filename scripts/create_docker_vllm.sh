#!/bin/bash

# 容器名称
container_name="docker-env-vllm-bench"

# 检查容器是否存在
if docker inspect "$container_name" >/dev/null 2>&1; then
    # 容器存在，直接打开
    echo "$container_name"
    docker start $container_name
    docker exec -it $container_name /bin/bash
else
    # 容器不存在，进行其他操作
    echo "Container does not exist."
    docker run \
        --name $container_name \
        -itd \
        --device=/dev/infiniband \
        --network=host \
        --ipc=host \
        --shm-size 500G \
        --security-opt seccomp=unconfined \
        --privileged=true \
        --gpus all \
        -v `pwd`:/home/workcode \
        --workdir /home/workcode \
        nvcr.io/nvidia/pytorch:23.07-py3 /bin/bash
fi

# --gpus '"device=0,1,2,3,4,5"' \

# NOTE(Alan): without export VLLM_ATTENTION_BACKEND=FLASHINFER
# python -m vllm.entrypoints.openai.api_server --model /home/workcode/models/Meta-Llama-3-8B --disable-log-requests

# NOTE(Alan): with export VLLM_ATTENTION_BACKEND=FLASHINFER
# export VLLM_ATTENTION_BACKEND=FLASHINFER && python -m vllm.entrypoints.openai.api_server --model /home/workcode/models/Meta-Llama-3-8B --disable-log-requests
