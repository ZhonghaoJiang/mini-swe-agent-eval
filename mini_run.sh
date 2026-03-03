#!/usr/bin/env bash
set -euo pipefail

export HF_ENDPOINT=https://hf-mirror.com

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKERS="${WORKERS:-25}"
MODEL_TAG="${MODEL_TAG:-qwen3-14b}"
RUN_VERIFIED="${RUN_VERIFIED:-1}"
RUN_VARIANTS="${RUN_VARIANTS:-0}"
CONFIG="${CONFIG:-cwm}"

if [[ "${RUN_VERIFIED}" == "1" ]]; then
    mini-extra swebench \
        --config "${ROOT_DIR}/configs/${CONFIG}.yaml" \
        --config model.model_name="openai/${MODEL_TAG}" \
        --output "${ROOT_DIR}/results/${MODEL_TAG}_verified" \
        --subset verified \
        --split test \
        --shuffle \
        --max-retries 1 \
        --workers "${WORKERS}"
fi

if [[ "${RUN_VARIANTS}" == "1" ]]; then
    for variant in back_translate repeat llm_reorder; do
        mini-extra swebench \
            --config "${ROOT_DIR}/configs/${CONFIG}.yaml" \
            --config model.model_name="openai/${MODEL_TAG}" \
            --output "${ROOT_DIR}/results/${MODEL_TAG}_${variant}" \
            --subset "${ROOT_DIR}/extra_dataset/${variant}.jsonl" \
            --split train \
            --shuffle \
            --max-retries 1 \
            --workers "${WORKERS}"
    done
fi
