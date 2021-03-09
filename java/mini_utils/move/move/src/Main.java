import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.FileInputStream;
import java.util.regex.Pattern;

public class Main {
    /*
    Если последний аргумент является именем существующего каталога, то mv перемещает все остальные файлы в этот каталог.
    В противном случае, если задано только два файла, то имя первого файла будет изменено на имя второго.
    Если последний аргумент не является каталогом и задано более чем два файла, то будет выдано сообщение об ошибке.
    Так, mv /a/x/y /b переименует файл /a/x/y в /b/y, если /b является существующим каталогом, и в /b, если нет.
    Если при переименовании исходного_файла в файл_назначения, этот файл_назначения существует и при
    этом задана опция -i или если произвести запись в файл назначения невозможно,
    а стандартным выводом является терминал и не задана опция -f, то mv спрашивает у пользователя разрешение
    на замену этого файла, которое выдается на стандартный вывод ошибок, и читает ответ из стандартного ввода.
    Если ответ не утвердительный, то файл пропускается.
    Когда и исходный_файл и файл_назначения находятся на одной файловой системе, они являются одним и тем же файлом
    (изменяется только имя файла; владелец, права доступа, временные штампы остаются неизменными).
    Если же они находятся на разных файловых системах, то исходный_файл копируется и затем удаляется.
    mv будет копировать время последней модификации, время доступа, идентификаторы пользователя и группы и права доступа
    к файлу если это возможно.
    Если копирование идентификаторов пользователя и/или группы закончилось неудачно,
    то в копии файла сбрасываются биты setuid и setgid.
    опции:
     -h  - help
     -f  - force
     -i  - interactive
     -R  - recursive
     -b  - backup
     -u  - update
     -v[1,5] - вывод отладочной информации. чем ольше v, ьем подробней отладка.
     */



    public  enum WorkMode{
        CATALOG_MOVE,
        FILE_IN_CATALOG,
        GROUP_FILE_IN_CATALOG,
        FILE_TO_FILE,
        UNKNOW
    }

    public enum Option {
        FORCE,
        INTERACTIVE,
        BACKUP,
        UPDATE,
        VERBOSE,
        PRINTHELP,
        CREATEPATH
    }

    public enum OSType {
        WINDOWS,
        NIX,
        MAC,
        UNKNOW
    }

    public enum ArgType {
        CATALOG, // аргумент - каталог,
        FILE,    // аргумент - файл
        CATALOG_FILEMASK, // аргумент - каталог + маска имён
        OPTION_STRING,    // аргумент - строка опций
        UNKNOWN           //аргумент -пустая строка, либо не определён.
    }

    static class FileFilter implements FilenameFilter {
        private Pattern pattern;

        public FileFilter(String regexp) {
            pattern = Pattern.compile(regexp);
        }

        @Override
        public boolean accept(File dir, String name) {
            return pattern.matcher(name).matches();
        }
    };

    public static HashMap<Option,Boolean> useOption = new HashMap<>(5);
    public static String OS = null;
    public static Logger log = Logger.getLogger(Main.class.getName());
    public static WorkMode workMode = WorkMode.UNKNOW;
    public static ArrayList<File> fileList = new ArrayList<>();  //коллекция файлов для перемещения
    public static OSType osType;

