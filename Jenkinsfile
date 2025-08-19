pipeline {
    agent any
    tools {
        jdk 'jdk-21'
        maven 'maven-3.8.4'
    }
    
    environment{
         // --- Docker / Deploy ---
        APP_NAME              = 'simple-spring-api'
        // <username>/<repo>
        DOCKER_IMAGE          = "hasana9440/${APP_NAME}"    
        CONTAINER_NAME        = 'simple-spring-api'
        // container port your app listens on
        APP_PORT              = '9090'                          
        // Jenkins credential (username+password) for registry login
        DOCKERHUB_CREDENTIALS = 'docker-credentials'
        // Optional: set a host port different from container port (e.g., '9595:9595')
        //HOST_PORT_MAPPING     = '9595:9595'
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: 'https://github.com/hasana9440/jenkins_demo.git '
            }
        }
        stage('Build') {
            steps {
                echo 'Building with Maven...'
                sh 'mvn clean install'
            }
        }
          stage('Test') {
            steps {
                echo 'Testing...'
                echo 'Testing done !'
            }
        }
        // stage('Deploy') {
        //     steps {
        //         echo 'Deploying to server...'
        //         sh 'Docker run -d --name spring-api -p 9090:9090 simple_spring:latest'
        //         echo 'Deployment successful!'
        //     }
        // }
        
        // stage to build the Docker image
        stage('Build Docker Image') {
            steps {
                script {
                    // Use a deterministic image tag per build (BUILD_NUMBER) and also tag as 'latest'
                    env.IMAGE_TAG = "${env.BUILD_NUMBER}"
                }
                sh """
                    echo "Building Docker image: ${DOCKER_IMAGE}:${IMAGE_TAG}"
                    docker build --pull -t ${DOCKER_IMAGE}:${IMAGE_TAG} -t ${DOCKER_IMAGE}:latest .
                """
            }
        }//build completed

         stage('Docker Push Image') {
            // when {
            //     branch 'main'
            // }
            steps {
                echo "Logging into registry and pushing ${DOCKER_IMAGE}:${IMAGE_TAG}"
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKERHUB_CREDENTIALS}",
                    usernameVariable: 'DOCKERHUB_USERNAME',
                    passwordVariable: 'DOCKERHUB_PASSWORD'
                )]) {
                    sh '''
                        echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
                        docker push ${DOCKER_IMAGE}:${IMAGE_TAG}
                        docker push ${DOCKER_IMAGE}:latest
                        docker logout || true
                    '''
                }
            }
        }//push completed
         post {
        // post actions for the entire pipeline
        always {
            echo 'Pipeline succeeded with status: ${currentBuild.currentResult}'
        }
    }

    }
}





