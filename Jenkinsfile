def branch = "main"
def remote = "origin"
def directory = "~/jenkins/wayshub-frontend"
def server = "tanu96@103.150.116.19"
def cred = "batch24ssh"

pipeline {
    agent any

    stages {

        stage('repo pull') {
            steps {
                sshagent([cred]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    git pull ${remote} ${branch}
                    exit
                    EOF
                    """
                }
            }
        }

        stage('docker clean') {
            steps {
                sshagent([cred]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${server} << EOF
                    echo "Menghentikan dan menghapus container lama (frontend)..."
                    docker rm -f frontend || true

                    echo "Menghapus image lama (dumbflix-fe)..."
                    docker rmi -f dumbflix-fe || true
                    exit
                    EOF
                    """
                }
            }
        }

        stage('docker build') {
            steps {
                sshagent([cred]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${server} << EOF
                    cd ${directory}
                    docker build -t dumbflix-fe .
                    exit
                    EOF
                    """
                }
            }
        }

        stage('docker run') {
            steps {
                sshagent([cred]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${server} << EOF
                    docker run -d -p 3001:3000 --tty --name frontend dumbflix-fe
                    exit
                    EOF
                    """
                }
            }
        }
    }
}
