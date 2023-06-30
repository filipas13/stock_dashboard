pipeline {
    agent {label "docker-node"} 
    
    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub_filipas13')
    }
    
    stages { 
        stage('SCM Checkout') {
            steps{
                sh 'git clone https://github.com/filipas13/stock_dashboard.git'
            }
        }

        stage('Build docker image') {
            steps {  
                script {
                    docker.build("filipas13/stock_dash:${BUILD_NUMBER}", ".")
                }
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub_filipas13', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR')]) {
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                }
            }
        }
    }
}

