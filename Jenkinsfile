pipeline {
  agent any
  stages {
    stage('Clone repo') {
      steps {
        git url: 'git@github.com:dmeulen/ndocker-journalbeat.git', credentialsId: '62c172ed-19c0-4cfd-b6da-0f567c4ee1b5'
      }
    }
    stage('Build image') {
      steps {
        sh 'make build'
      }
    }
    stage('Deploy image') {
      steps {
        withDockerRegistry([ credentialsId: 'theanimaldock-dockerhub', url: '' ]) {
          sh 'make -e VERSION=$GIT_COMMIT tag'
          sh 'make -e VERSION=$GIT_COMMIT push'
        }
      }
    }
  }
}
