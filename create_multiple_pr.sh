#!/bin/bash
curl_exec_for_windows="...../curl.exe"

USER="username:password"
BASE_URL=""
PROJECT=""
REPOSITORY=""
URL="https://$BASE_URL/rest/api/1.0/projects/$PROJECT/repos/$REPOSITORY/pull-requests"
TITLE=""
DESCRIPTION=""
SOURCE=""
TARGET=""
REVIEWERS=""

# CONTENT=" \
# { \
#   \"title\": \"$TITLE\", \
#   \"description\": \"$DESCRIPTION\", \
#   \"state\": \"OPEN\", \
#   \"fromRef\": { \
#     \"id\": \"refs/heads/$SOURCE\", \
#     \"repository\": { \
#       \"slug\": \"$REPOSITORY\", \
#       \"name\": null, \
#       \"project\": { \
#         \"key\": \"$PROJECT\" \
#       } \
#     } \
#   }, \
#   \"toRef\": { \
#     \"id\": \"refs/heads/$TARGET\", \
#     \"repository\": { \
#       \"slug\": \"$REPOSITORY\", \
#       \"name\": null, \
#       \"project\": { \
#         \"key\": \"$PROJECT\" \
#       } \
#     } \
#   }, \
#   \"reviewers\": [ $REVIEWERS ] \
# }"

# echo $CONTENT | $curl_exec_for_windows -X POST -H "Content-Type: application/json" --ssl --basic --user $USER -d @- $URL

$curl_exec_for_windows -X POST -H "Content-Type: application/json" -u $USER --basic https://$BASE_URL/rest/api/1.0/projects/$PROJECT/repos/$REPOSITORY/pull-requests -d '{ "title": "$TITLE", "description": "$DESCRIPTION", "fromRef": { "id": "$SOURCE", "repository": { "slug": "$REPOSITORY", "name": null, "project": { "key": "$PROJECT " }}}, "toRef": {"id": "$TARGET","repository":{"slug": "$REPOSITORY", "name": null, "project": {"key": "$PROJECT"}}}, "reviewers":[{"user":{"name": "$REVIEWERS"}}],"close_source_branch": false }'
