#!/usr/bin/env bash

# set -x


PARTITION=$1
JOB_NAME=$2
CONFIG=$3
CHECKPOINT=$4 

GPUS=$5

GPUS=${GPUS}
GPUS_PER_NODE=${GPUS}
CPUS_PER_TASK=${CPUS_PER_TASK:-5}

PY_ARGS=${@:5}

PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
export TORCH_DISTRIBUTED_DEBUG="detail"
source /mnt/petrelfs/hantao.dispatch/anaconda3/bin/activate STEERER
srun -p ${PARTITION} \
    --job-name=${JOB_NAME} \
    --gres=gpu:${GPUS_PER_NODE} \
    --ntasks=${GPUS} \
    --ntasks-per-node=${GPUS_PER_NODE} \
    --cpus-per-task=${CPUS_PER_TASK} \
    --quotatype=reserved \
    --kill-on-bad-exit=1 \
    ${SRUN_ARGS} \
    python -u tools/test_loc.py --cfg=${CONFIG} --checkpoint=${CHECKPOINT} --launcher="slurm" ${PY_ARGS}