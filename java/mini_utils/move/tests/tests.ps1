#создаёт дерево каталогов с файлами.

[int] $max_branches=5;   #количество ветвей в одной директории
[int] $max_depth=5;      #максимальное количество каталогов
[int] $max_file_count;   #максимальное количество файлов в каталоге
[int] $max_file_size=20; #максимальный размер файла в Мб
[int] $i;                #переменная для счётчика   
[int] $file_size;        #размер файла.

[String] $run_path="F:\projects\java\mini_utils\move\move\out\artifacts\move_jar\move.jar";

#тестирую:
# 1. перемещение файлов
# 2. перемещение каталогов
# 3. перемещение группы файлов(по маске) в каталог
# 4. перемещение группы каталогов(по маске) в каталог

#echo "test 1";
#java -jar $run_path "F:\demo-big-20170815.sql" "F:\demo-big-20170815_1.sql"
#echo "test 2";
#java -jar $run_path "F:\demo-big-20170815_1.sql" "F:\demo-big-20170815.sql"
#echo "test 3"
#java -jar $run_path "F:\test_empty_catalog" "F:\test_empty_catalog_1"
#echo "test 4";
#java -jar $run_path "F:\test_empty_catalog_1" "F:\test_empty_catalog"
#echo "test 5";
#java -jar $run_path "F:\test_catalog_file" "F:\test_catalog_file_1"
#echo "test 6";
#java -jar $run_path "F:\test_catalog_file_1" "F:\test_catalog_file"
#echo "test 7 выбор файла по маске";
#java -jar $run_path "F:\*.sql" "F:\demo-big-20170815.sql"
echo "test 8 выбор файлов по маске и копирование в каталог";
java -jar $run_path "F:\*.sql" "F:\test 8\"
#Set-ExecutionPolicy Restricted;