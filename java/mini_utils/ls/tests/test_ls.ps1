#тестирование ls
echo "test 1" #для работы необходимо наличие в конце строки косой черты \
java -jar ..\out\artifacts\ls_jar\ls.jar F:\projects\java\mini_utils\ls\ | Out-File F:\projects\java\mini_utils\ls\tests\test_1_result.txt
echo "test 2" #
java -jar ..\out\artifacts\ls_jar\ls.jar F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_2_result.txt
#тестирую ключи
#  -D  включить вывод отладочной информации при работе утилиты.
#  -R  Включить рекурсивную выдачу списка каталогов.(по умолчанию стоит максимальная глубина рекурсии)
#  -d  Выдавать имена каталогов, как будто они обычные файлы, вместо того, чтобы показывать их содержимое.
#  -C Напечатать список файлов в колонке с вертикальной сортировкой. Если есть ключ --sort=field, то сортировка идёт по полю field. Иначе, сортировка идёт по первому столбцу с именем файла.
#  -t  Сортировать по показываемому временному штампу(mtime).
#  -l, --format=long, --format=verbose В дополнении к имени каждого файла, выводятся тип файла, права доступа к файлу, количество ссылок на файл,
#    имя владельца, имя группы, размер файла в байтах и временной штамп (время последней модификации файла, если не задано другое).
#  -a  выводит скрытые файлы
#  -h печать справки и завершение работы
#  -H, --human-readable  Добавлять к каждому размеру файла букву размера, например, M для двоичных мегабайт (`мебибайт')

echo "test 3. -D" #ok. нужно настроить вывод отладки
java -jar ..\out\artifacts\ls_jar\ls.jar -D F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_3_result.txt
echo "test 4. -R" #работает
java -jar ..\out\artifacts\ls_jar\ls.jar -R F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_4_result.txt
echo "test 5. -d" #ok
java -jar ..\out\artifacts\ls_jar\ls.jar -d F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_5_result.txt
#echo "test 6. -C" #не работает. Не ясно что должен делать столбец) Вполне вероятно, что этот влаг нужно убрать.
#java -jar ..\out\artifacts\ls_jar\ls.jar -C F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_6_result.txt
echo "test 7. -t" #ok
java -jar ..\out\artifacts\ls_jar\ls.jar -t F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_7_result.txt
echo "test 8. -l" #ok
java -jar ..\out\artifacts\ls_jar\ls.jar -l F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_8_result.txt
echo "test 9. -a" #ok
java -jar ..\out\artifacts\ls_jar\ls.jar -a F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_9_result.txt
echo "test 10. -h" #ok
java -jar ..\out\artifacts\ls_jar\ls.jar -h F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_10_result.txt
echo "test 11. -H" #не работает. Не виден результат.
java -jar ..\out\artifacts\ls_jar\ls.jar -H F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_11_result.txt

echo "test 12. -Hl" #ok
java -jar ..\out\artifacts\ls_jar\ls.jar -Hl F:\projects\java\mini_utils\ls | Out-File F:\projects\java\mini_utils\ls\tests\test_12_result.txt





