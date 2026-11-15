pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code from Git repository...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing project dependencies with npm ci...'
                sh 'npm ci'
            }
        }

        stage('Automated Tests (CI Enhancement)') {
            steps {
                echo 'Running unit and integration tests with Jest...'
                sh 'npm test'
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
