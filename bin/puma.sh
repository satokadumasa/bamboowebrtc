#!/bin/bash
. /lib/lsb/init-functions
. ~/.rvm/scripts/rvm
# or for rbenv installed with Chef:
# . /etc/profile.d/rbenv.sh

PWD=~/ecore/src/jvm_bridge
PIDFILE=$PWD/tmp/pids/puma.pid
STATUSFILE=$PWD/tmp/pids/state.pid
PORT=4002
#WORKERS=2 # doesn't work on JRuby or Windows
DAEMON=binstubs/puma
PUMACTL=binstubs/pumactl
START_OPTIONS="-b tcp://0.0.0.0:$PORT -e production --pidfile $PIDFILE -S $STATUSFILE"
[ ! -z $WORKERS ] && START_OPTIONS+=" -w $WORKERS --preload"
RELOAD_SIGNAL=USR2

cd $PWD

do_start()
{
  pidofproc -p $PIDFILE $DAEMON && return
  # start_daemon doesn't provide a detach (--background) option
  #start_daemon -p $PIDFILE $DAEMON $START_OPTIONS
  /sbin/start-stop-daemon --start --quiet --oknodo --chdir $PWD --pidfile $PIDFILE \
    --background --exec $DAEMON -- $START_OPTIONS
  echo starting $DAEMON
  x=0
  while [ "$x" -lt 20 -a ! -e $PIDFILE ]; do
    x=$((x+1))
    sleep 1
    echo -n .
  done
  if [ ! -e $PIDFILE ]; then
    echo Pidfile was not created in 20s
    exit 1
  fi
  echo started with pid `cat $PIDFILE`
}

do_stop()
{
  pidofproc -p $PIDFILE $DAEMON && killproc -p $PIDFILE
  rm -f $PIDFILE $STATUSFILE
}

case "$1" in
  start)
    do_start
    ;;
  stop)
    do_stop
    ;;
  status)
    status_of_proc -p $PIDFILE $DAEMON
    ;;
  puma-stop)
    $PUMACTL -P $PIDFILE -S $STATUSFILE stop
    ;;
  halt)
    $PUMACTL -P $PIDFILE -S $STATUSFILE halt
    ;;
  puma-status)
    $PUMACTL -P $PIDFILE -S $STATUSFILE status
    ;;
# phased-restart doesn't work in JRuby or when --preload is specified
#  reload)
#    $PUMACTL -P $PIDFILE -S $STATUSFILE phased-restart
#    ;;
  restart)
    $PUMACTL -P $PIDFILE -S $STATUSFILE restart
    ;;
  force-restart)
    do_stop
    do_start
    ;;
esac
exit 0

