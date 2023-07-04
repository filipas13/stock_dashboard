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
                        docker.image('stock_dashboard').run('-p 3000:3000 -e REACT_APP_API_KEY='+stock)
                        }
                    sleep 30
                }
            }
        }
        stage('Smoke Test') {
            steps {
                //docker.image('stock_dashboard').run('-p 3000:3000 -e REACT_APP_API_KEY='+stock) &
                // Wait for the application to start
                // sleep 30
                sh 'curl -f http://3.68.96.244:3000 || exit 1'
            }
        }
        stage('Deploy to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub
                    // sh 'docker login -u <your-username> -p <your-password>'

                    // Tag the Docker image
                    sh 'docker tag stock_dashboard filipas13/stock_dashboard:latest'

                    // Push the Docker image to Docker Hub
                    sh 'docker push filipas13/stock_dashboard:latest'
                }
            }
        }
               
    }    
}


