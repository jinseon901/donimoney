node {
  def app
  environment{
    PROJECT_ID = 'resonant-sunset-466808-s8'
    CLUSTER_NAME = 'kube'
    LOCATION = 'asia-northeast3-a'
    CREDENTIALS_ID = 'gke'
  }
  stage('Checkout') {
    checkout scm   // 현재 브랜치(main)로 체크아웃
  }
  stage('Build image') {
    app = docker.build("jinseon901/test")
  }
  stage('Test image') {
    app.inside {
      sh 'npm ci'
      sh 'npm test'
    }
}
  stage('Push image') {
    docker.withRegistry('https://registry.hub.docker.com', 'jinseon901') {
      app.push(env.BUILD_NUMBER)
      app.push('latest')
    }
  }
}
