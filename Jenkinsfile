pipeline {
    agent any

    environment {
        // Load the REACT_APP_API_KEY from Jenkins credentials
        API_KEY = credentials('REACT_APP_API_KEY')
    }   
    stages {
        stage('Clone repo') {
            steps {
                git branch: 'main', url: 'https://github.com/filipas13/stock_dashboard/'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'sudo docker build -t stock_dashboard .'
                    }
                }
            }
                        
        stage('Run Container') {
            steps {
                script {
                    // Run the Docker image with the API key as an environment variable
                    sh "sudo docker run -d -p 3000:3000 --name stock_dashboard_container -e REACT_APP_API_KEY=$API_KEY stock_dashboard"
                    //sleep 15
                }                       
            }
        }
              
        
        stage('Smoke Test') {
            steps {
                // Wait for the application to start
                sleep 10
                sh 'curl -f http://3.120.235.189:3000 || exit 1'
            }
        }
        
        stage('Deploy to AWS ECR') {
            steps {
                script {
                    def timestamp = new Date().format('yyyyMMdd-HHmm')
                    sh 'aws ecr get-login-password --region eu-central-1 | sudo docker login --username AWS --password-stdin 646148053375.dkr.ecr.eu-central-1.amazonaws.com'
                    sh 'sudo docker build -t stocks .'
                    sh "sudo docker tag stocks:latest 646148053375.dkr.ecr.eu-central-1.amazonaws.com/demo:${timestamp}"
                    sh "sudo docker push 646148053375.dkr.ecr.eu-central-1.amazonaws.com/demo:${timestamp}"
                }
                sleep 90
            }  
        }               
               
        //  stage('Stop and Remove Container') {
        //     steps {
        //         script {
        //             def doc_containers = sh(returnStdout: true, script: 'sudo docker container ps -aq').replaceAll("\n", " ") 
        //             if (doc_containers) {
        //                 sh "sudo docker stop ${doc_containers}"
        //             }
        //         }
        //     }
        // }
    }
    
    post {
        always {
            // Clean up - stop and remove the Docker container
            sh 'sudo docker stop stock_dashboard_container || true'
            sh 'sudo docker rm stock_dashboard_container || true'
        }
    }            
}

