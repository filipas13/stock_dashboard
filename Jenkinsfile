pipeline {
    agent any
  
    stages {
        stage('Deploy') {
            steps {
                git branch: 'main', url: 'https://github.com/filipas13/stock_dashboard/'
            }
        }
        
        stage('Build Image') {
            steps {
                withDockerRegistry(credentialsId: 'd091bcbe-a43d-4eea-86e2-0b262fd99d70', url: 'https://hub.docker.com/repositories/filipas13') {
                sh 'docker build -t stock_dashboard .' 
                sh 'docker run -p 3000:3000 stock_dashboard'
                // add docker build + run image
                }
            }
        }    
    }
}

