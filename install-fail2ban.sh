#!/bin/bash

sudo yum install epel-release

sudo yum install fail2ban

sudo systemctl enable fail2ban && sudo systemctl start fail2ban
