node {
def app
stage('Clone repository') {
git 'https://github.com/jinseon901/donimoney.git'
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
docker.withRegistry('https://registry.hub.docker.com', 'jinseon901') {
app.push("${env.BUILD_NUMBER}")
app.push("latest")
}
}
}
