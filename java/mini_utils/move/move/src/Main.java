import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
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
    public static ArrayList<File> fileList = new ArrayList<>();
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
        
        switch (args.length) {
            case 0: return;
            case 1: {
                System.out.println("передан 1 аргумент. Что недостаточно для нормальной работы. \n Завершаю программу");
                return;
            }
            case 2: {
                //для 2х аргументов
                break;
            }
            case 3: {
                //для 3х аргументов
                break;
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
}
