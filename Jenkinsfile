pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Salmankhan7798/vue.js-1.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image and tag it appropriately
                    sh 'docker build -t salmankhan7798/vue.js .'
                }
            }
        }

        stage('Docker Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push salmankhan7798/vue.js:latest'
            }
        }

        stage('Stop and Remove Old Container') {
            steps {
                script {
                    // Stop and remove the old container (if it exists)
                    sh 'docker stop vue.js-container || true'
                    sh 'docker rm vue.js-container || true'
                }
            }
        }

        stage('Deploy Docker Image') {
            steps {
                script {
                    // Run the new Docker container
                    sh 'docker run -d -p 80:80 --name vue.js-container salmankhan7798/vue.js'
                }
            }
        }
    }
}
