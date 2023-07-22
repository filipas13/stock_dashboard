pipeline {
    agent any

    environment {
        // Load the REACT_APP_API_KEY from Jenkins credentials
        API_KEY = credentials('REACT_APP_API_KEY')
    }   
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
                        sh 'sudo docker build -t stock_dashboard .'
        
                        // Extract the API key from the environment variable
                      
            
                        //sh "sudo docker image prune -a"
                        }
                    }
                }
                        
         stage('Run Container') {
            steps {
                    script {
                        //def stock = sh(returnStdout: true, script: 'echo $REACT_APP_API_KEY').trim()
                        // Run the Docker image with the API key as an environment variable
                        //sh "sudo docker run -t -d -p 3000:3000 -e REACT_APP_API_KEY=${stock} stock_dashboard"
                        sh "sudo docker run -d -p 3000:3000 --name stock_dashboard_container -e REACT_APP_API_KEY=$API_KEY stock_dashboard"
                        //sh "sudo docker tag #image_id stock_dashboard:latest"
                        //sh 'sudo docker run -d -p 3000:3000 stock_dashboard'
                    sleep 30
                    }        
                               
                    // script {
                    
                    //// Build the Docker image
                    //docker.build('stock_dashboard')

                    //withCredentials([string(credentialsId: 'REACT_APP_API_KEY', variable: 'stock')]) {
                    //    // Run the Docker image
                    //    docker.image('stock_dashboard').run('-p 3000:3000 -e REACT_APP_API_KEY='+stock)
                    //    }
                    //sleep 30
                //}
            }
        }
        //stage('Smoke Test v2') {
        //    steps {
        //       script {
        //        // Wait for the application to start (adjust the sleep time as needed)
        //       sleep 30
            
        //       // Define the target IP address and port
        //       def targetIP = "3.120.235.189"
        //        def targetPort = 3000
            
        //        // Check if the application is listening on the target port using nc (netcat)
        //        def ncCmd = "nc -z -w5 ${targetIP}:${targetPort}"
        //        try {
        //            sh ncCmd
        //            echo "Smoke Test: Application is running and listening on port ${targetPort}."
        //        }     catch (Exception e) {
        //                error "Smoke Test failed: Application is not running or not accessible on port ${targetPort}."
        //        }
        //    }
        //}
    //}    




        
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
                    withAWS(credentials:'IDofAwsCredentials'){
                        sh 'aws ecr get-login-password --region eu-central-1 | sudo docker login --username AWS --password-stdin 646148053375.dkr.ecr.eu-central-1.amazonaws.com'
                        sh 'sudo docker build -t stocks .'
                        sh 'sudo docker tag stocks:latest 646148053375.dkr.ecr.eu-central-1.amazonaws.com/stocks:latest'
                        sh 'sudo docker push 646148053375.dkr.ecr.eu-central-1.amazonaws.com/stocks:latest'
                        }
                }
          //      sleep 90
                }  
            }               
               
        //stage('Stop and Remove Container') {
        //    steps {
         //       script {
        //            def doc_containers = sh(returnStdout: true, script: 'docker container ps -aq').replaceAll("\n", " ") 
         //           if (doc_containers) {
        //                sh "docker stop ${doc_containers}"
        //            }
        //        }
        //    }
      //  }
    }
        post {
            always {
            // Clean up - stop and remove the Docker container
            sh 'docker stop stock_dashboard_container || true'
            sh 'docker rm stock_dashboard_container || true'
            }
        }        
}


