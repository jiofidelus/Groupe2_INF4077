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
            sh 'sudo cd /var/www/Groupe2_INF4077 && sudo git reset --hard && sudo git pull && cd web-mobile && sudo npm install'
        }
    }
    stage('build') {
        steps {
            sh 'sudo cd /var/www/Groupe2_INF4077/web-mobile && sudo ionic build'

        }
    }
    stage('deploy') {
        steps {
            sh 'sudo cd /var/www/Groupe2_INF4077/web-mobile && sudo pm2 start covidapp'
        }
    }
}


}
