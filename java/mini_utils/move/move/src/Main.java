import java.io.*;
import java.nio.file.FileSystem;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.*;
import java.util.function.Consumer;

public class Main {
/*

аргументы:
 -h - :вывод справки
 -b - :backup В случае совпадения имён, старое имя изменяется по шаблону: <name>.<cur_date>
 -u - :update Перемещает только те файлы/каталоги, которых нет в пути назначения.
 */
    private enum Flags {
        BACKUP,
        PRINTHELP,
        CREATEPATH,
        UPDATE;

        public char toChar() {
            char result = ' ';
            switch (this) {
                case BACKUP: return 'b';
                case PRINTHELP: return 'h';
                case UPDATE: return 'u';
                case CREATEPATH: return 'p';
                default: throw new IllegalArgumentException();
            }
        }
    }
    private static Map<Flags,Boolean> flagsEnumMap = new HashMap<Flags, Boolean>();

    private static String getHelpString() {
        StringBuilder b = new StringBuilder();
        b.append("Переименовывает файл/каталог, или перемещает его в новую директорию \n");
        return b.toString();
}
    private static void init() {
        flagsEnumMap.put(Flags.UPDATE,false);
        flagsEnumMap.put(Flags.PRINTHELP,false);
        flagsEnumMap.put(Flags.BACKUP,false);
        flagsEnumMap.put(Flags.CREATEPATH,false);
    }

    private static void changeFileName(String name1, String name2) {
        if (!Files.exists(Paths.get(name1))) {
            new IllegalArgumentException();
        }

    }

