pipeline {
	agent any
	stages {

		stage('Linting') {
			steps {
				sh 'hadolint Dockerfile'
				sh 'tidy -q -e index.html'
			}
		}
		
		stage('Build Docker Image') {
			steps {	
					sh '''
						docker build --tag=goribash/udacitycapstone .
					'''		
			}
		}

		stage('Push Image To DockerHub') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]){
					sh '''
						docker login -u $USERNAME -p $PASSWORD
						docker push goribash/udacitycapstone
					'''
				}
			}
		}

		stage('Set Current Kubectl context') {
			steps {
				withAWS(credentials:'aws-credentials') {
					sh '''
						aws eks --region us-east-1 update-kubeconfig --name UdacityCapstoneCluster
						kubectl config use-context arn:aws:eks:us-east-1:305470520825:cluster/UdacityCapstoneCluster
					'''
				}
			}
		}

		stage('Deploy Blue container') {
			steps {
				withAWS(credentials:'aws-credentials') {
					sh '''
						kubectl apply -f ./blue-controller.json
					'''
				}
			}
		}

		stage('Deploy Green container') {
			steps {
				withAWS(credentials:'aws-credentials') {
					sh '''
						kubectl apply -f ./green-controller.json
					'''
				}
			}
		}

		stage('Create the service in the Cluster, redirect to blue') {
			steps {
				withAWS(credentials:'aws-credentials') {
					sh '''
						kubectl apply -f ./blue-service.json
					'''
				}
			}
		}

		stage('Wait user Approval') {
            steps {
                input "Ready to redirect traffic to green?"
            }
        }

		stage('Create the service in the cluster, redirect to green') {
			steps {
				withAWS(credentials:'aws-credentials') {
					sh '''
						kubectl apply -f ./green-service.json
					'''
				}
			}
		}

	}
}