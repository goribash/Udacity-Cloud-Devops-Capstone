## Udacity-Cloud-Devops-Capstone
## Project Overview

In this project you will apply the skills and knowledge which were developed throughout the Cloud DevOps Nanodegree program

## Project Tasks
I will develop a CI/CD pipeline for micro services applications FOR NGINX hello world with `blue/green` deployment 

* Use Jenkins to implement Continuous Integration and Continuous Deployment
* Test the project code using linting
* Build pipelines
* Build Kubernetes clusters
* Build Docker containers in pipelines

## Instructions

### Setup Up Environment:
1. Create EKS cluster using `create_cluster.sh`
2. Launch EC2 Instance , SSH into the Instance and install Jenkins and other packages as listed in `Environment.sh` file 
3. Start and setup Jenkins then install plugins  `pipeline-aws` and `Blue Ocean`
4. Configure `AWS` & `DockerHub` credentials in Jenkins
5. Add webhook in the github repository to allow Jenkins pick changes. 
6. Create a new pipeline for the Github Repo
7. Commit Changes in the Main Branch ; this would trigger Jenkins pipeline to deploy container in the EKS CLuster.
8. Open `url` in browser. 



---

## Files in This Repository

* Dockerfile: It contains a set of instruction to build the docker image
* create_cluster.sh: This script is used to create the EKS Cluster
* environment.sh: This file contains details of packages to be installed on Ubuntu Server
* index.html: file is deployed in `nginx` server 
* Jenkinsfile : It contains details of all stages to be run in the pipeline 
* green-controller.json : It is used to create a replication controller green pod
* green-service.json : It is used to create the green service
* blue-controller.json : It is used to create a replication controller blue pod
* blue-service.json : It is used to create the blue service

