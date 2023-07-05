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
        stage('Deploy to AWS ECR') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    script {
                        def awsRegion = 'eu-central-1'
                        def ecrRepository = 'jenkins_stock'
                        def dockerImageTag = 'stock_dashboard:latest'
                        def ecrRegistry = '${env.AWS_ACCOUNT_ID}.dkr.ecr.${awsRegion}.amazonaws.com'
                        def ecrImageUri = '${ecrRegistry}/${ecrRepository}:${dockerImageTag}'
                
                        // Authenticate with AWS ECR
                        sh 'aws ecr get-login-password --region ${awsRegion} | docker login --filipas13 --password-stdin ${ecrRegistry}'
                
                        // Tag the Docker image with the ECR repository URI
                        sh 'docker tag stock_dashboard ${ecrImageUri}'
                
                        // Push the Docker image to AWS ECR
                        //sh 'docker push ${ecrImageUri}'
                        sh 'docker push 646148053375.dkr.ecr.eu-central-1.amazonaws.com/jenkins_stock:latest'
                
                        // Output the ECR image URI for reference
                        //echo 'ECR Image URI: ${ecrImageUri}'
                    }
                }
                sleep 90
            }               
        }
        
        stage('Stop and Remove Container') {
            steps {
                script {
                    def doc_containers = sh(returnStdout: true, script: 'docker container ps -aq').replaceAll("\n", " ") 
                    if (doc_containers) {
                        sh "docker stop ${doc_containers}"
                    }
                }
            }
        }
    }    
}


