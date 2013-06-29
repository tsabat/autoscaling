#!/bin/bash

# usage: userdata_run.sh $RANDOM

grep "codepen_fstab_setup" /etc/fstab
if [ $? -eq 1 ]; then
    echo "# codepen_fstab_setup" | tee -a /etc/fstab
    echo "/dev/xvdf /cp xfs noatime 0 0" | tee -a /etc/fstab
    echo "/cp/codepen /home/deploy/codepen     none bind" | tee -a /etc/fstab
fi

INSTANCE_TAGS="{\"Name\":\"app_$1\",\"Environment\":\"production\",\"Role\":\"app\"}"

/root/codepen/prep_instance.py -g $INSTANCE_TAGS

if [ $? -eq 0 ]; then
    if [ ! -d /cp ]; then
        mkdir -m 000 /cp
    fi

    if [ ! -d /home/deploy/codepen ]; then
        mkdir -m 000 -p /home/deploy/codepen
    fi
    mount -a
else
    echo FAIL
fi
