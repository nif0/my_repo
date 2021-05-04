#!/bin/bash
declare PID_FILE="/tmp/pid";
declare LOG_FILE="/tmp/log";
declare MAX_LOG_SIZE;
declare LOG_LEVEL=3; #0-5
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

function write_log()
{
    echo $1 $2
    level=$1;
        message=$2;
    if [ "$level" -lt  "$LOG_LEVEL" ]; then
            echo "$date $message" >> $LOG_FILE;
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

function on_EXIT() {
    delete_pid_file;
    write_log 1 "exit";
}


function init() {
	#operating system signal processing
	trap on_EXIT EXIT;
        
	echo "$1";
        while [ -n "$1" ];
        do
        param=$1;
        echo $param;
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
		*) shift; ;;	
                esac;
        done;
    create_pid_file;
}

function main()
{
   write_log 4 "main test runing";
   write_log 4  test;
sleep 60;
write_log 4 test;
sleep 60;
write_log 4  test;
sleep 60;
write_log 4  test;
sleep 60;
write_log 4  test;
sleep 60;
}

function end_work()
{
   delete_pid_file;
}

init $* ;
main;
end_work;
