
#!/bin/bash
orgsDir="/home/azureuser/workspace/scratch-org-credentials/"
JOB_NAME=$1
jobName=$(echo "$JOB_NAME" | sed -r 's/[/_]+//g')
if [ -d $orgsDir ]; then
    oldestFile=""
    oldestTime=""
    for orgFile in $(ls -t $orgsDir); do
        if [ -f "/home/azureuser/workspace/scratch-org-credentials/$orgFile" ]; then
            #echo "Processing: ${orgFile}"
            #echo "File stat: $(stat -c '%y' /home/azureuser/workspace/scratch-org-credentials/$orgFile)"
            fileTime=$(stat -c %Y "/home/azureuser/workspace/scratch-org-credentials/$orgFile")
            if [ -z "$oldestTime" ] || [ "$fileTime" -lt "$oldestTime" ]; then
                oldestTime=$fileTime
                oldestFile=$orgFile
            fi
        fi    
    done
    #echo "Oldest file: /home/azureuser/workspace/scratch-org-credentials/${oldestFile}"
    #echo "File stat: $(stat -c '%y' $JENKINS_HOME/scratch-org-credentials/${oldestFile})"
    ORG_ALIAS="`head -n 1 /home/azureuser/workspace/scratch-org-credentials/${oldestFile}`"
    USERNAME="`head -n 2 /home/azureuser/workspace/scratch-org-credentials/${oldestFile} | tail -n 1`"
    PASSWORD="`tail -n 1 /home/azureuser/workspace/scratch-org-credentials/${oldestFile}`"
    echo "${ORG_ALIAS}"
    echo "${USERNAME}"
    echo "${PASSWORD}"
    echo "$(basename "$0")"
    mv "/home/azureuser/workspace/scratch-org-credentials/${oldestFile}" "/home/azureuser/workspace/used-org-credentials/${jobName}_${oldestFile}"
else
    echo "Directory $orgsDir not found"
fi
