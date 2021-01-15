pipeline {
    agent any
    stages {
        stage('test') {
            steps {
                echo "test reussi"
            }
        }

        stage('build') {
            steps {
                sh 'cd web-mobile'
                sh 'whoami'
                sh 'groups'
                sh 'sudo npm install'
                sh 'sudo ionic build'
            }
        }
        stage('deploy') {
            steps {
                echo "deploy successful"
            }
        }

    }


}
