#!/bin/bash

cd dataset

wget -q https://zenodo.org/record/3236545/files/resnet34-ssd1200.pytorch

pwd

python -m pip install ck

ck version

ck pull repo:ck-env

echo "install"

ck install package --tags=image-classification,dataset,imagenet,val,original,full
ck install package --tags=image-classification,dataset,imagenet,aux

echo "locate"

ck locate env --tags=image-classification,dataset,imagenet,val,original,full
ck locate env --tags=image-classification,dataset,imagenet,aux

echo "copy"

cp `ck locate env --tags=aux`/val.txt `ck locate env --tags=val`/val_map.txt

ls -lt

pwd

ck install package --tags=object-detection,dataset,coco,2017,val,original
ck locate env --tags=object-detection,dataset,coco,2017,val,original

ls -lt

pwd
