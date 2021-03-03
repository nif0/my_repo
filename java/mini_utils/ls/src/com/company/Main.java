package com.company;

/*
  выводит список файлов и каталогов в указанной директории. Можно использовать маски для фильтрации имён.
  путь должен состоять из одного реально существующего корневого каталога и маски для фильтрации имён
  Например:
  F:\projects\ja[av]a\mini_ut?ls\ls\.*\\.*xml$"
*/

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.regex.*;

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

    static ArrayList<File> fileAList = new ArrayList<File>();

    private static void printFileProperty(File f) {
        System.out.print("absolute path: ");
        try {
            System.out.println(f.getAbsolutePath());
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.print("parent: ");
        try {
            System.out.println(f.getParent());
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.print("file name: ");
        try {
            System.out.println(f.getName());
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.print("canonical path: ");
        try {
            System.out.println(f.getCanonicalPath());
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.print("free space: ");
        try {
            System.out.println(f.getFreeSpace());
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.print("total space: ");
        try {
            System.out.println(f.getTotalSpace());
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.print("usable space: ");
        try {
            System.out.println(f.getUsableSpace());
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.print("hash code: ");
        try {
            System.out.println(f.hashCode());
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.print("execute: ");
        try {
            System.out.println(f.canExecute());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println();
        }

        System.out.print("write: ");
        try {
            System.out.println(f.canWrite());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println();
        }

        System.out.print("read: ");
        try {
            System.out.println(f.canRead());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println();
        }

        System.out.print("hiden flag: ");
        try {
            System.out.println(f.isHidden());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println();
        }

        System.out.print("last modify time: ");
        try {
            System.out.println(new Date(f.lastModified()).toLocaleString());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println();
        }
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


    public static void main(String[] args)  {

      //  args[0] = "F:\\projects\\java\\mini_utils\\ls";
	//условие досрочного завершения.
        if (args == null || args.length > 1 || args.length == 0) {
            return;
        }
      //  Path path = Path.of(args[0]);
    //    path = path.normalize();
      //  System.out.println(path);
        for (int i = 0; i < args.length; i++) {
            System.out.println(args[i]);
        }
        String param = args[0];
        File file = new File(param);
        try {
            System.out.println(file.getAbsolutePath());
        } catch (Exception e) {
            e.printStackTrace();
        }
        LinkedList listFiles;
        //FFilter filter = new FFilter(param);
        /*
        I separate the existing part of the path from the file name mask
        and eventually expect a file object with the existing path (part of the param string).
        the rest of the line will be read as a mask
        */

        while (!file.exists()) {
            file = new File(file.getParent());
            System.out.println("tick");
            System.out.println("new work path: " + file.getPath());
         //   System.out.println(param.compareTo(file.getPath()));
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
        System.out.println("work path: " + file.getPath());
        System.out.println("mask: " + mask);
        addAllFilesInList(file);

        //DirFilter dirFilter = new DirFilter(".*xml$");
        //listFiles. //= file;
        //listFiles.

        for (File f: fileAList
             ) {
            System.out.println();
            printFileProperty(f);
        }
    }
}