    public static void main (String[] args) {
        // сбор информацций о системе: тип  ОС, разделитель путей, список точек монтирования,
        osType = getOSType();
        String separator = File.separatorChar + "";
        File[] disks = File.listRoots();
        String userName = System.getProperty("user.name");
        //   0. строка параметров для работы утилиты.
        //   1. что перемещаю(можно маску)
        //   2. куда перемещаю(файл, если 1 - одиночный файл. каталог, если 1 - маска файлов)
        //   анализ параметров. и настройка утилиты для работы.
        String arg1;
        String arg2;
        String arg3;
        File file1; //перемещаемый файл, каталог, или группа файлов
        File file2; //целевой каталог или файл
        switch (args.length) {
            case 0: return;
            case 1: {
                System.out.println("передан 1 аргумент. Что недостаточно для нормальной работы. \n Завершаю программу");
                return;
            }
            case 2: {
                //для 2х аргументов
                arg1 = new String(args[0]);
                arg2 = new String(args[1]);
                //arg3 = new String(args[2]);
                //ожидаю два аргумента: файл 1 и файл 2.
                if ( arg1.toLowerCase(Locale.ROOT).substring(0) == "-" ) {
                    return;
                };
                switch (getArgType(arg1)) {
                    case CATALOG:
                        file1 = new File(arg1);
                        file2 = new File(arg2);
                        if (testPathForMove(file2)) {
                            file1.renameTo(file2);
                        } else {
                            System.out.println("перемещение не удалось");
                            return;
                        }
                        break;
                    case FILE:
                        file1 = new File(arg1);
                        file2 = new File(arg2);
                        if (testPathForMove(file2)) {
                            file1.renameTo(file2);
                        } else {
                            System.out.println("перемещение не удалось");
                            return;
                        }
                        break;
                }
                break;

            }
            case 3: {
                //для 3х аргументов
                arg1 = new String(args[0]);
                arg2 = new String(args[1]);
                arg3 = new String(args[2]);
                if (getArgType(arg1) == ArgType.OPTION_STRING) {
                    if (arg1.toLowerCase(Locale.ROOT).substring(0) == "-") {
                        setUseOption(arg1);
                    }
                } else {
                    System.out.println("первым параметром должна идти строка с аргументами");
                }
                switch (getArgType(arg2)) {
                    case CATALOG: {
                        file1 = new File(arg2);
                        file2 = new File(arg3);
                        if (testPathForMove(file2)) {
                            file1.renameTo(file2);
                        }
                        break;
                    }
                    case FILE: {
                        file1 = new File(arg2);
                        file2 = new File(arg3);
                        if (testPathForMove(file2)) {
                            file1.renameTo(file2);
                        }
                        break;
                    }
                    case CATALOG_FILEMASK: {
                        file1 = new File(arg2);
                        file2 = new File(arg3);
                        while (!file1.exists()) {
                            file1 = new File(file1.getParent());
                        }
                        //вычисляю маску
                        int delta = arg2.compareTo(file1.getPath());
                        String mask = arg2.substring( arg2.length()-delta+1,arg2.length() );

                        System.out.println("work path: " + file1.getPath());
                        System.out.println("mask: " + mask);
                        FileFilter nameFilter = new FileFilter(mask);
                        addFileInFileLists(file1, nameFilter);
                        for (File tmp : fileList) {
                            tmp.renameTo(new File(file2.getAbsolutePath()+separator+tmp.getName()));
                        }
                    }
                }
            }
        }
        // составление списка файлов по арг1.
        // перемещение.
    }

    private static boolean isWindows() {
        return getOSName().toLowerCase().contains("wind");
    }

    private static boolean isUnix() {
        return getOSName().toLowerCase().contains("nix");
    }

    private static boolean isMac() {
        return getOSName().toLowerCase().contains("mac");
    }

    private static OSType getOSType() {
        if (isWindows()) return OSType.WINDOWS;
        if (isUnix()) return OSType.NIX;
        if (isMac()) return OSType.MAC;
        return OSType.UNKNOW;
    }

    private static String getOSName() {
        if (OS == null) {
            OS = System.getProperty("os.name");
        }
        return OS;
    }

    private static void setUseOption(String srgStr) {

        useOption.replace(Option.PRINTHELP,false);
        useOption.replace(Option.UPDATE,false);
        useOption.replace(Option.BACKUP,false);
        useOption.replace(Option.VERBOSE,false);
        useOption.replace(Option.INTERACTIVE,false);
        useOption.replace(Option.FORCE,false);
        useOption.replace(Option.CREATEPATH,false);
    }

    private static ArgType getArgType(String arg) {
        ArgType result;
        if (arg.toLowerCase().lastIndexOf('-') == 0) {
            return ArgType.OPTION_STRING;
        }
        File f = new File(arg);
        if (f.exists() && f.isDirectory()) {
            return ArgType.CATALOG;
        }

        if (f.exists() && f.isFile()) {
            return ArgType.FILE;
        }
        while ( !f.exists()) {
            f = new File(f.getParent());
        }
        if (f.exists() && f.isDirectory()) {
            return ArgType.CATALOG_FILEMASK;
        } else {
            return ArgType.UNKNOWN;
        }
    };

    private static boolean testPathForMove(File target) {
        /*
        требования к конечному пути имени файла
        Шаблон: /Реально_существующий_каталог/новое_имя
                /Реально_существующий_каталог/существующее_имя
        Ситуации: /реально_существующий_каталог/несуществующая_часть/новое_имя
                  /несуществующий_путь/новое_имя
        Вернут false.
         */
        if (target.exists())  {
            return true;
        } else {
            target = new File(target.getParent());
            return target.exists();
        }
    }

    private static void addFileInFileLists(File f, FileFilter filter) {

        for (File tmp: f.listFiles(filter)) {
            if (tmp.isDirectory()) {
                addFileInFileLists(f,filter);
            } else {
                fileList.add(f);
            }
        }
    }
}
