#Reads needed info from .txt files
INSTANCE_ID=$(cat ./ec2_instance/instance-id.txt)
SECURITY_GROUP_ID=$(cat ./ec2_instance/security-group-id.txt)
SECURITY_GROUP_NAME=$(cat ./ec2_instance/security-group-name.txt)

#terminates the instances and wait for it to be fully terminated
aws ec2 terminate-instances --instance-ids ${INSTANCE_ID}
aws ec2 wait --region eu-west-2 instance-terminated --instance-ids ${INSTANCE_ID}

#removes both security group key pair
aws ec2 delete-security-group --group-id ${SECURITY_GROUP_ID}
aws ec2 delete-key-pair --key-name ${SECURITY_GROUP_NAME}

#removes local files
rm  -rf ec2_instance