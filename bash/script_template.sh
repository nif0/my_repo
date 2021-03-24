#!/bin/bash
declare PID_FILE
declare LOG_FILE;
declare MAX_LOG_SIZE;
declare LOG_LEVEL; #0-5
declare MAXIMUM_NUMBER_INSTANCES;
declare CONFIG;
declare PARAMETER;

function create_pid_file()
{
    echo $$ >> $PID_FILE;
}

function delete_pid_file() {
    if [ -f $PID_FILE ]; then rm $PID_FILE; fi;
}

function write_log() #<D0><B4><D0><B2><D0><B0> <D0><B0><D1><80><D0><B3><D1><83><D0><BC><D0><B5><D0><BD><D1><82><D0><B0>: LEVEL, MESSAGE
{
    level=$1;
        message=$2;
    if [ "$level" -lt  "$LOG_LEVEL" ]; then
            echo "$date $message";
        fi;
}

function read_conf()
{
    write_log 1 "read config file: $CONFIG"
        key;
        value;
    if [ -f "$CONFIG" ]; then
            while read line; do
                write_log 2 "read line: $line";
                tmp=$(echo $line | tr ";" "\n");
                key=${tmp[0]};
                value=${tmp[1]};
                write_log 3 "split line by \" key=$key value=$value";
                PARAMETER["$key"]="$value";
            done < $CONFIG;
    fi
}


function init()
{
        while [ -n "$1" ];
        do
        param=$1;
            case "$param" in
                -config)
                    shift;
                    read_conf $1 ;;
                -log)
                    shift;
                        LOG_FILE=$1 ;;
                -pid)
                    shift;
                        PID_FILE=$1 ;;
                -instance)
                    shift;
                        MAXIMUM_NUMBER_INSTANCES=$1 ;;
                -log-size)
                    shift;
                        s=$1;
                        len=$(expr length $s);
                        mask=$(expr match $s [0-9]*[GMKBb]$);
                        MAX_LOG_SIZE=${s:0:$len-1};
                        if [ $len -eq $mask ]; then
                            pref=${s:$len-1:$len};
                                case "$pref" in
                                    b) MAX_LOG_SIZE=$(math $MAX_LOG_SIZE/8) ;;
                                        B) MAX_LOG_SIZE=$MAX_LOG_SIZE ;;
                                        K) MAX_LOG_SIZE=$(math $MAX_LOG_SIZE*1024) ;;
                                        M) MAX_LOG_SIZE=$(math $MAX_LOG_SIZE*1024*1024) ;;
                                        G) MAX_LOG_SIZE=$(math $MAX_LOG_SIZE*1024*1024*1024) ;;
                                esac;
                                unset pref;
                        fi;
                        unset s;
            unset len;
            unset mask;
                        ;;
                esac;
        done;
}

function main()
{
    echo "main";
}

function end_work()
{
echo     delete_pid_file;
}

init $* ;
main;
end_work;
