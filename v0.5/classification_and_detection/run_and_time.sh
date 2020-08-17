#!/bin/bash

export MODEL_DIR=/root/v0.5/classification_and_detection/dataset
export DATA_DIR=/root/v0.5/classification_and_detection/dataset

source run_common.sh

dockercmd=docker
if [ $device == "gpu" ]; then
    runtime="--runtime=nvidia"
fi

# copy the config to cwd so the docker contrainer has access
cp ../mlperf.conf .

OUTPUT_DIR=`pwd`/output/$name
if [ ! -d $OUTPUT_DIR ]; then
    mkdir -p $OUTPUT_DIR
fi

#image=mlperf-infer-imgclassify-$device
#buildah bud --tls-verify=false  -t $image -f Dockerfile.$device .
image=quay.io/selbi/inf-test

opts="--config ./mlperf.conf --profile $profile $common_opt --model $model_path \
    --dataset-path $DATA_DIR --output $OUTPUT_DIR $extra_args $EXTRA_OPS $@"

buildah run $runtime -e opts="$opts" \
    -v $DATA_DIR:$DATA_DIR -v $MODEL_DIR:$MODEL_DIR -v `pwd`:/mlperf \
    -v $OUTPUT_DIR:/output -v /proc:/host_proc \
    -t $image:latest /mlperf/run_helper.sh 2>&1 | tee $OUTPUT_DIR/output.txt

