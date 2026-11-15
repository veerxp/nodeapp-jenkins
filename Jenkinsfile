pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code from Git repository...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing all dependencies...'
                sh 'npm install --include=dev'
            }
        }

        stage('Automated Tests (CI Enhancement)') {
            steps {
                echo 'Running unit and integration tests with Jest...'
                sh 'npx jest --coverage'
            }
        }

        stage('Build & Package') {
            steps {
                echo 'Packaging application artifact...'
                sh 'npm pack'
                sh 'mkdir -p dist && mv *.tgz dist/'
            }
        }
    }

    post {
        always {
            echo 'Archiving test results and coverage reports...'
            archiveArtifacts artifacts: 'coverage/**', allowEmptyArchive: true
        }
        success {
            echo 'Build and tests completed successfully! Archiving release package...'
            archiveArtifacts artifacts: 'dist/*.tgz', fingerprint: true
        }
        failure {
            echo 'Pipeline failed during execution. Please check console logs.'
        }
    }
}
