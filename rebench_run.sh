#!/usr/bin/env bash
set -euo pipefail

export HF_ENDPOINT=https://hf-mirror.com

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKERS="${WORKERS:-15}"
MODEL_TAG="${MODEL_TAG:-cwm}"
RUN_REBENCH="${RUN_REBENCH:-1}"

if [[ "${RUN_REBENCH}" == "1" ]]; then
    mini-extra swebench \
        --config "${ROOT_DIR}/configs/cwm.yaml" \
        --output "${ROOT_DIR}/output/${MODEL_TAG}_rebench" \
        --subset "${ROOT_DIR}/rebench/SWE-rebench-test_cases_1200.jsonl" \
        --split train \
        --workers "${WORKERS}"
fi
