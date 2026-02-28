#!/usr/bin/env bash
set -euo pipefail

export HF_ENDPOINT=https://hf-mirror.com

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKERS="${WORKERS:-10}"
MODEL_TAG="${MODEL_TAG:-qwen3-coder-30b}"
RUN_SMITH="${RUN_SMITH:-1}"

if [[ "${RUN_SMITH}" == "1" ]]; then
    mini-extra swebench \
        --config "${ROOT_DIR}/configs/swesmith.yaml" \
        --output "${ROOT_DIR}/trajs/${MODEL_TAG}_smith" \
        --subset smith \
        --split train \
        --workers "${WORKERS}" \
        --shuffle
fi