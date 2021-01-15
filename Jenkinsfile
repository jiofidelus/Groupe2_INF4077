pipeline {
    agent any
    stages {
        stage('test') {
            steps {
                echo "test reussi!"
            }
        }


        stage('build') {
            steps {
                sh 'pwd'
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
