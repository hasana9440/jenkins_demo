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
                git branch: 'main', url: 'https://github.com/your-user/your-repo.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Building with Maven...'
                sh 'mvn clean install'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to server...'
                echo 'Deployment successful!'
            }
        }
    }
}
