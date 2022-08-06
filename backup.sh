if test "${SLACK_HOOK}" =  ""; then
  echo "You need to set the SLACK_HOOK environment variable."
  exit 1
fi

if test "${RCLONE_REMOTE}" =  ""; then
  echo "You need to set the SLACK_HOOK environment variable."
  exit 1
fi


FILENAME="${BACKUP_NAME:-mongodb}-backup-$(date +'%m%d%Y').sql.gz"

OUTPUT="data/backup/"
echo  $FILENAME

mongodump --host ${MONGO_HOST:-localhost} --port ${MONGO_PORT:-27017} --gzip  --gzip --archive=${FILENAME}

# ## send to cloud via rclone
rclone --config /rclone/rclone.conf copy ${FILENAME}  ${RCLONE_REMOTE}:mongodb

# ##Notify to slack
curl -X POST -H 'Content-type: application/json' \
 --data '{"text": "The Mongodb is backup complete at'" $FILENAME "'" }' \
 ${SLACK_HOOK}

## clean up
rm -rf ${OUTPUT}
rm -rf ${FILENAME}