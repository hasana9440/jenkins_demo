pipeline{
	agent any
	tools{
		jdk 'jdk-21'
		maven 'maven-3.8.4'
	}
	stages{
		stage('checkout'){
			steps{
				echo 'cloning repository'
				git branch:'main', url : 
			}
		}
		stage('Build'){
			steps{
				echo 'Buliding with maven ........... '
				sh 'mvn clean install'
			}
		}
		stage('Deploy'){
			steps{
				echo 'Deploying to a server ....'
				echo 'Deployement successfull! '
			}
		}
	}
}