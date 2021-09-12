#!/bin/bash

echo "Stop Gitlab on primary node "

ssh gitlab2.marekexample.com 'gitlab-ctl stop ; systemctl disable gitlab-runsvdir'


echo "Promote secondary node"
ssh gitlab1.marekexample.com 'systemctl  enable gitlab-runsvdir ; gitlab-ctl start; gitlab-ctl promote-to-primary-node --force'


echo "Done"


