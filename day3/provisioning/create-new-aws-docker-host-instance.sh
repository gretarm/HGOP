INSTANCE_DIR="ec2_instance"
SECURITY_GROUP_NAME="ssh-http"

#Checks if there is already instance
if [ -d "${INSTANCE_DIR}" ]; then
    exit
fi

[ -d "${INSTANCE_DIR}" ] || mkdir ${INSTANCE_DIR}


#creates unique key pair from computer to instance
aws ec2 create-key-pair --key-name ${SECURITY_GROUP_NAME} --query 'KeyMaterial' --output text > ${INSTANCE_DIR}/${SECURITY_GROUP_NAME}.pem
#makes the .pem key only readable by current user(needed for aws)
chmod 400 ${INSTANCE_DIR}/${SECURITY_GROUP_NAME}.pem
#creates security group to be used in dev instance
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name ${SECURITY_GROUP_NAME} --description "security group for dev environment in EC2" --query "GroupId"  --output=text)
#writes out group id. Can be used later to delete/edit/modify security group
echo ${SECURITY_GROUP_ID} > ./ec2_instance/security-group-id.txt
#gets public ip and add "/32"
MY_PUBLIC_IP=$(curl http://checkip.amazonaws.com)
MY_CIDR=${MY_PUBLIC_IP}/32

#adds Http rule for port 80 to security group
aws ec2 authorize-security-group-ingress --group-name ${SECURITY_GROUP_NAME} --protocol tcp --port 80 --cidr ${MY_CIDR}

#runs the instance. Uses ./ec2-instance-init.sh to set up instance. 
INSTANCE_ID=$(aws ec2 run-instances --user-data file://ec2-instance-init.sh --image-id ami-e7d6c983 --security-group-ids ${SECURITY_GROUP_ID} --count 1 --instance-type t2.micro --key-name ${SECURITY_GROUP_NAME} --query 'Instances[0].InstanceId'  --output=text)
#Writes out instance id to file
echo ${INSTANCE_ID} > ./ec2_instance/instance-id.txt

#Waits for instance to copmlete initializing and be up and running  
aws ec2 wait --region eu-west-2 instance-running --instance-ids ${INSTANCE_ID}
#gets instance name
export INSTANCE_PUBLIC_NAME=$(aws ec2 describe-instances --instance-ids ${INSTANCE_ID} --query "Reservations[*].Instances[*].PublicDnsName" --output=text)

#Writes names to be used in other script/quick refrances
echo ${INSTANCE_PUBLIC_NAME} > ./ec2_instance/instance-public-name.txt
echo ${SECURITY_GROUP_NAME} > ./ec2_instance/security-group-name.txt