﻿#тесты с каталогами
#работают без ошибок
#стартовая локация: F:\git\my_repo\java\mini_utils\move\tests

#переименование каталога. несуществующий каталог
echo "start test1 renaming a folder";
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test1\f2 ..\tests\test1\f2_ | Out-File ..\tests\test1\test_1-1_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test1\f2_ ..\tests\test1\f2 | Out-File ..\tests\test1\test_1-2_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test1\f1 ..\tests\test1\f1_rename | Out-File ..\tests\test1\test_1-3_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test1\f1_rename ..\tests\f1 | Out-File ..\tests\test1\test_1-3_result.txt;


#перемещение каталога
echo "start test 2 moving a folder"
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f2 ..\tests\test2\f1\   | Out-File ..\tests\test2\test_2-1_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f1\f2 ..\tests\test2\f2 | Out-File ..\tests\test2\test_2-2_result.txt;
echo "sleep 10"; sleep 10;
#java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f1\f2 ..\tests\test2\f2 | Out-File ..\tests\test2\test_2-3_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f2 ..\tests\test2\f1\f2 | Out-File ..\tests\test2\test_2-4_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f1\f2 ..\tests\test2\f2 | Out-File ..\tests\test2\test_2-5_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f1 ..\tests\test2\f2\   | Out-File ..\tests\test2\test_2-6_result.txt;
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test2\f2\f1 ..\tests\test2\f1 | Out-File ..\tests\test2\test_2-6_result.txt;

echo "start test3 moving a single file";
#перемещение одиночного файла

java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test3\f1\test1_result.txt ..\tests\test3\f2\ | Out-File ..\tests\test3\test_3-1_result.txt
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test3\f2\test1_result.txt ..\tests\test3\f1\ | Out-File ..\tests\test3\test_3-2_result.txt
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test3\f1\test1_result.txt ..\tests\test3\f1\ | Out-File ..\tests\test3\test_3-3_result.txt
echo "sleep 10"; sleep 10;


#тесты с ключами

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

echo "для теста создаю файл ..\tests\test4\f3\test4-4.txt";
rm ..\tests\test4\f2\test4-4.txt;
echo "file for test 4-4. Abracadabra" | Out-File ..\tests\test4\f3\test4-4.txt
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test4\f3\^.*.txt ..\tests\test4\f2\ | Out-File ..\tests\test4\test_4-4_result.txt
echo "sleep 20"; sleep 20;
java -jar ..\move\out\artifacts\move_jar\move.jar ..\tests\test4\f2\^.*.txt ..\tests\test4\f3\test4-4.txt
echo "sleep 20"; sleep 20;

#тестирую ключи
# -h - :вывод справки и завершение работы.
# -b - :backup В случае совпадения имён, старое имя изменяется по шаблону: <name>.<cur_date>. Игнорируется, если указан ключ -u
# -u - :update Перемещает только те файлы/каталоги, которых нет в пути назначения. 
# 
echo "start test 5. Using keys"; 
echo "key: -u. sleep 2"; sleep 2;
java -jar ..\move\out\artifacts\move_jar\move.jar -u ..\tests\test5\f2\^.*.txt ..\tests\test5\f1\ | Out-File ..\tests\test5\test_5-1_result.txt
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar -u ..\tests\test5\f1\^.*.txt ..\tests\test5\f2\ | Out-File ..\tests\test5\test_5-2_result.txt
echo "sleep 10"; sleep 10;

echo "key: -b. sleep 2"; sleep 2;
java -jar ..\move\out\artifacts\move_jar\move.jar -b ..\tests\test5\f2\^.*.txt ..\tests\test5\f1\ | Out-File ..\tests\test5\test_5-3_result.txt
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar -b ..\tests\test5\f1\^.*.txt ..\tests\test5\f2\ | Out-File ..\tests\test5\test_5-4_result.txt

echo "sleep 10"; sleep 10;
echo "key: -b. sleep 2"; sleep 2;
java -jar ..\move\out\artifacts\move_jar\move.jar -b ..\tests\test5\f2\^.*.txt ..\tests\test5\f1\ | Out-File ..\tests\test5\test_5-5_result.txt
echo "sleep 10"; sleep 10;
java -jar ..\move\out\artifacts\move_jar\move.jar -b ..\tests\test5\f1\^.*.txt ..\tests\test5\f2\ | Out-File ..\tests\test5\test_5-6_result.txt

echo "sleep 10"; sleep 10;
echo "key: -h. sleep 2"; sleep 2;
java -jar ..\move\out\artifacts\move_jar\move.jar -h ..\tests\test5\f2\^.*.txt ..\tests\test5\f1\ | Out-File ..\tests\test5\test_5-7_result.txt
