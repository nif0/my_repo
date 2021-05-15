#тесты с каталогами
#работают без ошибок
#переименование каталога
echo "start test1"
echo 1;
..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f2_ F:\git\my_repo\java\mini_utils\move\tests\f2
sleep 10;
echo 2;
..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f2 F:\git\my_repo\java\mini_utils\move\tests\f2_
sleep 10;
echo 3;
..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f2_ F:\git\my_repo\java\mini_utils\move\tests\f2
sleep 10;
echo "start test2"

#перемещение
echo 1 
..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f2 F:\git\my_repo\java\mini_utils\move\tests\f1\
sleep 10;
echo 2;
..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f1\f2 F:\git\my_repo\java\mini_utils\move\tests\f2
sleep 10;
echo 3;
..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\f1\f2 F:\git\my_repo\java\mini_utils\move\tests\f2
sleep 10;
echo 4;
..\move\out\artifacts\move_jar\move.jar ..\tests\f2 ..\tests\f1\f2
sleep 10;
echo 5;
..\move\out\artifacts\move_jar\move.jar ..\tests\f1\f2 ..\tests\f2

echo "start test33";
#одиночные файлы
#работают с ошибками.
#после перемещения вв начале имени добавляется знак ; Востальном перемещения работают.
#test1_result.txt -> ;test1_result.txt

sleep 10;
#;test1_result.txt ->
echo 1;
..\move\out\artifacts\move_jar\move.jar "..\tests\;test1_result.txt" "F:\git\my_repo\java\mini_utils\move\tests\"
## -> ;;test1_result.txt

#
sleep 10;
..\move\out\artifacts\move_jar\move.jar F:\git\my_repo\java\mini_utils\move\tests\test1_result.txt ..\tests\f2\
sleep 10;
..\move\out\artifacts\move_jar\move.jar "..\tests\f2\;;;;test1_result.txt" "F:\git\my_repo\java\mini_utils\move\tests\"



#группы файлов. Имя задаётся регуляркой.
# работает
sleep 10;
..\move\out\artifacts\move_jar\move.jar "F:\git\my_repo\java\mini_utils\move\tests\^.*.txt" F:\git\my_repo\java\mini_utils\move\tests\
sleep 10;
..\move\out\artifacts\move_jar\move.jar "F:\git\my_repo\java\mini_utils\move\tests\f1\^.*.txt" F:\git\my_repo\java\mini_utils\move\tests\
#sleep 30
sleep 10;
..\move\out\artifacts\move_jar\move.jar "F:\git\my_repo\java\mini_utils\move\tests\^.*.txt" F:\git\my_repo\java\mini_utils\move\tests\f1\