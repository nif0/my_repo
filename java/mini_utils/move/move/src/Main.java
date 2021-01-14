import java.util.HashMap;
import java.io.File;
import java.util.logging.Level;
import java.util.logging.Logger;

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
        VERBOSE
    }

    public enum OSType {
        WINDOWS,
        NIX,
        MAC,
        UNKNOW
    }

    public enum ArgType {
        CATALOG,
        FILE,
        CATALOG_FILEMASK,
        OPTION_STRING,
        UNKNOWN
    }

    public static HashMap<Option,Boolean> useOption = new HashMap<>(5);
    public static String OS = null;
    public static Logger log = Logger.getLogger(Main.class.getName());

    public static void main (String[] args) {
        //инициализация
        boolean debug = true;
        String first_arg = null;
        String two_arg = null;
        String tree_arg = null;
        WorkMode workMode = WorkMode.UNKNOW;
        log.setLevel(Level.INFO);
        if( useOption.isEmpty()); {
            useOption.put(Option.FORCE,false);
            useOption.put(Option.INTERACTIVE,false);
            useOption.put(Option.BACKUP,false);
            useOption.put(Option.UPDATE,false);
            useOption.put(Option.VERBOSE,false);
        }
        //проверка параметров.
        // Первый аргумент: либо файл, либо каталог, либо строка с опциями, либо строка с маской для выбора файлов
        if (args.length == 0) {
            log.warning("передана пустая строка параметров");
            if (debug) {
                first_arg = "F:\\test_file2.txt";
                two_arg = "E:\\test_file.txt";
                tree_arg = null;
            } else return;
        }
        if (args.length > 3) {
            log.warning("количество параметров > 3");
            //return;
        }
        first_arg = args[0];
        two_arg = args[1];
        //tree_arg = args[2];
        ArgType argType1 = getArgType(first_arg);
        ArgType argType2 = getArgType(two_arg);
        if ( (argType1 == ArgType.FILE && argType2 == ArgType.FILE) || (argType1 == ArgType.FILE && argType2 == ArgType.CATALOG_FILEMASK)  ) {
            workMode = WorkMode.FILE_TO_FILE;
        }
        if ( argType1 == ArgType.FILE && argType2 == ArgType.CATALOG) {
            workMode = WorkMode.FILE_IN_CATALOG;
        }
        if ( argType1 == ArgType.CATALOG_FILEMASK && argType2 == ArgType.CATALOG) {
            workMode = WorkMode.GROUP_FILE_IN_CATALOG;
        }
        if ( argType1 == ArgType.CATALOG && argType2 == ArgType.CATALOG) {
            workMode = WorkMode.CATALOG_MOVE;
        }
        if (workMode == WorkMode.UNKNOW) {return; };
        log.info(workMode.toString());
        //перемещаю файлы
        //
        File f = null;
        File f2 = null;
        switch (workMode) {
            case CATALOG_MOVE:
                f = new File(first_arg);
                f2 = new File(two_arg);
                if (f.renameTo(f2)) {
                    log.info("file moved");
                    return;
                }
                break;
            case FILE_IN_CATALOG:
                f = new File(first_arg);
                f2 = null;
                if (two_arg.charAt(two_arg.length()-1) == File.pathSeparatorChar) {
                    f2 = new File(two_arg + first_arg);
                } else {
                    f2 = new File(two_arg + File.pathSeparatorChar + first_arg);
                }
                if (f2 == null) {
                    log.warning("target \"" + two_arg + "\" not identified");
                    return;
                }
                if (f.renameTo(f2)) {
                    log.info("file moved");
                    return;
                }
                break;
            case GROUP_FILE_IN_CATALOG:
                break;
            case FILE_TO_FILE:
                f = new File(first_arg);
                f2 = new File(two_arg);
                if (f.renameTo(f2)) {
                    log.info("file moved");
                    return;
                }
                break;
        }
    }

    private static void printhelp() {

    }

    private static ArgType getArgType(String arg) {
        File f = new File(arg);
        if (f.exists()) {
            log.info("path "+arg+" exists");
            if (f.isDirectory()) return ArgType.CATALOG;
            if (f.isFile()) return ArgType.FILE;
        } else {
            int i;
            if (isWindows()); i = arg.lastIndexOf(File.separatorChar);
            if (isUnix()); i = arg.lastIndexOf(File.separatorChar);
            String subsFName = arg.substring(i,arg.length());
            String subsDirName = arg.substring(0,i);
            log.info("каталог: " + subsDirName + "файл: "+subsFName);
            f = new File(subsDirName);
            if (f.isDirectory()) {
                log.info("path: " + subsDirName + " exists. " + subsFName + " as filemask");
                return  ArgType.CATALOG_FILEMASK;
            };
        }
        //не удалось определить тип
        return ArgType.UNKNOWN;
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

}
