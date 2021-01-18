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
