#!/bin/bash

set -e

wget https://github.com/datreeio/datree/releases/download/1.9.22-rc/datree-cli_1.9.22-rc_Linux_x86_64.zip

unzip datree-cli_1.9.22-rc_Linux_x86_64.zip -x README.md LICENSE.md

mv datree /usr/bin/
mv datree /usr/local/bin/

datree test **/*.yml --only-k8s-files --ignore-missing-schemas --policy-config="datree-policies.yaml"
