# Dockerize-Mongo-Backup-Rclone


Backup MongoDB to cloud via rclone

## Usage

Docker:
```
docker run -v ./rclone/rclone.conf:/rclone/rclone.conf -e MONGO_HOST=[MONGO_HOST] -e SLACK_HOOK=[Link SLACK_HOOK]  -e SCHEDULE="@every 1D" ghcr.io/lyquyduong/mongo-backup-rclone:latest
```

Docker Compose:
```yaml
mongodb:
  image: mongo:latest

mongodb-backup:
  image: ghcr.io/lyquyduong/mongo-backup-rclone:latest
  depends_on:
    - mongodb
  links:
    - mongodb
  environment:
    - SCHEDULE: '@daily'
    - SLACK_HOOK: [Link SLACK_HOOK]
    - RCLONE_REMOTE: [RCLONE_REMOTE]
```

### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@daily"` to run the backup automatically.

For example, "@every 1h30m10s" would indicate a schedule that activates after 1 hour, 30 minutes, 10 seconds, and then every interval after that.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).

### Variable  environmen

- MONGO_HOST: host mongodb
- MONGO_PORT: port mongodb
- BACKUP_NAME: The filename will have same pattern ${BACKUP_NAME:-mongodb}-backup-$(date +'%m%d%Y').sql.gz. If not provide it's will *mongodb*
- SLACK_HOOK: the end point will notify to when task complete
- RCLONE_REMOTE: Remote profile in rclone.conf
- SCHEDULE: 
### Endpoints for Slack webhook

Access https://api.slack.com/messaging/webhooks and create new application.
