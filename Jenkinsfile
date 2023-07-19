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
                        sh 'sudo docker build -t stock_dashboard .'

                        // Extract the API key from the environment variable
                        def stock = sh(returnStdout: true, script: 'echo $REACT_APP_API_KEY').trim()

                        // Run the Docker image with the API key as an environment variable
                        sh "sudo docker run -d -p 3000:3000 -e REACT_APP_API_KEY=${stock} stock_dashboard"
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
        stage('Smoke Test') {
            steps {
                //docker.image('stock_dashboard').run('-p 3000:3000 -e REACT_APP_API_KEY='+stock) &
                // Wait for the application to start
                sleep 30
                sh 'curl -f http://3.120.235.189:3000 || exit 1'
                }
            }
        //stage('Deploy to AWS ECR') {
        //    steps {
        //        script {
        //            sh 'aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 646148053375.dkr.ecr.eu-central-1.amazonaws.com'
        //            sh 'docker build -t frontend .'
        //            sh 'docker tag frontend:latest 646148053375.dkr.ecr.eu-central-1.amazonaws.com/frontend:latest'
        //            sh 'docker push 646148053375.dkr.ecr.eu-central-1.amazonaws.com/frontend:latest'
        //            }
        //        sleep 90
        //        }  
        //    }               
               
        //stage('Stop and Remove Container') {
        //    steps {
        //        script {
        //            def doc_containers = sh(returnStdout: true, script: 'docker container ps -aq').replaceAll("\n", " ") 
        //            if (doc_containers) {
        //                sh "docker stop ${doc_containers}"
        //            }
        //        }
        //    }
       // }
    }
}


