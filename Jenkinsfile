pipeline {
    agent any
    tools {
        jdk 'jdk-21'
        maven 'maven-3.8.4'
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
        stage('Deploy') {
            steps {
                echo 'Deploying to server...'
                sh 'Docker run -d --name spring-api -p 9090:9090 simple_spring:latest
                echo 'Deployment successful!'
            }
        }
    }
}



