СКРИПТ АРХИВАЦИИ
#!/bin/bash

LOG_FILE=;
ERR_LOG=;
PID_FILE=;
REMOVE="--remove-files"
declare -ir DEPTH_HOURS=24;
declare -ir MAX_COPROC=6;
declare -i ACTIV_COPROC=0;
declare -a COPROCESSES;

#ARC_PATH[0]=""
ARC_PATH[0]=""
#ARC_PATH[1]=""
ARC_PATH[2]=""
#ARC_PATH[3]=""
#ARC_PATH[4]=""
#ARC_PATH[5]=""
ARC_PATH[6]=""
#ARC_PATH[7]=""
#ARC_PATH[8]=""
#ARC_PATH[9]=""
ARC_PATH[10]=""
#ARC_PATH[11]=""
#ARC_PATH[12]=""
exec 2>> $ERR_LOG;

function moving_file() {
    #$1 - $WHERE
    #$2 - $i    это HOUR_NUMBER
    #WATCH_HOUR_FROM="$(date -d "-$(echo $2) hours" +"%h %d %H")"
    #WATCH_HOUR_TO="$(date -d "-$(echo $2-1|bc) hours" +"%h %d %H")"
    ARCHIVE_DIR="$(date -d "-$(echo $2) hours" + "%Y%m%d_%H")"
    ARCHIVE_PATH=$1/../arc-files/$ARCHIVE_DIR
    #echo "Searching date $WATCH_HOUR_FROM - $WATCH_HOUR_TO > directory $ARCHIVE_DIR"
    mkdir -p $ARCHIVE_PATH
    find $2 -maxdepth 1 -type f -mmin +10 !  -newermt "$(date -d "-$(echo $2) hours" +"%h %d %H")" ! -newermt "$(date -d "$(echo -1*$2+1|bc) hours" +"%h %d %H")" | xargs -P 6 -I NAME mv NAME $ARCHIVE_PATH ;
}

function update_coprocesscount() {
    ACTIV_COPROC=0;
    for c in $(seq 0  $MAX_COPROC); do
        #echo $c;
        if read -t 0 -u "${COPROCESSES[$c][0]}" line; ACTIV_COPROC=$(($ACTIV_COPROC+1)); then continue; else ACTIV_COPROC=$(($ACTIV_COPROC-1)); fi;
    done;
}

function init() {
    echo $$ > $PID_FILE;
}

function exit_response() {
    if [ -f $PID_FILE ];
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
#    echo $1;
    echo "$(date): $1" >> $LOG_FILE;
}

################################################################################################
trap "sigterm_response" SIGTERM;
trap "exit_response" EXIT;
if [ -f $PID_FILE ];
    then
    if [ "$(cat $PID_FILE)" -ne "$$" ];
    then
        write_log "запуску мешает другой процесс"
        echo " $(ps -p $(cat $PID_FILE) -f | grep $n;) "
    else init;
    fi;
    else init;
fi;

init;
#поехали!!!!
CUR_DATE="$(date)";
echo "$CUR_DATE Start Moving";
for WHERE in ${ARC_PATH[@]}; do
    #mkdir -p $WHERE/arch
    CNT_FILES="$(ls -1 $WHERE | wc -l)";
    echo "Searching oldest file for $WHERE $CNT_FILES";
        for i in $(seq 0 $DEPTH_HOURS); do
            if (( $ACTIV_COPROC < $MAX_COPROC-1 ))
            then
                for c in $(seq 0  $MAX_COPROC); do
                    if read -t 0 -u "${COPROCESSES[$c][0]}" line; then continue; else coproc COPROCESSES[$c] { moving_file $WHERE $i; }; break; fi;
                done;
            fi
            update_coprocesscount;
        done;
done;

#find ./ -maxdepth 1 -mindepth 1 -type f -mtime +0 | xargs -P 6 -I NAME tar --remove-files -czf NAME.tar.gz NAME ;

#for WHERE in ${ARC_PATH[@]}; do
#    cd $WHERE;
#    find ./ -maxdepth 1 -mindepth 1 -type f -mtime +0 | xargs -P 6 -I NAME tar --remove-files -czf NAME.tar.gz NAME ;
#done;

CUR_DATE="$(date)"
write_log "$CUR_DATE End Moving"
#архивация файлов
#write_log "Start archiving files from $WHERE";

end_work;


