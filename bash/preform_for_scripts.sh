ЗАГОТОВКА ДЛЯ СКРИПТОВ
#!/bin/bash

LOG_FILE=$0.log;
PID_FILE=$(pwd)/$(basename $0).PID;

exec 2>> $LOG_FILE;

function init() {
    echo $$ > $PID_FILE;
}

function exit_response() {
    if [ -f $PID_FILE ];.
        then rm $PID_FILE;
    fi;
    exit;
}

function sigterm_response() {
    if [ -f $PID_FILE ];.
        then rm $PID_FILE;
    fi;
    exit;
}

function end_work() {
    if [ -z "$1" ]; then 
        rm $PID_FILE;
        exit 0;
    else 
        rm $PID_FILE;
        exit $1;
    fi;
}

write_log() {
    echo $1;
    echo "$(date): $1" >> $LOG_FILE;
}

################################################################################################
trap "sigterm_response" SIGTERM;
trap "exit_response" EXIT;
if [ -f $PID_FILE ];
    then
    if [ "$(cat $PID_FILE)" -ne "$$" ];
    then
        write_log "запуску мешает другой процесс";
        write_log " $(ps -p $(cat $PID_FILE) -f | grep $n;) ";
        end_work 1;
    else write_log "скрипт уже запущен";
    fi;
fi;

init;
...
end_work;




