//@Library('roboshop-jenkins-library') _  // declaring libray
//env.appName="ecomm-user"
//env.appType="nodejs"// sending a paramter to identify type|sice we dotn want to run compile for node
//ci_pipeline() //calling the pipeline-ci-jenkins-prjt-infra

node {
    // Define variables
    def appName = "mlops-app"
    def dockerRegistry = "docker.io"
    def dockerImage = "yourdockerhubusername/${appName}"
    def gitRepo = "https://github.com/manupanand-freelance-developer/ecomm-user.git"

    stage('Checkout') {
        echo "Checking out source code from ${gitRepo}"
        checkout([$class: 'GitSCM', 
            branches: [[name: '*/main']], 
            userRemoteConfigs: [[url: gitRepo]]
        ])
    }

    stage('Build') {
        echo "Building Docker image..."
        sh """
        docker build -t ${dockerImage}:latest .
        """
    }

    stage('Login to Docker Registry') {
        echo "Logging into Docker Registry..."
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin ${dockerRegistry}"
        }
    }

    stage('Push Image') {
        echo "Pushing Docker image to registry..."
        sh """
        docker push ${dockerImage}:latest
        """
    }

    stage('Cleanup') {
        echo "Cleaning up local images..."
        sh "docker rmi ${dockerImage}:latest || true"
    }

    echo "✅ Build and push completed successfully!"
}
