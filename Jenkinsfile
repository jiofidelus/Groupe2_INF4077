pipeline {
    agent any
    stages {
        stage('test') {
            steps {
                echo "test reussi!"
            }
        }

    stage('start'){
        steps {
            sh 'cd /var/www/Groupe2_INF4077 && sudo git reset --hard && sudo git pull && cd web-mobile && npm install'
        }
    }
    stage('build') {
        steps {
            sh 'cd /var/www/Groupe2_INF4077/web-mobile && sudo ionic build'

        }
    }
    stage('deploy') {
        steps {
            sh 'cd /var/www/Groupe2_INF4077/web-mobile && sudo pm2 start covidapp'
        }
    }
}


}
