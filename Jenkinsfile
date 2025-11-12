node {
  def app
  stage('Checkout') {
    checkout scm   // 현재 브랜치(main)로 체크아웃
  }
  stage('Build image') {
    app = docker.build("jinseon901/test")
  }
  stage('Test image') {
    app.inside {
      sh 'make test'
    }
  }
  stage('Push image') {
    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
      app.push(env.BUILD_NUMBER)
      app.push('latest')
    }
  }
}
