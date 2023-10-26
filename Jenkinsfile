pipeline {
    agent any

    stages {
        stage('Hello CICD') {
            steps {
                echo 'Hello everyone from Jenkins'
            }
        }
        stage('git clone'){
            steps {
                git branch: 'jenkins', url: 'https://github.com/kartik-neo/cloudbuild.git'
            }
        }
        stage('docker build stage and docker push stage'){
            steps {
                echo 'Authentication stage for push to GCR'
                sh 'gcloud auth activate-service-account test-438@kartik69.iam.gserviceaccount.com --key-file=/root/kartik69-45ca920360fe.json'
                sh 'gcloud auth configure-docker'
                sh 'sudo docker build . -t asia-south1-docker.pkg.dev/kartik69/test:v$BUILD_NUMBER'
                sh 'sudo docker push asia-south1-docker.pkg.dev/kartik69/test:v$BUILD_NUMBER'
            }
        }
        stage('email notification step to admin for approval and build information.') {
            steps {
                echo "Hello world"
                emailext to: "kartik.neosoft@.com",
                subject: "test mail $BUILD_NUMBER",
                body: "build number : $BUILD_NUMBER \n $BUILD_URL \n Approve or decline the build from console."
            }
        }
        stage('QA Team certification') {
            steps{
                input "Deploy to prod?"    
            }
        }
        stage("updating the service of cloud run"){
            steps{
                echo 'updating the service of cloud run with latest image using terraform'
                sh 'terraform init'
                sh 'terraform plan -var tags="v$BUILD_NUMBER"'
                sh 'terraform apply --auto-approve -var tags="v$BUILD_NUMBER"'
            }
        }

    }

}
