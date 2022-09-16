# ------------------------------------- Jenkins Server -----------------------------------------------
# ssh into Jenkins server
# Install packages etc. manually

# Update Installed Packages
sudo apt-get update && sudo apt-get -y upgrade

# 1. Install java, and tidy 
sudo apt-get -y install default-jdk unzip make tidy glibc-source

# 2. Install and Setup Docker
sudo apt-get -y remove docker docker-engine docker.io containerd runc

sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io

sudo chmod 666 /var/run/docker.sock

#3. Install Jenkins and start it
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'

sudo apt-get update

sudo apt-get -y install jenkins

sudo systemctl start jenkins

systemctl status jenkins

sudo systemctl enable jenkins

#4. Install AWS CLI V2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

which aws

# 5. Install Kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin

#6. Install hadolint
sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64 && sudo chmod +x /bin/hadolint

#7. Install ekstl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

# 8. install aws-iam-authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator

chmod +x ./aws-iam-authenticator

mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin

echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

aws-iam-authenticator help

# 9. add jenkins in docker group  
sudo usermod -a -G docker jenkins


# 10. Update aws credentials - IAM user programmetic acces - Amazon-admin access) 
aws configure

# 11. Update kube-config file
aws eks update-kubeconfig --name UdacityCapstoneCluster

#12. Restart Docker
sudo systemctl restart jenkins
