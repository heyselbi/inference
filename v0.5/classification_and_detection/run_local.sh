#!/bin/bash

echo "directories"

export MODEL_DIR=/root/v0.5/classification_and_detection/dataset
export DATA_DIR=/root/inference/v0.5/classification_and_detection/dataset

echo "run_common"
source ./run_common.sh

echo "common_opt"
common_opt="--config ../mlperf.conf"
dataset="--dataset-path $DATA_DIR"

echo "output"
OUTPUT_DIR=`pwd`/output/$name
if [ ! -d $OUTPUT_DIR ]; then
    mkdir -p $OUTPUT_DIR
fi

echo "Clearing caches."
sync && echo 3 | tee /host_proc/sys/vm/drop_caches

cd /root

pwd

start_fmt=$(date +%Y-%m-%d\ %r)
echo "STARTING RUN AT $start_fmt"

echo "python_main"
python python/main.py --profile $profile $common_opt --model $model_path $dataset \
    --output $OUTPUT_DIR $EXTRA_OPS $@

end_fmt=$(date +%Y-%m-%d\ %r)
echo "ENDING RUN AT $end_fmt"
