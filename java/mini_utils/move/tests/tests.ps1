#тесты с каталогами
#работают без ошибок
#стартовая локация: F:\git\my_repo\java\mini_utils\move\tests

#переименование каталога. несуществующий каталог
echo "start test1 renaming a folder";
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test1\f2 ..\tests\test1\f2_ | Out-File ..\tests\test1\test_1-1_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test1\f2_ ..\tests\test1\f2 | Out-File ..\tests\test1\test_1-2_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test1\f1 ..\tests\f1_rename | Out-File ..\tests\test1\test_1-3_result.txt;


#перемещение каталога
echo "start test 2 moving a folder"
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f2 ..\tests\test2\f1\   | Out-File ..\tests\test2\test_2-1_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f1\f2 ..\tests\test2\f2 | Out-File ..\tests\test2\test_2-2_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f1\f2 ..\tests\test2\f2 | Out-File ..\tests\test2\test_2-3_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f2 ..\tests\test2\f1\f2 | Out-File ..\tests\test2\test_2-4_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f1\f2 ..\tests\test2\f2 | Out-File ..\tests\test2\test_2-5_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f1 ..\tests\test2\f2\    | Out-File ..\tests\test2\test_2-6_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f2\f1 ..\tests\test2\f1    | Out-File ..\tests\test2\test_2-6_result.txt;

echo "start test3 moving a single file";
#перемещение одиночного файла

java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test3\f1\test1_result.txt ..\tests\test3\f2\ | Out-File ..\tests\test3\test_3-1_result.txt
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test3\f2\test1_result.txt ..\tests\test3\f1\ | Out-File ..\tests\test3\test_3-2_result.txt
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test3\f1\test1_result.txt ..\tests\test3\f1\ | Out-File ..\tests\test3\test_3-3_result.txt
echo "sleep 10"; sleep 10;


#группы файлов. Имя задаётся регуляркой.
# работает
echo "start test 4. Moving a group of Files. Using regular expressions"
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test4\f1\^.*.txt ..\tests\test4\ | Out-File ..\tests\test4\test_4-1_result.txt
echo "sleep 10";
sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test4\^.*.txt ..\tests\test4\f1\ | Out-File ..\tests\test4\test_4-2_result.txt
echo "sleep 10";
sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test4\f2\^.*.txt ..\tests\test4\f3\ | Out-File ..\tests\test4\test_4-3_result.txt
echo "sleep 10";
sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test4\f3\^.*.txt ..\tests\test4\f2\ | Out-File ..\tests\test4\test_4-4_result.txt