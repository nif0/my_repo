#тесты с каталогами
#работают без ошибок
#переименование каталога
#..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f2 F:\git\my_repo\java\mini_utils\move\tests\f2_
#sleep 10;
#..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f2_ F:\git\my_repo\java\mini_utils\move\tests\f2
sleep 10;
echo "start test2"

#перемещение 
#..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f2 F:\git\my_repo\java\mini_utils\move\tests\f1\
#..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f1\f2 F:\git\my_repo\java\mini_utils\move\tests\f2
#..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f1\f2 F:\git\my_repo\java\mini_utils\move\tests\f2
#..\move\out\artifacts\move_jar\move.jar ..\tests\f2 ..\tests\f1\f2
#..\move\out\artifacts\move_jar\move.jar ..\tests\f1\f2 ..\tests\f2

#одиночные файлы
#работают с ошибками.
#после перемещения вв начале имени добавляется знак ; Востальном перемещения работают.
#test1_result.txt -> ;test1_result.txt


#;test1_result.txt ->
##..\move\out\artifacts\move_jar\move.jar "..\tests\;test1_result.txt" "F:\git\my_repo\java\mini_utils\move\tests\"
## -> ;;test1_result.txt

#
#..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\test1_result.txt ..\tests\f2\
#..\move\out\artifacts\move_jar\move.jar "..\tests\f2\;;;;test1_result.txt" "F:\git\my_repo\java\mini_utils\move\tests\"



#группы файлов. Имя задаётся регуляркой.
#полностью не работает
..\move\out\artifacts\move_jar\move.jar "F:\git\my_repo\java\mini_utils\move\tests\f1\^.*.txt" F:\git\my_repo\java\mini_utils\move\tests\