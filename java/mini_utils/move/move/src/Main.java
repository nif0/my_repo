import java.io.*;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.FileInputStream;

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
        PRINTHELP
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
        CATALOG_FILEMASK, // аргумент - несуществующее имя
        OPTION_STRING,    // аргумент - строка опций
        UNKNOWN           //аргумент -пустая строка, либо не определён.
    }

    public static HashMap<Option,Boolean> useOption = new HashMap<>(5);
    public static String OS = null;
    public static Logger log = Logger.getLogger(Main.class.getName());
    public static WorkMode workMode = WorkMode.UNKNOW;

    public static void main (String[] args) {
        //ArgType[] arg_types = new Boolean[3];
        //инициализация
        boolean debug = true;
        String first_arg = null;
        String two_arg = null;
        String tree_arg = null;
        //WorkMode workMode = WorkMode.UNKNOW;
        log.setLevel(Level.INFO);
        //режимы работы утилиты
        if( useOption.isEmpty()); {
            useOption.put(Option.FORCE,false);       //выполняет попытку перемещения игнорируя отсутствия прав
            useOption.put(Option.INTERACTIVE,false); //спрашивает разрешение перед каждым перемещением
            //опции BACKUP & UPDATE исключают друг друга
            useOption.put(Option.BACKUP,false);
            useOption.put(Option.UPDATE,false);
            //выводить полробную информацию о ходе перемещения.
            useOption.put(Option.VERBOSE,false);
            useOption.put(Option.PRINTHELP,false);
        }
        //проверка параметров.
        // Первый аргумент: либо файл, либо каталог, либо строка с опциями, либо строка с маской для выбора файлов
        switch (args.length) {
            case 0:
                log.warning("передана пустая строка параметров");
                if (debug) {
                    first_arg = "F:\\test_file2.tx0t";
                    two_arg = "E:\\test_file.txt";
                    tree_arg = null;
                } else return;
                break;

            case 2:
                first_arg = args[0];
                two_arg = args[1];
                break;

            case 3:
                first_arg = args[0];
                two_arg = args[1];
                tree_arg = args[2];
                break;

            default:
                log.warning("error in the number of parameters");
        }
        //анализирую аргументы по типу. Включаю опции.
        ArgType argType1 = getArgType(first_arg);
        ArgType argType2 = getArgType(two_arg);
        ArgType argType3 = getArgType(tree_arg);
        if (argType1 == ArgType.OPTION_STRING) {
            if (first_arg.toLowerCase().contains("f")) {
                Main.useOption.replace(Option.FORCE,true);
                log.info("force mode enable");
            }

            if (first_arg.toLowerCase().contains("h")) {
                Main.useOption.replace(Option.PRINTHELP, true);
                log.info("print help mode enable");
            }

            if (first_arg.toLowerCase().contains("i")) {
                Main.useOption.replace(Option.INTERACTIVE,true);
                log.info("interactive mode enable");
            }

            if (first_arg.toLowerCase().contains("b")) {
                Main.useOption.replace(Option.BACKUP,true);
                log.info("backup mode enable");
            }

            if (first_arg.toLowerCase().contains("u")) {
                Main.useOption.replace(Option.UPDATE,true);
            }

            first_arg = two_arg;
            two_arg = tree_arg;
            tree_arg = null;
            argType1 = getArgType(first_arg);
            argType2 = getArgType(two_arg);
        }

        if ( (argType1 == ArgType.FILE && argType2 == ArgType.FILE) || (argType1 == ArgType.FILE && argType2 == ArgType.CATALOG_FILEMASK)  ) {
            workMode = WorkMode.FILE_TO_FILE;
        }
        if ( argType1 == ArgType.FILE && argType2 == ArgType.CATALOG) {
            workMode = WorkMode.FILE_IN_CATALOG;
        }
        if ( argType1 == ArgType.CATALOG_FILEMASK && argType2 == ArgType.CATALOG) {
            workMode = WorkMode.GROUP_FILE_IN_CATALOG;
        }
        if (( argType1 == ArgType.CATALOG && argType2 == ArgType.CATALOG) || ( argType1 == ArgType.CATALOG && argType2 == ArgType.CATALOG_FILEMASK))
        {
            workMode = WorkMode.CATALOG_MOVE;
        }
        if ( workMode == WorkMode.UNKNOW ) {return; };
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
                f = new File(first_arg);
                f2 = new File(two_arg);
                if ( f2.exists() && f2.isDirectory() ) {
                    for (int i = 0; i < f.list().length; i++) ;
                    {
                        f.renameTo(new File(f2.getAbsolutePath() + File.pathSeparator + f.getName()));
                    }
                } else {
                    log.warning("the path: " + f2.getAbsolutePath() + "does not exist or it is not a directory");
                }
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
        //эта строка - строка с параметрами работы?
        log.info(arg);
        log.info("OS name: " + getOSName());
        log.info("seperator char: " + File.separatorChar);
        if ( arg == null || arg.isEmpty() ) {
            log.info("argument is null");
            return ArgType.UNKNOWN;
        }
        if ( arg.charAt(0) == '-') return ArgType.OPTION_STRING;
        // эта строка - существующий путь в файловой системе?
        File f = new File(arg);
        log.info(f.toString());
        if (f.exists() && f.list().length == 1) {
            log.info("path "+arg+" exists");
            if (f.isDirectory()) return ArgType.CATALOG;
            if (f.isFile()) return ArgType.FILE;
        } else {
            if (f.exists() && f.list().length > 1) {
                return ArgType.CATALOG_FILEMASK;
            }
            //если это не строка  и не каталог, то ... возможно это путь к несуществующему файлу?
            //в этом случае нужно проверить, существует ли родительский каталог.
            //Если строка: "существующий путь"/несуществующее_имя, то тип аргумента CATALOG_FILEMASK
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
        //не удалось определить тип аргумента
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

    private static void create_path(String path) {
        //проверить, существует ли указанный путь
        File f = new File(path);
        if ( f.exists() ) return;
        //проверить возможность создания, если такой возможности нет? то завершить работу
        if ( !f.canWrite() ) {
            log.warning("catalog: "+f.getAbsolutePath() + " is write protected");
            return;
        } else {
            //создатть директорию.
            if (f.mkdir()) {
                log.info("calog: " + f.getAbsolutePath() + " created");
            } else {
                log.warning("cannot create " + f.getAbsolutePath());
            }
        }
    }
/*
    private static void move_file(String oldFullName, String newFullName) {
        //перемещаю как копирование + удаление.
        //проверяю наличие нового пути и копирую. Функция предназначена для копирования только 1го файла за раз.
        File oldName = new File(oldFullName);
        File newName = new File(newFullName);
        File newFileCatalog = newName.getParentFile();

        if ( newFileCatalog.exists() && newFileCatalog.isDirectory() ) {
            if ( ! oldName.exists()) {
                log.warning("path "+oldName.getAbsolutePath()+ " not exists");
                return;
            }
        } else {
            log.warning("path: " + newFileCatalog.toString() + " not exists or this is not directory ");
            return;
        }

        //copy file
        //копирую по байтам. В планах добавить отображение прогресса.
        FileInputStream fileInput = null;
        FileOutputStream fileOutput = null;
        int aval = 0;
        int b = 0;
        try {
             fileInput = new FileInputStream(oldName);
             fileOutput = new FileOutputStream(newName,true);
             aval = fileInput.available();

            while ( (b=fileInput.read()) !=-1 ) {
                  fileOutput.write(b);
            }
            fileOutput.flush();
            fileOutput.close();
            fileInput.close();
        } catch (FileNotFoundException e) {
            log.warning("file: " + oldName.getName() + " not found");
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

 */
}
