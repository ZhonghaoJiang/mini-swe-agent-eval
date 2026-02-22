#!/usr/bin/env bash
set -euo pipefail

export HF_ENDPOINT=https://hf-mirror.com

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKERS="${WORKERS:-15}"
MODEL_TAG="${MODEL_TAG:-cwm}"

#

for variant in back_translate repeat llm_reorder; do
    mini-extra swebench \
        --config "${ROOT_DIR}/configs/cwm.yaml" \
        --output "${ROOT_DIR}/output/${MODEL_TAG}_${variant}" \
        --subset "${ROOT_DIR}/extra_dataset/${variant}.jsonl" \
        --split train \
        --workers "${WORKERS}"
done
