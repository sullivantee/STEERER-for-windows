# !/usr/bin/env sh

# set -x

CONFIG=$1
CHECKPOINT=$2
GPUS=$3

# Depend on your conda version, some activate may be located at
# ~anaconda3/Scripts/activate
# switch it up, if you feel the need to
source ~/anaconda3/bin/activate STEERER

# the original author comment out this line,
# but I am unable to run without this. ¯\_(ツ)_/¯
export CUDA_VISIBLE_DEVICES=${GPUS:-"1"}

python  tools/test_loc.py \
        --cfg=$CONFIG \
        --checkpoint=$CHECKPOINT \
        --launcher pytorch ${@:5}
