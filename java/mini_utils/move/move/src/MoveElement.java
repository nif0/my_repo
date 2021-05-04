import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.function.Predicate;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;
import java.util.stream.Stream;

public class MoveElement {
    private ArrayList<File> arrayList;
    private String existsPath;
    private String nameMask;
    private String originalPath;
    private Pattern pattern;
    private boolean closeSeparator = false;



    public MoveElement(String f) {
        originalPath = f;
        if (f.indexOf("\"") == f.length()-1) {
            f = f.substring(0,f.length()-1);
            //closeSeparator = true;
        }
        String t = f.substring(f.length()-1);
        closeSeparator = (t.equals(File.separator));
        File x;
        x = new File(f);
        while (!x.exists()) {
            x = new File(x.getParent());
        }
        existsPath = x.toPath().toString() + (closeSeparator ? File.separator : "");
        try {
            //выход за границы массива при компиляции паттерна в ситуации, когда existsPath > f.
            if (f.length() < existsPath.length()) {
                nameMask = "";
            } else {
                if (f.length() == existsPath.length()) {
                    nameMask = "";
                } else nameMask = f.substring(existsPath.length() + 1);
            }
            pattern = Pattern.compile(nameMask);
        }
        catch (Exception e) {
            e.printStackTrace();
            System.out.println("nameMask: "+nameMask);
            pattern = Pattern.compile("");
        }
        arrayList = getItemList();
    }

    public MoveElement(String path, String filemask) {
        File test = new File(path);
        if (test.exists()) {
            existsPath = path;
        }
        nameMask = filemask;
        try {
            pattern = Pattern.compile(nameMask);
        } catch (PatternSyntaxException e) {
            pattern = null;
            nameMask = "";
        }
        arrayList = getItemList();
    }

    public ArrayList<File> getFileList() {
        return arrayList;
    }

    public String getExsistPath() {
         return existsPath;
    }

    public String getNameMask() {
         return nameMask;
    }

    public int getNumberRealElement() {
         return arrayList.size();
    }

    public long getNumberDirectories() {
        //return 0;
        long result = 0;
        Predicate<File> p = new Predicate<File>() {
            @Override
            public boolean test(File file) {
                return file.isDirectory();
            }
        };
        result = arrayList.stream().filter(p).count();
        return result;
    }

    public long getNumberFiles() {
       // return 0;
        long result = 0;
        Predicate<File> p = new Predicate<File>() {
            @Override
            public boolean test(File file) {
                return file.isFile();
            }
        };
        result = arrayList.stream().filter(p).count();
        return result;
    }

    public boolean closeSeparator() {
        return this.closeSeparator;
    }

    private ArrayList<File> getItemList() {
        File tmp = new File(existsPath);
        ArrayList<File>  result = new ArrayList<>();

        if (tmp.isFile()) {
            result.add(tmp);
            return result;
        }
        if (!nameMask.equals("")) {
            for (File f : tmp.listFiles()) {
                if (f.getAbsolutePath().matches(nameMask)) result.add(f);
            }
        } else result.add(tmp);
        return result;
    }

    public String getOriginalPath() {
        return originalPath;
    }



}
