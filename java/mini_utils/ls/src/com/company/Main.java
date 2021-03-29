package com.company;

/*
  выводит список файлов и каталогов в указанной директории. Можно использовать маски для фильтрации имён.
  путь должен состоять из одного реально существующего корневого каталога и маски для фильтрации имён
  Например:
  F:\projects\ja[av]a\mini_ut?ls\ls\.*\\.*xml$"

  поддерживаемые  короткие ключи
  -R
    Включить рекурсивную выдачу списка каталогов.
  -d
    Выдавать имена каталогов, как будто они обычные файлы, вместо того, чтобы показывать их содержимое.
  -C
    Напечатать список файлов в колонке с вертикальной сортировкой.
  -t
    Сортировать по показываемому временному штампу.
  -l, --format=long, --format=verbose
    В дополнении к имени каждого файла, выводятся тип файла, права доступа к файлу, количество ссылок на файл,
    имя владельца, имя группы, размер файла в байтах и временной штамп (время последней модификации файла,
    если не задано другое).
  -a
    выводит скрытые файлы
  -h
    печать справки и завершение работы
  -H, --human-readable
    Добавлять к каждому размеру файла букву размера, например, M для двоичных мегабайт (`мебибайт')
  -si
    Делает то же, что и опция -h, но использует официальные единицы измерения
    SI (где для расчетов используется 1000 вместо 1024 и, таким образом, M -- это 1000000 вместо 10485576)

  длинные ключи
  --sort=field
     сортирует вывод по полю filed
  --column-separate
    разделитель столбцов. По умолчанию это символ табуляции.
  --max-depth=N
    максимальная глуина рекурсиии при включенном флаге R.


*/

import java.io.File;
import java.io.FilenameFilter;
import java.text.DateFormat;
import java.util.*;
import java.util.regex.*;
import java.nio.file.Files;

 class DirFilter implements  FilenameFilter{
    private Pattern pattern;

    public DirFilter (String regexp) {
        pattern = Pattern.compile(regexp);
    }

    @Override
    public boolean accept(File dir, String name) {
            return pattern.matcher(name).matches();
    }
}

public class Main {
     //свойства файлов, доступные для отображения на экране
    private static enum FilePropertyNames {
        PARENT,      //parent folder
        ABSPATH,     // absolute path
        FILENAME,
        CANPATH,     // canonical path
        FREESPACE,
        TOTALSPACE,
        USABLESPACE,
        HASHCODE,
        EXECUTE,   //executable flag
        //атрибуты файла
        WRITEF,     // доступ на запись
        READF,      // доступ на чтение
        HIDDENF,    // скрытый
        LMTIME,      // last modify time
        OWNER;
        @Override
        public String toString()  {
            switch (this) {
                case PARENT: return "parent";
                case ABSPATH: return "fullpath";
                case FILENAME: return "name";
                case FREESPACE: return "freespace";
                case TOTALSPACE: return "totalspace";
                case USABLESPACE: return "usespace";
                case HASHCODE: return "hashcode";
                case EXECUTE: return "execute";
                case WRITEF: return "write";
                case READF: return "read";
                case HIDDENF: return "hidde";
                case LMTIME: return "lmtime";
                case OWNER: return "owner";
                default: throw new IllegalArgumentException();
            }
        }
    }
    //параметры работы программы.
    private static enum ProgramPropertyNames {
        RECURSIVE,
        DEBUG,
        PRINTHIDDEN,
        HUMANREADABLEFORMAT,
        SIFORMAT,
        ONECOLUMN,
        PRINTHELP,
        LONGFORMAT;

        @Override
        public String toString() {
            switch(this) {
                case RECURSIVE: return "R";
                case DEBUG: return "D";
                case PRINTHIDDEN: return "a";
                case HUMANREADABLEFORMAT: return "H";
                case SIFORMAT: return "si";
                case ONECOLUMN: return "1";
                case PRINTHELP: return "h";
                case LONGFORMAT: return "l";
                default: throw new IllegalArgumentException();
            }
        }
    }

    private static FilePropertyNames sortField = null;

    private static Map<FilePropertyNames,Boolean> printProperty = new HashMap<>();

    static ArrayList<File> fileAList = new ArrayList<File>();

    private static void printFileProperty(File f) {
        StringBuilder result = new StringBuilder();
        try {
            if (printProperty.get(FilePropertyNames.ABSPATH)) {
                result.append(" " + f.getAbsolutePath());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.PARENT)) {
                result.append(" " + f.getParent());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.FILENAME)) {
                result.append(" " + f.getName());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.CANPATH)) {
                result.append(" " + f.getCanonicalPath());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.FREESPACE)) {
                result.append(" " + f.getFreeSpace());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.TOTALSPACE)) {
                result.append(" " + f.getTotalSpace());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.USABLESPACE)) {
                result.append(" " + f.getUsableSpace());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.HASHCODE)) {
                result.append(" " + f.hashCode());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.EXECUTE)) {
                result.append(" " + f.canExecute());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.WRITEF)) {
                result.append(" " + f.canWrite());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.READF)) {
                result.append(" " + f.canRead());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.HIDDENF)) {
                result.append((" " + f.isHidden()) );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.LMTIME)) {
                result.append(" " + new Date(f.lastModified()).toLocaleString().replaceAll(" ",""));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //DateFormat.
        System.out.println(result.substring(0));
    }

    private static void addAllFilesInList(File file) {
        File[] tmp;
        tmp = file.listFiles();
        for (File f: tmp
            ) {
            if (f.isDirectory()) {
                addAllFilesInList(f);
                fileAList.add(f);
            } else {
                fileAList.add(f);
            }
        }
    };

    private static void prepareFlagString(String flags) {

    }


    public static void main(String[] args)  {
        printProperty.put(FilePropertyNames.ABSPATH,false);
        printProperty.put(FilePropertyNames.FILENAME,true);
        printProperty.put(FilePropertyNames.CANPATH,false);
        printProperty.put(FilePropertyNames.EXECUTE,false);
        printProperty.put(FilePropertyNames.FREESPACE,false);
        printProperty.put(FilePropertyNames.HASHCODE,false);
        printProperty.put(FilePropertyNames.HIDDENF,false);
        printProperty.put(FilePropertyNames.LMTIME,true);
        printProperty.put(FilePropertyNames.OWNER,false);
        printProperty.put(FilePropertyNames.PARENT,false);
        printProperty.put(FilePropertyNames.READF,false);
        printProperty.put(FilePropertyNames.TOTALSPACE,false);
        printProperty.put(FilePropertyNames.USABLESPACE,false);
        printProperty.put(FilePropertyNames.WRITEF,false);
	//условие досрочного завершения.
        if (args == null || args.length > 1 || args.length == 0) {
            return;
        }
        String param = args[0];
        File file = new File(param);

        LinkedList listFiles;
        /*
        I separate the existing part of the path from the file name mask
        and eventually expect a file object with the existing path (part of the param string).
        the rest of the line will be read as a mask
        */

        while (!file.exists()) {
            file = new File(file.getParent());
        }
        /*
             it is quite strange to use the compare method to determine the position of the mask
             but the characters in the strings are the same. In this case, compare returns
             the difference between the string for which I call the method and the string with which I compare it.
             And in the case of param. compareTo (file.getPath ())
             of line 2 is a subset of line 1.
             I haven't figured out why lastIndex and indexOf return 0 in the result yet.
        */
        int delta = param.compareTo(file.getPath());
        String mask = param.substring(param.length()-delta+1,param.length());
        addAllFilesInList(file);

        for (File f: fileAList
             ) {
            printFileProperty(f);
        }
    }
}
