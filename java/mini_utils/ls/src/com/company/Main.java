package com.company;

/*
  выводит список файлов и каталогов в указанной директории. Можно использовать маски для фильтрации имён.
  путь должен состоять из одного реально существующего корневого каталога и маски для фильтрации имён.
  Первыми идут ключи. Затем имя каталога и маска.
  Например:
  F:\projects\ja[av]a\mini_ut?ls\ls\.*\\.*xml$"
  Если указаны ключи(пример):
   -Rdc --max-depth=5 F:\projects\ja[av]a\mini_ut?ls\ls\.*\\.*xml$"
  то имя пути должно идти в конце

  поддерживаемые  короткие ключи
  -D
    включить вывод отладочной информации при работе утилиты.
  -R
    Включить рекурсивную выдачу списка каталогов.(по умолчанию стоит максимальная глубина рекурсии)
  -d
    Выдавать имена каталогов, как будто они обычные файлы, вместо того, чтобы показывать их содержимое.
  -C
    Напечатать список файлов в колонке с вертикальной сортировкой. Если есть ключ --sort=field, то сортировка
    идёт по полю field. Иначе, сортировка идёт по первому столбцу с именем файла.
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
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.util.*;
import java.util.regex.*;
import java.util.stream.Stream;

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
        TYPE,
        OWNER;
        @Override
        public String toString()  {
            switch (this) {
                case PARENT: return "parent";
                case ABSPATH: return "fullpath";
                case CANPATH: return "canpath";
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
                case TYPE: return "type";
                default: throw new IllegalArgumentException();
            }
        }
    }
    //короткие ключи программы.
    private static enum keyNames {
        RECURSIVE,
        DEBUG,
        PRINTHIDDEN,
        HUMANREADABLEFORMAT,
        SIFORMAT,
        ONECOLUMN,
        PRINTHELP,
        LONGFORMAT,
        NOSHOWCATALOG, //влияет в addAllFilesInList

        SORTBYFIELD,
        COLUMNSEPARATE,
        MAXDEPTH;

        public static Stream<keyNames> getStream() {
            return Stream.of(keyNames.values());
        }

        @Override
        public String toString() {
            switch(this) {
                case RECURSIVE: return "R";
                case DEBUG: return "D";
                case PRINTHIDDEN: return "a";
                case HUMANREADABLEFORMAT: return "H";
                case SIFORMAT: return "s";
                case ONECOLUMN: return "с";
                case PRINTHELP: return "h";
                case LONGFORMAT: return "l";
                case NOSHOWCATALOG: return "d";
                case MAXDEPTH: return "max-depth";
                case COLUMNSEPARATE: return "column-separate";
                case SORTBYFIELD: return "sort";
                default: throw new IllegalArgumentException();
            }
        }

        public char toChar() {
            switch(this) {
                case RECURSIVE: return 'R';
                case DEBUG: return 'D';
                case PRINTHIDDEN: return 'a';
                case HUMANREADABLEFORMAT: return 'H';
                case SIFORMAT: return 's';
                case ONECOLUMN: return 'c';
                case PRINTHELP: return 'h';
                case LONGFORMAT: return 'l';
                case NOSHOWCATALOG: return 'd';
                default: throw new IllegalArgumentException();
            }
        }
    }


    private static enum LongKeyNames{
        SORTBYFIELD,
        COLUMNSEPARATE,
        MAXDEPTH;

        @Override
        public String toString() {
            String result = null;
            switch (this) {
                case MAXDEPTH: result = "max-depth";
                case COLUMNSEPARATE: result = "column-separate";
                case SORTBYFIELD: result = "sort";
            }
            return result;
        }
        public static Stream<LongKeyNames> getStream() {
            return Stream.of(LongKeyNames.values());
        }
    }

    private static boolean debug = true;

    private static FilePropertyNames sortField = null;
    //хранит в себе порядок вывода столбцов на терминал.
    private static List<FilePropertyNames> printFilePropertyOrder = new ArrayList<FilePropertyNames>();

    private static Map<FilePropertyNames,Boolean> printProperty = new HashMap<>();
    private static Map<keyNames,String> programKey = new HashMap<>();
    private static Map<FilePropertyNames,String> columnFormat = new HashMap<>();

    static ArrayList<File> fileAList = new ArrayList<File>();

    private static boolean isDebug() {
        return debug;
    }

    private static void debugPrintProgramProperty() {
        if (isDebug()) {
            for (FilePropertyNames tmp : printProperty.keySet() ) {
                System.out.println(tmp.toString() + ": "+ printProperty.get(tmp).toString());
            }
            for (keyNames tmp : programKey.keySet()) {
                System.out.println(tmp.toString() + ": " + programKey.get(tmp));
            }
        }
    }

    private static void enableProgramKey(keyNames[] args) {
        for (keyNames a : args) {
            programKey.put(a,Boolean.TRUE.toString());
        }
    }

    private static void disableProgramKey(keyNames[] args) {
        for (keyNames a : args) {
            programKey.put(a,Boolean.FALSE.toString());
        }
    }

    private static void enablePrintFileProperty(FilePropertyNames[] args) {
        for (FilePropertyNames pr : args) {
            printProperty.put(pr,Boolean.TRUE);
        }
    }

    private static void disablePrintFileProperty(FilePropertyNames[] args) {
        for (FilePropertyNames pr : args) {
            printProperty.put(pr,Boolean.FALSE);
        }
    }

    private static String toHumanReadableFormat(int size) {
        String byte_pref = "B";
        String mbyte_pref = "M";
        String kbyte_pref = "K";
        String res = null;
        //in Kb
        if (size < 1024) res = Float.toString(size)+"B";
        float result = size / 1024;
        //in Mb
        if (size < 1024) res = Float.toString(size) + "KB";
         result = size / 1024;
        //in Gb
        if (size < 1024) res = Float.toString(size) + "MB";
         result = size / 1024;
        if (size < 1024) res =  Float.toString(size) + "GB";
        return  res;
    }

    //private static void printHead
    private static void printFileProperty(File f) {
        StringBuilder result = new StringBuilder();
        String formatString = new String();
        int i = 0;

        try {
            if (printProperty.get(FilePropertyNames.TYPE)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.TYPE);
                result.append(( f.isDirectory()  ? "d" : "f" ) + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            if (printProperty.get(FilePropertyNames.ABSPATH)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.ABSPATH);
                result.append(f.getAbsolutePath() + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.PARENT)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.PARENT);
                result.append(f.getParent() + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.FILENAME)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.FILENAME);
                result.append(f.getName() + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.CANPATH)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.CANPATH);
                result.append(f.getCanonicalPath() + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.FREESPACE)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.FREESPACE);
                result.append(f.getFreeSpace() + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.TOTALSPACE)) {
                i++;
                formatString += columnFormat.get(FilePropertyNames.TOTALSPACE);
                result.append(f.getTotalSpace() + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.USABLESPACE)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.USABLESPACE);
                result.append(f.length() + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.HASHCODE)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.HASHCODE);
                result.append(f.hashCode() + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.EXECUTE)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.EXECUTE);
                result.append((f.canExecute() ? "x" : "-")  + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.WRITEF)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.WRITEF);
                result.append((f.canWrite() ? "w" : "-")  + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.READF)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.READF);
                result.append((f.canRead() ? "r": "-")  + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.TYPE)) {
                i++;
                formatString +=  "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.TYPE);
                result.append((f.isHidden())  + programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.LMTIME)) {
                i++;
                formatString += "%" + Integer.toString(i)+"$"+ columnFormat.get(FilePropertyNames.LMTIME);
                result.append(new Date(f.lastModified()).toLocaleString().replaceAll(" ",""));
                result.append(programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (printProperty.get(FilePropertyNames.OWNER)) {
                i++;
                formatString += "%" + Integer.toString(i)+"$"+columnFormat.get(FilePropertyNames.OWNER);
                result.append(Files.getOwner(f.toPath(), LinkOption.NOFOLLOW_LINKS).toString().replaceAll(" ","_"));
                result.append(programKey.get(keyNames.COLUMNSEPARATE));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //DateFormat.
        //String[] subs;
        //System.out.println(result.substring(0));
        if (isDebug()) {
            System.out.println(formatString);
            System.out.println(result.substring(0));
        }
        for (String str : result.substring(0).split(" ")) {
            System.out.format("%30s",str);
        }
        // System.out.format(formatString,result.substring(0));
    }


    private static void addAllFilesInList(File file, int recurseLevel) {
        int maxRecurseLevel = Integer.parseInt(programKey.get(keyNames.MAXDEPTH));
        if (recurseLevel > maxRecurseLevel) return;
        File[] tmp;
        tmp = file.listFiles();
        for (File f: tmp
            ) {
            if (f.isDirectory()) {
                addAllFilesInList(f,recurseLevel + 1);
                fileAList.add(f);
            } else {
                if (programKey.get(keyNames.NOSHOWCATALOG).equals(Boolean.FALSE.toString())) {
                    fileAList.add(f);
                }
            }
        }
    };

    private static boolean isParam(String arg) {
        boolean result = false;
        String a = arg.substring(0,1);
        if ( a.equals("-") ) {
            File f = new File(arg);
            if (f.exists()) {
                result = false;
            }
            result = true;
        }
        return result;
    }



    private static void prepareKeyString(String flags) {
        /*
            строка с ключами состоит из начального дефиса и букв-параметров.
                Например: -DRaH
            также используются длинные ключи-параметры.
                Пример: --max-depth=5 устанавливает максимальную глубину рекурсивного обхода каталогов равным 5
             таких ключей в строке может быть несколько.
             В этом случае они перечисляются через пробел.
                Пример:
             -DRaH --sort=field --column-separate --max-depth=N
             В массиве args[] эта строка займёт 4 ячейки.
         */
        /*
          Вначале проверить, что переданная строка - набор ключей и параметров.
          заполнить массивы.
         */
        //проверка на соответствие.
        // Должно начинаться с - или --
        String test = flags.substring(0,2);
        if (isDebug()) {
            System.out.println(test);
        }
        Pattern keyTest = Pattern.compile("^[-]["+ keyNames.getStream().toString()+"]*");
        if (isDebug()){
            System.out.println("test regexp: "+keyTest.toString());
        }
        Pattern longKeyTest = Pattern.compile("^[--]"+ "["+ LongKeyNames.getStream().toString()+"]");
        if (isDebug()) {
            System.out.println("test regexp: " + longKeyTest.toString());
        }
        String uniq_string = flags;
        Matcher keyTestMatcher = keyTest.matcher(uniq_string);
        //для строки с короткими ключами
        if (keyTestMatcher.matches() ) {
            //удаляю повторы и включаю нужные флаги
            uniq_string = flags;
            for (char ch : uniq_string.toCharArray()) {
                if  (ch == keyNames.DEBUG.toChar()) programKey.put(keyNames.DEBUG,Boolean.TRUE.toString());
                if  (ch == keyNames.HUMANREADABLEFORMAT.toChar())
                    programKey.put(keyNames.HUMANREADABLEFORMAT,Boolean.TRUE.toString());
                if  (ch == keyNames.LONGFORMAT.toChar()) {
                    programKey.put(keyNames.LONGFORMAT,Boolean.TRUE.toString());
                    printProperty.put(FilePropertyNames.FILENAME,Boolean.TRUE);
                    printProperty.put(FilePropertyNames.USABLESPACE,Boolean.TRUE);
                    printProperty.put(FilePropertyNames.LMTIME,Boolean.TRUE);
                    printProperty.put(FilePropertyNames.OWNER,Boolean.TRUE);
                    printProperty.put(FilePropertyNames.READF,Boolean.TRUE);
                    printProperty.put(FilePropertyNames.WRITEF,Boolean.TRUE);
                    printProperty.put(FilePropertyNames.EXECUTE,Boolean.TRUE);
                }
                if  (ch == keyNames.NOSHOWCATALOG.toChar() ) {
                    programKey.put(keyNames.NOSHOWCATALOG,Boolean.TRUE.toString());
                }
                if  (ch == keyNames.ONECOLUMN.toChar() ) {
                    programKey.put(keyNames.ONECOLUMN,Boolean.TRUE.toString());
                    printProperty.put(FilePropertyNames.FILENAME,true);
                }
                if  (ch == keyNames.PRINTHELP.toChar() ) programKey.put(keyNames.PRINTHELP,Boolean.TRUE.toString());
                if  (ch == keyNames.PRINTHIDDEN.toChar() ) programKey.put(keyNames.PRINTHIDDEN,Boolean.TRUE.toString());
                if  (ch == keyNames.RECURSIVE.toChar() ) programKey.put(keyNames.RECURSIVE,Boolean.TRUE.toString());
            }
            return;
        }
        //для строки с длинными ключами
        Matcher longKeyTestMatcher = longKeyTest.matcher(uniq_string);
        if (longKeyTestMatcher.matches()) {
            uniq_string = uniq_string.replace("-","");
           // uniq_string.
            String paramName = uniq_string.substring(0,uniq_string.indexOf("="));
            String value = uniq_string.substring(uniq_string.indexOf("=")+1,uniq_string.length());
                if (paramName.toString().equals(keyNames.COLUMNSEPARATE.toString()) ) {
                    programKey.put(keyNames.COLUMNSEPARATE, value);
                }
                if (paramName.toString().equals(keyNames.SORTBYFIELD.toString()) ) {
                    programKey.put(keyNames.SORTBYFIELD,value);
                }
                if (paramName.toString().equals(keyNames.MAXDEPTH.toString()) ) {
                    programKey.put(keyNames.MAXDEPTH,value);
                }
        }
    }


    public static void main(String[] args)  {
        //очерёдность вывода столбцов в терминал.
        printFilePropertyOrder.add(FilePropertyNames.TYPE);
        printFilePropertyOrder.add(FilePropertyNames.FILENAME);
        printFilePropertyOrder.add(FilePropertyNames.READF);
        printFilePropertyOrder.add(FilePropertyNames.WRITEF);
        printFilePropertyOrder.add(FilePropertyNames.EXECUTE);
        printFilePropertyOrder.add(FilePropertyNames.LMTIME); //тот самый timestamp;
        printFilePropertyOrder.add(FilePropertyNames.OWNER);
        printFilePropertyOrder.add(FilePropertyNames.HIDDENF);
        printFilePropertyOrder.add(FilePropertyNames.PARENT);

        printProperty.put(FilePropertyNames.ABSPATH,false);
        printProperty.put(FilePropertyNames.FILENAME,false);
        printProperty.put(FilePropertyNames.CANPATH,false);
        printProperty.put(FilePropertyNames.EXECUTE,false);
        printProperty.put(FilePropertyNames.FREESPACE,false);
        printProperty.put(FilePropertyNames.HASHCODE,false);
        printProperty.put(FilePropertyNames.HIDDENF,false);
        printProperty.put(FilePropertyNames.LMTIME,false);
        printProperty.put(FilePropertyNames.OWNER,false);
        printProperty.put(FilePropertyNames.PARENT,false);
        printProperty.put(FilePropertyNames.READF,false);
        printProperty.put(FilePropertyNames.TOTALSPACE,false);
        printProperty.put(FilePropertyNames.USABLESPACE,false);
        printProperty.put(FilePropertyNames.WRITEF,false);
        printProperty.put(FilePropertyNames.TYPE,false);

        columnFormat.put(FilePropertyNames.TYPE,"1S");
        columnFormat.put(FilePropertyNames.ABSPATH,"2S");
        columnFormat.put(FilePropertyNames.FILENAME,"3S");
        columnFormat.put(FilePropertyNames.CANPATH,"4S");
        columnFormat.put(FilePropertyNames.EXECUTE,"5S");
        columnFormat.put(FilePropertyNames.FREESPACE,"6S");
        columnFormat.put(FilePropertyNames.HASHCODE,"7S");
        columnFormat.put(FilePropertyNames.HIDDENF,"8S");
        columnFormat.put(FilePropertyNames.LMTIME,"9S");
        columnFormat.put(FilePropertyNames.OWNER,"10S");
        columnFormat.put(FilePropertyNames.PARENT,"11S");
        columnFormat.put(FilePropertyNames.READF,"12S");
        columnFormat.put(FilePropertyNames.TOTALSPACE,"13S");
        columnFormat.put(FilePropertyNames.USABLESPACE,".14S");
        columnFormat.put(FilePropertyNames.WRITEF,"15S");

        //programKey.put(keyNames.DEBUG,Boolean.FALSE.toString());
        programKey.put(keyNames.DEBUG,Boolean.FALSE.toString());
        programKey.put(keyNames.LONGFORMAT,Boolean.FALSE.toString());
        programKey.put(keyNames.NOSHOWCATALOG,Boolean.FALSE.toString());
        programKey.put(keyNames.ONECOLUMN,Boolean.FALSE.toString());
        programKey.put(keyNames.PRINTHELP,Boolean.FALSE.toString());
        programKey.put(keyNames.PRINTHIDDEN,Boolean.FALSE.toString());
        programKey.put(keyNames.RECURSIVE,Boolean.FALSE.toString());
        programKey.put(keyNames.MAXDEPTH,String.valueOf(5));
        programKey.put(keyNames.COLUMNSEPARATE,"\t");
	//условие досрочного завершения.
        if (args == null || args.length == 0) {
            return;
        }
        debugPrintProgramProperty();
        String param = args[0];
        File file;// = new File(param);

        LinkedList listFiles;
        /*
            I separate the existing part of the path from the file name mask
            and eventually expect a file object with the existing path (part of the param string).
            the rest of the line will be read as a mask
        */
        int i = 0;
        while (isParam(args[i])) {
             prepareKeyString(args[i]);
             i++;
        }
        debugPrintProgramProperty();
        if (i >= args.length) return;

        file = new File(args[i]);
        while (!file.exists()) {
            file = new File(file.getParent());
        }

        /*
             it is quite strange to use the compare method to determine the position of the mask
             but the characters in the strings are the same. In this case, compare returns
             the difference between the string for which I call the method and the string with which I compare it.
             And in the case of param. compareTo (file.getPath ())
             of line 2 is a subset of line 1.
             I haven't fisgured out why lastIndex and indexOf return 0 in the result yet.
        */
        int delta = args[i].compareTo(file.getPath());
        String mask = args[i].substring(args[i].length()-delta+1,args[i].length());
        addAllFilesInList(file,0);

        for (File f: fileAList
             ) {
            printFileProperty(f);
        }
    }
}