#! /bin/sh
if test "${SCHEDULE}" = "" ; then
  sh backup.sh
else
  exec go-cron "$SCHEDULE" /bin/sh backup.sh
fi