eksctl create cluster --name UdacityCapstoneCluster --version 1.20 --nodegroup-name standard-workers --node-type t2.micro --nodes 2 --nodes-min 1 --nodes-max 4 --region us-east-1 --zones us-east-1a --zones us-east-1b --zones us-east-1c

# aws eks --region us-east-1 update-kubeconfig --name UdacityCapstoneCluster
