//@Library('roboshop-jenkins-library') _  // declaring libray
//env.appName="ecomm-user"
//env.appType="nodejs"// sending a paramter to identify type|sice we dotn want to run compile for node
//ci_pipeline() //calling the pipeline-ci-jenkins-prjt-infra

node {
    // Define variables
    def appName = "docker-build-test"
    def dockerImage = "testrepo/${appName}"
    def gitRepo = "https://github.com/manupanand-freelance-developer/ecomm-user.git"

    stage('Checkout') {
        echo "Checking out source code from ${gitRepo}"
        checkout([$class: 'GitSCM',
            branches: [[name: '*/main']],
            userRemoteConfigs: [[url: gitRepo]]
        ])
    }

    stage('Build Docker Image') {
        echo "Building Docker image..."
        sh """
        docker build -t ${dockerImage}:latest .
        """
    }

    stage('List Images') {
        echo "Listing built Docker images..."
        sh "docker images | grep ${appName}"
    }

    echo "Docker image build completed successfully!"
}
