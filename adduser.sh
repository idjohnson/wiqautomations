#!/bin/bash

set +x

# e.g.


if [ "$#" -eq 0 ] ; then
   echo "USAGE: $0 [AzDO PAT] userid Team Project [License type/skip]"
   echo ""
   echo "e.g. $0 PAT user@company.com \"MyProject Team\" MyProject stakeholder"
   echo "        * would add user@company to the IAM team in MyProject"
   exit
fi
# to auth to AzDO now (az devops login no longer works)
export AZURE_DEVOPS_EXT_PAT=$1

if [[ -n $2 ]]; then 
	echo "user: $2"
fi
if [[ -n $3 ]]; then 
	echo "group: $3"
fi
if [[ -n $4 ]]; then 
	echo "Project: $4"
fi
if [[ -n $5 ]]; then 
	echo "License: $5"
fi

# set security group name
descName="[$4]\\\\$3"

# add user (if there, is ignored)
# express (basic) or stakeholder.. no way to do MSDN yet
if [[ "$5" == "skip" ]] ; then
   echo "Skipping user add/license"
else
   az devops user add --email-id $2 --license-type $5 --organization https://dev.azure.com/princessking/
fi

# verify if user is there already
az devops team list-member --organization https://dev.azure.com/princessking/ --project $4  --team "$3" | grep $2

# get sec group id we need
secId=`az devops security group list --organization https://dev.azure.com/princessking/ --project $4 | jq ".graphGroups[] | select(.principalName == \"$descName\") | .descriptor" | sed s/\"//g`

# verification of values
echo "$descName : $secId"

# add user to group (team)
az devops security group membership add --group-id $secId --member-id $2 --organization https://dev.azure.com/princessking/

# proof we added user
az devops team list-member --organization https://dev.azure.com/princessking/ --project $4  --team "$3" | grep $2

