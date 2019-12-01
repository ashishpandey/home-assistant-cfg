#!/bin/bash

set -e

err_report() {
    echo "Deployment FAILED. Error on line $1"
}

trap 'err_report $LINENO' ERR

tmp_dir=$(mktemp -d -t patch-XXXXXX)
#config_dir=$tmp_dir/config
config_dir=/config
emhue_deploy_dir="$config_dir/custom_components/emulated_hue"

echo "working in temp dir $tmp_dir"
pushd $tmp_dir >/dev/null

echo "Downloading HA master"
wget -q -O home_assistant.zip https://github.com/home-assistant/home-assistant/archive/master.zip

echo "Extracting base packages"
unzip -q home_assistant.zip

echo "creating custom emulated_hue under $emhue_deploy_dir"
mkdir -p $emhue_deploy_dir
cp -R ./home-assistant-master/homeassistant/components/emulated_hue/* $emhue_deploy_dir/

echo "patching emulated_hue"
cp $emhue_deploy_dir/hue_api.py $emhue_deploy_dir/hue_api.py.original
sed -i 's/entity.domain != light.DOMAIN/entity.domain in [ fan.DOMAIN ]/' $emhue_deploy_dir/hue_api.py
chmod -R 755 $emhue_deploy_dir/*

popd >/dev/null

echo "Cleaning temp $tmp_dir"
rm -rf $tmp_dir

echo "Done"
