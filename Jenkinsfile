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
                script {
                    // Build the Docker image
                    docker.build('stock_dashboard')

                    // Run the Docker image
                    docker.image('stock_dashboard').run('-p 3000:3000  --env-file .env')
                }
            }
        }
    }    
}


