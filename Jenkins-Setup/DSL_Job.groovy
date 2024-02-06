job('demo-dsl-seed') {
    description("First DSL Job")
    scm {
        github('jenkinsci/job-dsl-plugin', 'master')
    }
    steps {
        gradle('clean build')
    }
}