cd /workspace
git clone -b v0.5.2 https://github.com/vllm-project/vllm

cd vllm

pip install -r requirements-cuda.txt
pip install -r requirements-dev.txt
pip install -r requirements-build.txt

export TORCH_CUDA_ARCH_LIST='8.0;9.0+PTX'
# export MAX_JOBS=8
# export NVCC_THREADS=8
# make sure punica kernels are built (for LoRA)
# export VLLM_INSTALL_PUNICA_KERNELS=1
# export TORCH_USE_CUDA_DSA=1
export VLLM_ATTENTION_BACKEND=FLASHINFER

git config --global --add safe.directory $(pwd)
python3 setup.py build_ext --inplace

VLLM_USE_PRECOMPILED=1 pip install .
