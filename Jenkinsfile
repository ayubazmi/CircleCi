pipeline {
    agent any

    environment {
        GIT_CREDENTIALS_ID = 'github-creds'
        REPO_URL = 'https://github.com/ayubazmi/Ruby-Rail-Private.git'
        BRANCH = 'main'
        NETWORK_NAME = 'myapp-network'

        // Docker Hub details
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub-creds'
        DOCKERHUB_USERNAME = 'ayubazmi'
        POSTGRES_IMAGE = "${DOCKERHUB_USERNAME}/my-postgres-db"
        RAILS_IMAGE = "${DOCKERHUB_USERNAME}/my-rails-app"
    }

    stages {
        stage('Clone Private Repo') {
            steps {
                git branch: "${BRANCH}",
                    url: "${REPO_URL}",
                    credentialsId: "${GIT_CREDENTIALS_ID}"
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh """
                    docker build -t ${POSTGRES_IMAGE}:${BUILD_NUMBER} -f Dockerfile.db .
                    docker build -t ${RAILS_IMAGE}:${BUILD_NUMBER} -f Dockerfile.app .
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                        docker push ''' + "${POSTGRES_IMAGE}:${BUILD_NUMBER}" + '''
                        docker push ''' + "${RAILS_IMAGE}:${BUILD_NUMBER}" + '''

                        docker logout
                        '''
                    }
                }
            }
        }

        stage('Update Kubernetes YAML with Image Tags') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${GIT_CREDENTIALS_ID}", usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
                    script {
                        sh '''#!/bin/bash
                        sed -i 's|image: ayubazmi/my-postgres-db:.*|image: ayubazmi/my-postgres-db:'"${BUILD_NUMBER}"'|' k8s/postgres-deployment.yaml
                        sed -i 's|image: ayubazmi/my-rails-app:.*|image: ayubazmi/my-rails-app:'"${BUILD_NUMBER}"'|' k8s/rails-deployment.yaml

                        git config user.name "Jenkins CI"
                        git config user.email "jenkins@example.com"

                        git add k8s/*.yaml
                        git commit -m "Update image tags to build ${BUILD_NUMBER}" || echo "No changes"

                        git push https://$GIT_USER:$GIT_TOKEN@github.com/ayubazmi/Ruby-Rail-Private.git HEAD:${BRANCH}
                        '''
                    }
                }
            }
        }

        stage('Create Network (if not exists)') {
            steps {
                script {
                    sh '''
                    docker network inspect ${NETWORK_NAME} >/dev/null 2>&1 || docker network create ${NETWORK_NAME}
                    '''
                }
            }
        }

        stage('Clean Up Existing Containers') {
            steps {
                script {
                    sh '''
                    docker rm -f postgres-db || true
                    docker rm -f rails-app || true
                    '''
                }
            }
        }

        stage('Run Containers') {
            steps {
                script {
                    sh """
                    docker run -d --name postgres-db --network ${NETWORK_NAME} ${POSTGRES_IMAGE}:${BUILD_NUMBER}
                    sleep 10
                    docker run -d --name rails-app --network ${NETWORK_NAME} -p 3000:3000 -e DB_HOST=postgres-db ${RAILS_IMAGE}:${BUILD_NUMBER}
                    """
                }
            }
        }

        stage('Wait for Manual Testing') {
            steps {
                echo "Sleeping for 60 seconds so you can access the app at http://localhost:3000..."
                sleep time: 60, unit: 'SECONDS'
            }
        }
    }
}
