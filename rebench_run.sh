#!/usr/bin/env bash
set -euo pipefail

export HF_ENDPOINT=https://hf-mirror.com

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKERS="${WORKERS:-15}"
MODEL_TAG="${MODEL_TAG:-cwm}"
CONFIG="${CONFIG:-rebench}"
RUN_REBENCH="${RUN_REBENCH:-1}"
RUN_REBENCH_VARIANTS="${RUN_REBENCH_VARIANTS:-1}"

if [[ "${RUN_REBENCH}" == "1" ]]; then
    mini-extra swebench \
        --config "${ROOT_DIR}/configs/${CONFIG}.yaml" \
        --output "${ROOT_DIR}/output/${MODEL_TAG}_rebench" \
        --subset "${ROOT_DIR}/rebench/SWE-rebench-test_cases_1200.jsonl" \
        --split train \
        --workers "${WORKERS}"
fi

if [[ "${RUN_REBENCH_VARIANTS}" == "1" ]]; then
    for variant in back_translate repeat llm_reorder; do
        mini-extra swebench \
            --config "${ROOT_DIR}/configs/${CONFIG}.yaml" \
            --output "${ROOT_DIR}/output/${MODEL_TAG}_rebench_${variant}" \
            --subset "${ROOT_DIR}/rebench/SWE-rebench-test_cases_1200__local__${variant}.jsonl" \
            --split train \
            --workers "${WORKERS}"
    done
fi
