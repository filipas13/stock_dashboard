pipeline {
    agent any
    
    stages {
        stage('Deploy') {
            steps {
                git 'https://github.com/filipas13/stock_dashboard.git'
            }
        }
        
        stage('Build Image') {
            steps {
                dir('stock_dashboard') {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }
        
        stage('Deploy in Cloud') {
            steps {
                withDockerRegistry(credentialsId: 'd091bcbe-a43d-4eea-86e2-0b262fd99d70', url: 'https://hub.docker.com/repositories/filipas13') {
                    sh 'docker build -t stock_dashboard .'
                    sh 'docker push stock_dashboard'
                    // Deploy to the cloud using the appropriate deployment commands
                }
            }
        }
        
        stage('Smoke Test') {
            steps {
                sh 'docker run --env-file .env -p 3000:3000 stock_dashboard &'
                // Wait for the application to start
                        sleep 30
                sh 'curl -f http://52.59.53.0:3000/ || exit 1'
            }
        }
    }
}
