pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "pavankumar1605/simple-app"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE%:%BUILD_NUMBER% .'
                bat 'docker tag %DOCKER_IMAGE%:%BUILD_NUMBER% %DOCKER_IMAGE%:latest'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    bat 'echo %PASS% | docker login -u %USER% --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                bat 'docker push %DOCKER_IMAGE%:%BUILD_NUMBER%'
                bat 'docker push %DOCKER_IMAGE%:latest'
            }
        }

        stage('Deploy Container') {
            steps {
                bat 'docker stop simple-app || exit 0'
                bat 'docker rm simple-app || exit 0'
                bat 'docker run -d -p 5001:5000 --name simple-app %DOCKER_IMAGE%:latest'
            }
        }
    }
}