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
                sh 'npm install'
                sh 'ionic build'
            }
        }
        stage('deploy') {
            steps {
                echo "deploy reussi"
            }
        }
       
    }


}
