pipeline {
    agent any
    
   
    stages {
        stage('clone repo') {
            steps {
                git branch: 'main', url: 'https://github.com/filipas13/stock_dashboard/'
            }
        }
        
        stage('Build Image') {
            steps {
                    script {
                    
                    // Build the Docker image
                    docker.build('stock_dashboard')

                    withCredentials([string(credentialsId: 'REACT_APP_API_KEY', variable: 'stock')]) {
                        // Run the Docker image
                        docker.image('stock_dashboard').run('-p 3004:3004 -e REACT_APP_API_KEY='+stock)
                    }
                }
            }
        }
    }    
}


