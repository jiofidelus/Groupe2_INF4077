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
                sh 'pwd'
                sh 'cd web-mobile'
                sh 'whoami'
                sh 'groups'
                sh 'pwd'
                sh 'cd web-mobile && sudo npm install'
                sh 'cd web-mobile && sudo ionic build'
            }
        }
        stage('deploy') {
            steps {
                echo "deploy successful"
            }
        }

    }


}
