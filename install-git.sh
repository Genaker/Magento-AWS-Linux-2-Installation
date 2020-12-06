#!/bin/bash

sudo yum install git -y

# optional save passwords 

git config --global credential.helper store

# optional file endings 

git config --global core.autocrlf input
