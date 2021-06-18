#!/bin/bash

for i in {40..500}
do
   echo "Folder $i "; # rm -rf $i
done

for i in {40..500}; do rm -rf $i;  done
