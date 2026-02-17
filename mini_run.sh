export HF_ENDPOINT=https://hf-mirror.com

mini-extra swebench \
    --config configs/cwm.yaml \
    --output results/cwm \
    --subset verified \
    --split test \
    --workers 20
