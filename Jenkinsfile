node {
	stage("Checkout"){
		checkout scm
	}
	stage("Build"){
		sh 'echo test Build'
	}

	stage("Test"){
		sh 'echo test Test'
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
