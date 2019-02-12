#!/bin/bash

if [ $# -eq 0 ] || [ "$1" == "-?" ] || [ "$1" == "--help" ] || [ "$1" == "-h" ]
  then
    echo "Usage: `basename $0` <BITBUCKET_URL> <USER_NAME> <PROJECT_NAME> [<LOCAL_FOLDER>]"
    echo "e.g. `basename $0` somewhere.mybitbucketserver.com some_user some_project"
    exit 1
fi

[ "$4" ] || local_folder='./${3}'

# set git pw storing to 1 hour (supported only git-1.7.9 and later)
git config --global credential.helper cache
git config --global credential.helper "cache --timeout=3600"

curl -u ${2} http://${1}/rest/api/1.0/projects/${3}/repos?limit=100 > repos.json

for repo_name in `cat repos.json | jq -r '.values[] .slug'`
do
  echo "cloning" $repo_name
  git clone http://${2}@${1}/scm/${3}/$repo_name.git $local_folder/$repo_name
done
