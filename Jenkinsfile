node {
	stage("Checkout"){
		checkout scm
	}
	stage("Build"){
		sh 'echo test Build'
		sh 'docker-compose build'
	}

	stage("Test"){
		sh 'echo test Test'
		sh 'docker-compose up -d'
		sh 'sleep 10s'
		sh 'docker-compose down'
	}

	if(env.BRANCH_NAME == 'master'){
		stage("Upload"){
			dir("."){
				sh './deploy/scriptsForJenkinsfile/upload.sh'
			}
		}

		stage("Deploy"){
			dir("."){
				sh './deploy/scriptsForJenkinsfile/deploy.sh'
			}
		}
	}
}
