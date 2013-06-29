#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo BEGIN

EC2_HOSTNAME=`ec2metadata --public-hostname`
EC2_HOST=`echo $EC2_HOSTNAME | cut -d. -f1`
EC2_HOST=$EC2_HOST.`echo $EC2_HOSTNAME | cut -d. -f2`

if [ -a /etc/chef/client.pem ]; then
  rm /etc/chef/client.pem
else
  echo "no pem to delete"
fi
echo '{"run_list":["role[app_server]","recipe[passenger]","recipe[autoscaling]"]}' > /etc/chef/first-boot.json
sed -i "s/node_name \".*\"/node_name \"app_$EC2_HOST\"/g" /etc/chef/client.rb
sudo chef-client -j /etc/chef/first-boot.json

if [ $? -eq 0 ]; then
  /root/codepen/userdata.sh $EC2_HOST
else
  echo "FAILED CHEF RUN"
fi

echo END