    private static void move(MoveElement element1, MoveElement element2) {
        String pathName = null;
        //element1 - что перемещаю. имя файла, каталога, либо путь и регулярное выражение.
        //element2 - куда перемещаю. Это новое имя файла, либо каталог(1)
        //предстартовые проверки
        /*
        if (element2.getNumberRealElement() == 0) {
            System.out.println("не указано новое имя/пункт назначения для перемещения");
            return;
        }
        */

        if (element1.getNumberRealElement() == 0) {
            System.out.println("объекты для перемещения/переименования не найдены");
            return;
        }
        if (element2.getNumberRealElement() == 0) {
            //ситуация: переименование(замена) файла.
            //если каталога не существует, то имя считается названием файла.
            if  (!element2.closeSeparator() && element1.getNumberRealElement()== 1) {
                    pathName = element2.getExsistPath()+File.separator+element2.getNameMask();
                    element1.getFileList().get(0).renameTo(new File(pathName));
                    if (!Files.exists(Paths.get(pathName))) {
                        System.out.println("file not rename");
                    }
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
                            file.renameTo(new File(f.getAbsolutePath()+File.separator+file.getName()));
                            if (!Files.exists(Paths.get(f.getAbsolutePath()+File.separator+file.getName()))) {
                                System.out.println("file not rename");
                            }
                        }
                    });
                } else {
                    element1.getFileList().get(0).renameTo(element2.getFileList().get(0));
                    if (!Files.exists(element2.getFileList().get(0).toPath())) {
                        System.out.println("file not rename");
                    }
                }
            }
        }
        if (element2.getNumberRealElement() == 1) {
            //ситуация: переименование(замена) файла.
            if  (element2.getNumberFiles() == 1 && element1.getNumberFiles() == 1) {
                if (flagsEnumMap.get(Flags.UPDATE)) {
                    if ( element2.getFileList().get(0).compareTo(element2.getFileList().get(0)) != 0 ) {
                        element1.getFileList().get(0).renameTo(element2.getFileList().get(0));
                        if (!Files.exists(Paths.get(pathName))) {
                            System.out.println("file not rename");
                        }
                    }
                } else {
                    pathName = element2.getFileList().get(0).getPath();
                    element1.getFileList().get(0).renameTo(element2.getFileList().get(0));
                    try {
                        if (!Files.exists(Paths.get(pathName))) {
                            System.out.println("file not rename");
                        }
                    } catch (NullPointerException e) {
                        System.out.println(pathName + "is not valid");
                    }
                }
                 /*
                     element2.getFileList().get(0).delete();
                     element1.getFileList().get(0).renameTo(element2.getFileList().get(0));
                 */
                 return;
            }
            //ситуация: переименование директории
            if  (element2.getNumberDirectories() == 1 && element1.getNumberDirectories() == 1  && !element2.closeSeparator()) {
                //element1.getFileList().get(0).renameTo(element2.getFileList().get(0));
                if (flagsEnumMap.get(Flags.UPDATE)) {
                    if ( element2.getFileList().get(0).compareTo(element2.getFileList().get(0)) != 0 ) {
                        element1.getFileList().get(0).renameTo(element2.getFileList().get(0));
                    }
                    if (!Files.exists(Paths.get(pathName))) {
                        System.out.println("file not rename");
                    }
                } else {
                    element1.getFileList().get(0).renameTo(element2.getFileList().get(0));
                    if (!Files.exists(Paths.get(element2.getFileList().get(0).getPath()))) {
                        System.out.println("file not move");
                    }
                }
            }
            //ситуация: перемещение директории внутрь
            if  (element2.getNumberDirectories() == 1 && element1.getNumberDirectories() == 1  && element2.closeSeparator()) {
                if (flagsEnumMap.get(Flags.UPDATE)) {
                    if (element2.getFileList().get(0).compareTo(element2.getFileList().get(0)) != 0) {
                        element1.getFileList().get(0).renameTo(new File(element2.getExsistPath() + File.separator + element1.getFileList().get(0).getName()));
                        if (!Files.exists(Paths.get(element2.getExsistPath() + File.separator + element1.getFileList().get(0).getName()))) {
                            System.out.println("file not move");
                        }
                    }
                } else {
                    element1.getFileList().get(0).renameTo(new File(element2.getExsistPath() + File.separator + element1.getFileList().get(0).getName()));
                    if (!Files.exists(Paths.get(element2.getExsistPath() + File.separator + element1.getFileList().get(0).getName()))) {
                        System.out.println("file not move");
                    }
                }
            }
            //ситуация: файл(ы) и каталоги внутрь каталога
            File newFile;
            if  (element2.getNumberDirectories() == 1 &&
                    element1.getNumberFiles() >= 1 &&
                    element2.closeSeparator()) {
                String newName = "";
                LocalDateTime date = LocalDateTime.now();
                for (File f : element1.getFileList()) {
                    newName = element2.getExsistPath()+f.getName();
                    newFile = new File(newName);
                    if  (flagsEnumMap.get(Flags.UPDATE)) {
                        //пропуск при совпадении имён
                        if (newFile.exists()) {
                            continue;
                        } else {
                            f.renameTo(new File(newName));
                        }
                    } else if (flagsEnumMap.get(Flags.BACKUP)){
                        if (newFile.exists()) {
                            newName = newName +"."+ Integer.toString(date.getYear()) + "." +
                                    Integer.toString(date.getMonthValue()) + "." +
                                    Integer.toString(date.getDayOfMonth())+"_"+
                                    Integer.toString(date.getHour()) +
                                    Integer.toString(date.getMinute()) +
                                    Integer.toString(date.getSecond());
                            f.renameTo(new File(newName));
                        } else {
                            f.renameTo(new File(newName));
                        }
                    } else {
                        f.renameTo(new File(newName));
                    }
                }
            }
        }
    }


    public static void main (String[] args) {
        int args_count = 0;
        String tmp = args[1];
        init();
        //проверить количество параметров
        if (args.length == 1) {
            //передали один аргумент. Начало с "-" - значит что идёт строка с короткими значениями
            if (args[0].substring(0, 1).equals("-")) {
                char c = args[0].charAt(1);
                if (c == Flags.PRINTHELP.toChar()) {
                    flagsEnumMap.replace(Flags.PRINTHELP, true);
                    System.out.println(getHelpString());
                    System.err.println("test");
                }
            }
        }
        if (args.length == 2) {
           //передали два аргумента. В этом случае считаю что строки со флагами нет.
           if (args[0].substring(0,1).equals("-")) {
                System.out.println("ошибка в случае 2х аргументов");
                return;
           }
            MoveElement element1 = null;
            MoveElement element2 = null;
            try {
                element1 = new MoveElement(args[0]);
                element2 = new MoveElement(args[1]);
            } catch (FileNotFoundException e) {
                System.out.println(e.getMessage());
                return;
            }
            move(element1, element2);

        }
        if (args.length == 3) {
            if (args[0].substring(0,1).equals("-")) {
                //разбираем флаги
                for (char c : args[0].toCharArray()) {
                    if (c == Flags.PRINTHELP.toChar()) {
                        flagsEnumMap.replace(Flags.PRINTHELP,true);
                        System.out.println(getHelpString());
                        return;
                    }
                    if (c == Flags.CREATEPATH.toChar()) {
                        flagsEnumMap.replace(Flags.CREATEPATH,true);
                        continue;
                    }
                    if (c == Flags.UPDATE.toChar()) {
                        flagsEnumMap.replace(Flags.UPDATE,true);
                        continue;
                    }
                    if (c == Flags.BACKUP.toChar()) {
                        flagsEnumMap.replace(Flags.BACKUP,true);
                        continue;
                    }
                    if (c == '-') continue;
                    throw new IllegalArgumentException("");
                }
            }
            //флаги прочитаны. Ожидаю что оставшиеся два аргумента будут валидными путями в ФС.
            MoveElement element1 = null;
            MoveElement element2 = null;
            try {
                element1 = new MoveElement(args[1]);
                element2 = new MoveElement(args[2]);
            } catch (FileNotFoundException e) {
                System.out.println(e.getMessage());
                return;
            }
            move(element1, element2);

        }
    }

}
