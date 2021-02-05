pipeline {
    agent any
    stages {
        stage('test') {
            steps {
                echo "bonjour essay"
            }
        }


        stage('build') {
            steps {
                echo "I am build"
                sh 'whoami'
                sh 'groups'
                sh 'pwd'
            }
        }
        stage('deploy') {
            steps {
                echo "deploy successfully"
            }
        }

    }


}
