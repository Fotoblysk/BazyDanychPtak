node {
	stage("Checkout"){
		checkout scm
	}
	stage("Build"){
		sh 'echo test Build'
		docker-compose build
	}

	stage("Test"){
		sh 'echo test Test'
		docker-compose up -d
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
