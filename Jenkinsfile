pipeline {
    agent any




    stages {

         stage('Building and teting the go backend') {
            steps {
              dir("./go_backend") {
                  sh "sudo go build main.go"
                  echo "GOOD, ALL TEST SUCCEEDED"
              }
            }
         }

        stage('Cloning production code') {
          steps {
            sh script:'''
                    #!/bin/bash
                    cd /var/www/Groupe2_INF4077
                    git reset HEAD --hard
                    git pull
                  '''
          }
       }

       stage('Building production code') {
         steps {
           sh script:'''
                   #!/bin/bash
                   pwd
                   cd /var/www/Groupe2_INF4077/go_backend
                   go build main.go
                 '''
         }
      }


       stage('Deploying production code') {
         steps {
           sh "sudo service goapp restart"
          }
      }

        stage('Testing go app') {
            steps {
                sh "curl http://localhost:8100"
            }
        }


        stage('deploy') {
            steps {
                echo "deploy successfully"
            }
        }

    }


}
