 #!/bin/bash
 
 lsblk
 
 sudo growpart /dev/nvme0n1 1
 
 sudo xfs_growfs -d /
 
 df -h
