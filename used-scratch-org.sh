
#!/bin/bash
JOB_NAME=$1
jobName=$(echo "$JOB_NAME" | sed -r 's/[/_]+//g')
USER_DIR="/home/azureuser/workspace/used-org-credentials/"
credentialsFile=$(ls "${USER_DIR}" | grep "^${jobName}_")
#credentialsFile=$(find "${USER_DIR}" -maxdepth 1 -name "${jobName}_*" -print -quit)
JOB_NAME=$(basename "${credentialsFile}" | cut -d '_' -f1)
if [ -z "$credentialsFile" ]; then
    echo "notFound"
elif [ "$jobName" = "$JOB_NAME" ]; then
    ORG_ALIAS="`head -n 1  /home/azureuser/workspace/used-org-credentials/${credentialsFile}`"
    USERNAME="`head -n 2  /home/azureuser/workspace/used-org-credentials/${credentialsFile} | tail -n 1`"
    PASSWORD="`tail -n 1  /home/azureuser/workspace/used-org-credentials/${credentialsFile}`"
    echo "${ORG_ALIAS}"
    echo "${USERNAME}"
    echo "${PASSWORD}"
else
    echo "Credentials not found for job: ${jobName}"
fi
