def BUILD_NUMBER=env.BUILD_NUMBER
def instanceUrl = 'https://login.salesforce.com'

// define stages to run in parallel to create and deploy package for numberOfOrgs provided from parameter
def stages = [failFast: true]
for (int i = 0; i < params.NUM_SCRATCH_ORGS.toInteger(); i++) {
    stages["Create and Deploy to Org ${SCRATCH_ORG_ALIAS}"] = {
        // Create number of org specified
        stage("Creating Org ${SCRATCH_ORG_ALIAS}") {
            sh 'sfdx force:org:create -a "${params.SCRATCH_ORG_ALIAS}${i}" -f project-scratch-def.json -d "${params.SCRATCH_ORG_DURATION_DAYS}"'
            def credentials = sh(script: "sfdx force:org:display -u ${params.SCRATCH_ORG_ALIAS}${i} --verbose --json", returnStdout: true)
            def username = credentials.username
            def password = credentials.password
            sh "mkdir -p scratch-org-credentials/${params.SCRATCH_ORG_ALIAS}${i}"
            sh "echo 'Username: ${username}\nPassword: ${password}' > scratch-org-credentials/${params.SCRATCH_ORG_ALIAS}${i}/credentials.txt"        }
    }
   
}
