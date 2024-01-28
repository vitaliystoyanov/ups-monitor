#! /bin/sh -e

# ps -e -o "pid,command=" | awk 'index($2, "/opt/local/bin/bcmxcp_usb") != 0 {print $1}'

bcmxcp_pid=$(ps -e -o "pid,command=" | awk 'index($2, "/opt/local/bin/bcmxcp_usb") != 0 {print $1}')

echo 'Running bcmxcp pid checker [1s]...'

while :
do
  pid=$(ps -e -o "pid,command=" | awk 'index($2, "/opt/local/bin/bcmxcp_usb") != 0 {print $1}')
  if [ $bcmxcp_pid != $pid ]; then
    echo "bcmxcp_usb pid changed [$bcmxcp_pid -> $pid]"
    bcmxcp_pid=$pid
    upsd_pid=$(ps -e -o "pid,command=" | awk 'index($2, "/opt/local/sbin/upsd") != 0 {print $1}')
    kill -9 $upsd_pid
    echo "upsd [$upsd_pid] restarted"
  fi
  sleep 1
done
