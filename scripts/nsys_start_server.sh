nsys profile \
     --stat=true \
     --gpu-metrics-device=0 \
     --duration=100 \
     --python-sampling=true \
     --trace=nvtx,osrt,cuda,python-gil \
     ./scripts/start_server.sh