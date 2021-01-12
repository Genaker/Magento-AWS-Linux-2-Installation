#!/bin/bash
# best documentation I have found http://manpages.ubuntu.com/manpages/xenial/man1/s3fs.1.html
# to reinstall or unmount : sudo umount /var/www/html/magento/pub/media -l -f

# test S3 speed: dd if=/dev/zero of=test2.img bs=100M count=1 oflag=dsyn

# Replace this variables with you stuf 

export S3_MOUNT_PATH='/var/www/html/magento/pub/media/'
export AWS_S3FS_KEY=***
export AWS_S3FS_SECRET='***'
export AWS_S3FS_BUCKET=MyBucket

set +e
#yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
[ -z "$S3_MOUNT_PATH" ] && S3_MOUNT_PATH=$HOME/s3mnt || echo "Mounted ENV path: $S3_MOUNT_PATH"
if mountpoint -q $S3_MOUNT_PATH 
then
  echo "S3 is mounted $S3_MOUNT_PATH"
else
  echo "Enable the EPEL repository"
  sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  sudo yum-config-manager --enable epel
  #sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/epel.repo
  yum install -y gcc git libstdc++-devel gcc-c++ curl-devel libxml2-devel openssl-devel mailcap;
  yum remove -y fuse fuse-s3fs;
  yum install -y fuse-devel;
  yum install -y fpart git make automake;
  yum install -y  fuse fuse-devel curl-devel openssl-devel; #dkms-fuse gcsfuse;
  ## Configuration
  
  #mkdir -p /etc/
  fs/
  #rm -rf /etc/s3fs/.passwd-s3fs
  #echo $AWS_S3FS_KEY:$AWS_S3FS_SECRET > /etc/s3fs/.passwd-s3fs
  #chmod 600 /etc/s3fs/.passwd-s3fs
  aws configure set aws_access_key_id $AWS_S3FS_KEY --profile s3fs
  aws configure set aws_secret_access_key $AWS_S3FS_SECRET --profile s3fs
  # TODO: region put into varriables 
  aws configure set region us-wast-2 --profile s3fs

  cd /usr/src/
  rm -rf s3fs-fuse
  git clone https://github.com/s3fs-fuse/s3fs-fuse.git
  cd s3fs-fuse
  ./autogen.sh
  ./configure
  #make 
  #sudo make install
  echo "Finish compiling"
  #yum install make
  echo "Remove old folder";
  [ -d "$S3_MOUNT_PATH" ] && cp -r $S3_MOUNT_PATH S3backup #&& rm -rf $S3_MOUNT_PATH/*
  mkdir -p /tmp/cache $S3_MOUNT_PATH
  chmod 755 /tmp/cache $S3_MOUNT_PATH
  echo "Trying to mount"
  echo "Mount path '$S3_MOUNT_PATH' bucket $AWS_S3FS_BUCKET"
  /usr/local/bin/s3fs -o profile=s3fs -o endpoint=us-east-2 -o default_acl=public-read -o use_cache=/tmp/cach -o retries=2 -o allow_other -o mp_umask=000 -o nonempty $AWS_S3FS_BUCKET $S3_MOUNT_PATH # -o dbglevel="debug" -o curldbg
  #mountpoint -q $S3_MOUNT_PATH && rm -rf S3backup
  cp /etc/updatedb.conf "/etc/updatedb.conf.bk.$(date  +"%Y-%m-%dT%H%M%S%:z")"
  echo  "PRUNEPATHS = \"$S3_MOUNT_PATH\"" >> /etc/updatedb.conf
  # for umount umount /media/dave/isomnt
fi
set -e 
mountpoint -q $S3_MOUNT_PATH && echo "S3 $S3_MOUNT_PATH is mounted" || exit 1;

## you can test it on awsLinux Docker with flagg privelaged " docker start --privileged amazonlinux"
