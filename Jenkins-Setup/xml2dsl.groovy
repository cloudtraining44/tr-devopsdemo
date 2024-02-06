job("train-schedule") {
	description("train schedule")
	keepDependencies(false)
	scm {
		git {
			remote {
				github("cloudtraining44/cicd-pipeline-train-schedule-gradle", "https")
			}
			branch("*/master")
		}
	}
	disabled(false)
	triggers {
		githubPush()
	}
	concurrentBuild(false)
	steps {
		gradle {
			switches()
			tasks("build")
			fromRootBuildScriptDir()
			buildFile()
			gradleName("(Default)")
			useWrapper(true)
			makeExecutable(false)
			useWorkspaceAsHome(false)
		}
	}
	publishers {
		archiveArtifacts {
			pattern("dist/trainSchedule.zip")
			allowEmpty(false)
			onlyIfSuccessful(false)
			fingerprint(false)
			defaultExcludes(true)
		}
	}
}