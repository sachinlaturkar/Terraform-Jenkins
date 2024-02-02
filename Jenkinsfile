pipeline {
    parameters {
        booleanParam(
            name: 'autoApprove',
            defaultValue: false,
            description: 'Automatically run apply after generating plan?'
        )
    }

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/yeshwanthlm/Terraform-Jenkins.git'
            }
        }

        stage('Plan') {
            steps {
                script {
                    bat 'cd C:\\terraform\\ && terraform init'
                    bat 'cd C:\\terraform\\ && terraform plan -out tfplan'
                    bat 'cd C:\\terraform\\ && terraform show -no-color tfplan > tfplan.txt'
                }
            }
        }

        stage('Approval') {
            when {
                expression { params.autoApprove == false }
            }

            steps {
                script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: 'Do you want to apply the plan?',
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            when {
                expression { params.autoApprove == true }
            }

            steps {
                script {
                    bat 'cd C:\\terraform\\ && terraform apply -input=false tfplan'
                }
            }
        }
    }
}
