#! /bin/bash
rm ./other/override/*
find src/0* -name "*.ncs" -exec cp {} ./other/override/. \;
cp src/tslrcm_patch/a_hatchopen.ncs ./other/override/.
