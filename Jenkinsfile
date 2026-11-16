
pipeline {
    agent any

    environment {
        VIRTUAL_ENV = 'venv'
    }

    stages {
        stage('Setup') {
            steps {
                script {
                    if (!fileExists("${env.WORKSPACE}/${VIRTUAL_ENV}")) {
                        sh "python3 -m venv ${VIRTUAL_ENV}"
                    }

                    sh "source ${VIRTUAL_ENV}/bin/activate && pip install -r requirements.txt"
                }
            }
        }

        stage('Lint') {
            steps {
                sh "source ${VIRTUAL_ENV}/bin/activate && flake8 app.py tests/"
            }
        }

        stage('Test') {
            steps {
                sh "source ${VIRTUAL_ENV}/bin/activate && python -m unittest discover -s tests -v"
            }
        }

        stage('Coverage') {
            steps {
                sh "source ${VIRTUAL_ENV}/bin/activate && coverage run -m unittest discover -s tests -v && coverage report"
            }
        }

        stage('Security Scan') {
            steps {
                sh "source ${VIRTUAL_ENV}/bin/activate && bandit -r app.py -ll"
            }
        }

        stage('Deploy') {
            steps {
                sh 'chmod +x deploy.sh && ./deploy.sh'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
