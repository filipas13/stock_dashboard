pipeline {
    agent any
    
    environment {
        REACT_APP_API_KEY = "ci855o9r01qnrgm31qa0ci855o9r01qnrgm31qag"
    }

    
    stages {
        stage('clone repo') {
            steps {
                git branch: 'main', url: 'https://github.com/filipas13/stock_dashboard/'
            }
        }
        
        stage('Build Image') {
            steps {
                sh 'env'
                script {
                    // Build the Docker image
                    docker.build('stock_dashboard')
                
                    // Run the Docker image
                    docker.image('stock_dashboard').run('-p 3004:3004 -e REACT_APP_API_KEY=${env.REACT_APP_API_KEY}')
                }
            }
        }
    }    
}


