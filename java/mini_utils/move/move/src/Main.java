import java.io.*;
import java.util.*;
import java.util.function.Consumer;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.FileInputStream;
import java.util.regex.Pattern;
import java.lang.Enum;

public class Main {
/*

аргументы:
 -p - :создаёт полное дерево пути в адресе назначения
 -h - :вывод справки
 -r - :рекурсивное копирование каталогов
 -t - :воссоздание копируемого дерева каталогов в целевом каталоге
 */
    private enum Flags {
        CREATEPATH,
        PRINTHELP,
        RECURSIVE,
        COPYCATALOG;
        public char toChar() {
            char result = ' ';
            switch (this) {
                case CREATEPATH: return 'p';
                case PRINTHELP: return 'h';
                case RECURSIVE: return 'r';
                case COPYCATALOG: return 't';
                default: throw new IllegalArgumentException();
            }
        }
    }
    private static Map<Flags,Boolean> flagsEnumMap = new HashMap<Flags, Boolean>();

private static String printHelp() {
    return "help";
}
    private static void move(MoveElement element1, MoveElement element2) {
        //element1 - что перемещаю. имя файла, каталога, либо путь и регулярное выражение.
        //element2 - куда перемещаю. Это новое имя файла, либо каталог(1)

        if (element2.getNumberRealElement() == 0) {
            //ситуация: переименование(замена) файла.
            //если каталога не существует, то имя считается названием файла
            if (!element2.closeSeparator() && element1.getNumberRealElement()== 1) {
                String pathName = element2.getExsistPath()+File.separator+element2.getNameMask();
                element1.getFileList().get(0).renameTo(new File(pathName));
                return;
            }
            //closeSeparator == true. нужно поместить объект ВНУТРЬ каталога. нужен ключ p
            if (element2.closeSeparator() && element1.getNumberRealElement() == 1) {
                if (flagsEnumMap.get(Flags.CREATEPATH)) {
                    File f = new File(element2.getOriginalPath());
                    f.mkdir();
                    element1.getFileList().forEach(new Consumer<File>() {
                        @Override
                        public void accept(File file) {
                            file.renameTo(new File(f.getAbsolutePath()+File.pathSeparatorChar+file.getName()));
                        }
                    });
                }
            }
        }
        if (element2.getNumberRealElement() == 1) {
            //ситуация: переименование(замена) файла.
            if (element2.getNumberFiles() == 1 && element1.getNumberFiles() == 1) {
                 element2.getFileList().get(0).delete();
                 element1.getFileList().get(0).renameTo(element2.getFileList().get(0));
                 return;
            }
            //ситуация: переименование директории
            if (element2.getNumberDirectories() == 1 && element1.getNumberDirectories() == 1  && !element2.closeSeparator()) {
                element1.getFileList().get(0).renameTo(element2.getFileList().get(0));
            }
            //ситуация: перемещение директории внутрь
            if (element2.getNumberDirectories() == 1 && element1.getNumberDirectories() == 1  && element2.closeSeparator()) {
                element1.getFileList().get(0).renameTo(new File(element2.getExsistPath() + File.separator + element1.getFileList().get(0).getName()));
            }
            //ситуация: файл(ы) и каталоги внутрь каталога
            if (element2.getNumberDirectories() == 1 &&
                    element1.getNumberFiles() >= 1 &&
                    element2.closeSeparator()) {
                String newName = "";
                for (File f : element1.getFileList()) {
                    newName = element2.getExsistPath()+f.getName();
                    f.renameTo(new File(newName));
                }
            }
        }
    }

    public static void main (String[] args) {
        int args_count = 0;
        String tmp = args[1];
        flagsEnumMap.put(Flags.PRINTHELP,false);
        flagsEnumMap.put(Flags.COPYCATALOG,false);
        flagsEnumMap.put(Flags.CREATEPATH,false);
        flagsEnumMap.put(Flags.COPYCATALOG,false);
        //проверить количество параметров
        if (args.length == 1) {
            //передали один аргумент. Начало с "-" - значит что идёт строка с короткими значениями
            if (args[0].substring(0, 1).equals("-")) {
                char c = args[0].charAt(1);
                if (c == Flags.PRINTHELP.toChar()) {
                    flagsEnumMap.replace(Flags.PRINTHELP, true);
                    System.out.println(printHelp());
                }
            }
        }
        if (args.length == 2) {
           //передали два аргумента. В этом случае считаю что строки со флагами нет.
           if (args[0].substring(0,1).equals("-")) {
                System.out.println("ошибка в случае 2х аргументов");
                return;
           }
           MoveElement element1 = new MoveElement(args[0]);
           MoveElement element2 = new MoveElement(args[1]);
           move(element1,element2);
        }
        if (args.length == 3) {
            if (args[0].substring(0,1).equals("-")) {
                //разбираем флаги
                for (char c : args[0].toCharArray()) {
                    if (c == Flags.COPYCATALOG.toChar()) {
                        flagsEnumMap.replace(Flags.COPYCATALOG,true);
                        continue;
                    }
                    if (c == Flags.PRINTHELP.toChar()) {
                        flagsEnumMap.replace(Flags.PRINTHELP,true);
                        continue;
                    }
                    if (c == Flags.CREATEPATH.toChar()) {
                        flagsEnumMap.replace(Flags.CREATEPATH,true);
                        continue;
                    }
                    if (c == Flags.RECURSIVE.toChar()) {
                        flagsEnumMap.replace(Flags.RECURSIVE,true);
                        continue;
                    }
                    if (c == '-') continue;
                    throw new IllegalArgumentException("");
                }
            }
            //флаги прочитаны. Ожидаю что оставшиеся два аргумента будут валидными путями в ФС.
            MoveElement element1 = new MoveElement(args[1]);
            MoveElement element2 = new MoveElement(args[2]);
            move(element1,element2);
        }
            //
    }

}
