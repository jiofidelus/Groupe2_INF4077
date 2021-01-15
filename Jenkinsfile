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
                sh 'npm install'
                sh 'ionic build'
            }
        }
        stage('deploy') {
            steps {
                echo "deploy successful"
            }
        }

    }


}
