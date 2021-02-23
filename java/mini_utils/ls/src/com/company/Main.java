package com.company;

/*
  На вход получаю путь в виде регулярного выражения.
  На стандартный вывод консоли нужно вывести список файлов и каталогов,
  которые пожходят под маску.
*/

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.file.Path;
import java.util.Date;
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
        File[] listFiles;
        //FFilter filter = new FFilter(param);
         DirFilter dirFilter = new DirFilter(".*.xml");
        listFiles = file.listFiles(dirFilter);

        for (File f: listFiles
             ) {
            System.out.println();
            //if (f.)
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

    }
}
