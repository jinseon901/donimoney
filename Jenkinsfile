node {
  def app
  environment{
    PROJECT_ID = 'resonant-sunset-466808-s8'
    CLUSTER_NAME = 'kube'
    LOCATION = 'asia-northeast3-a'
    CREDENTIALS_ID = 'gke'
    DOCKER_IMAGE   = 'docker.io/jinseon901/test'
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
  stage('Deploy to GKE') {
    when { branch 'main' }
    steps {
      // deployment.yaml 안의 이미지 태그를 이번 빌드 태그로 교체
      sh """sed -i 's#${DOCKER_IMAGE}:[^[:space:]]*#${DOCKER_IMAGE}:${BUILD_NUMBER}#g' k8s/deployment.yaml"""
      step([$class: 'KubernetesEngineBuilder',
        projectId:     env.PROJECT_ID,
        clusterName:   env.CLUSTER_NAME,
        location:      env.LOCATION,
        credentialsId: env.CREDENTIALS_ID,
        manifestPattern: 'k8s/deployment.yaml,k8s/service.yaml', // 로드밸런서 서비스 포함
        verifyDeployments: true
      ])
    }
  }

}
