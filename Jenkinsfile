pipeline {
    agent any
    
    environment {
        // Define any environment variables you need
        ANSIBLE_CONFIG = "${WORKSPACE}/ansible/ansible.cfg"
        ANSIBLE_INVENTORY = "${WORKSPACE}/ansible/inventory.ini"
        JENKINS_PLAYBOOK = "${WORKSPACE}/ansible/playbooks/jenkins-playbook.yaml"
        BUILD_PLAYBOOK = "${WORKSPACE}/ansible/playbooks/build-playbook.yaml"
        DEPLOY_PLAYBOOK = "${WORKSPACE}/ansible/playbooks/deploy-playbook.yaml"
        
    }

    stages {
        stage('Pushing the Dockerfile on Build server') {
            steps {
                ansiblePlaybook(
                    playbook: "${env.JENKINS_PLAYBOOK}",
                    inventory: "${env.ANSIBLE_INVENTORY}",
                    extraVars: [
                        dockerfile_path: "${env.WORKSPACE}/Dockerfile",
                        destination_path: "/opt/"
                    ],
                    //colorized: true
                )
            }
        }
        
        stage('Build and Push Image') {
            steps {
                ansiblePlaybook(
                    playbook: "${env.BUILD_PLAYBOOK}",
                    inventory: "${env.ANSIBLE_INVENTORY}",
                    extraVars: [
                        BUILD_ID: "${env.BUILD_ID}",
			JOB_NAME: "${env.JOB_NAME}",
		        docker_hub_account: "lucifer181"
                    ],
                    //colorized: true
                )
            }
        }
        
        stage('Deploy Container on Deploy Server') {
            steps {
                ansiblePlaybook(
                    playbook: "${env.DEPLOY_PLAYBOOK}",
                    inventory: "${env.ANSIBLE_INVENTORY}",
                    extraVars: [
                        JOB_NAME: "${env.JOB_NAME}",
                        docker_hub_account: "lucifer181",
                        container_name: "web100"
                    ],
                    //colorized: true
                )
            }
        }
    }
}
