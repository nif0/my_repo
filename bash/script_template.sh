#!/bin/bash
#путь к пид-файлу
PID_FILE;

#путь к файлу с логами
#в лог пишутся все возникающие сообщения(STDIN,STDOUT) кроме тех, что выводятся через write_log
LOG_FILE;

#максимальный размер в байтах
MAX_LOG_SIZE;

#переменная с уровнем печати отладочных сообщений отладки
#уровень используется для скрытия/показа кастомных сообщений
#выводятся сообщения с уровнем логирования < LOG_LEVEL
# например:
# write_log 3 "HELLO"
# при LOG_LEVEL=0, 1, 2, 3 показано не будет. а с LOG_LEVEL=4 - выведет его на экран.
LOG_LEVEL; #0-5

#максимальное количество одновременно работающих копий скрипта
MAXIMUM_NUMBER_INSTANCES;

#переменная с путём к ini-файлу с настройками.
CONFIG;

PARAMETER;

#


function create_pid_file() 
{
    echo $$ >> $PID_FILE;
}

function delete_pid_file() {
    if [ -f $PID_FILE ]; then rm $PID_FILE; fi;
}

function write_log() #два аргумента: LEVEL, MESSAGE
{
    level=$1;
	message=$2;
    if [ "$level" -lt  "$LOG_LEVEL" ]; then 
	    echo "$date $message"; 
	fi;
}

#процедура чтения настроечных параметров из файла
#формат:
#name=value
#по итогам работы заполняет ассоциативный массив PARAMETER
function read_conf() 
{
    write_log 1 "read config file: $CONFIG"
	key;
	value;
    if [ -f "$CONFIG" ]; then 
	    while read line do
		write_log 2 "read line: $line";
		    tmp=$(echo $line | tr ";" "\n");
			key=${tmp[0]};
			value=${tmp[1]};
			write_log 3 "split line by \" key=$key value=$value";
			PARAMETER["$key"]="$value";
		done < $CONFIG;
	fi
}

#процедуры-обработчики событий

#процедура init. Действия, которые нужно выполнить перед тем, как перейти к осному коду скрипта.
#проверка требований к скрипту.
#команды здесь выполняются 1 раз.
function init() 
{
    #читаю переданные параметры
	#после совпадения с ключом делаю ещё 1 сдвиг, что бы прочитать значение.
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
				#перевод в байты
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

#связывание процедур-обработчиков с событиями. Чтение конфиг-файла

#процедура main. тут весь код.
function main() 
{

}

#что нужно сделать в самом конце работы скрипта.
#Команды в этой процедуре тоже выполняются 1 раз. 
function end_work()
{
    delete_pid_file();
}

init() $* ;
main();
end_work();