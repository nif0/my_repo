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



    public MoveElement(String f) {
        originalPath = f;
        File x;
        x = new File(f);
        while (!x.exists()) {
            x = new File(x.getParent());
        }
        existsPath = x.toPath().toString();
        nameMask = f.substring(existsPath.length());
        pattern = Pattern.compile(nameMask);
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

        Predicate<File> p = new Predicate<File>() {
            @Override
            public boolean test(File file) {
                return file.isDirectory();
            }
        };
        return arrayList.stream().filter(p).count();
    }

    public long getNumberFiles() {
       // return 0;

        Predicate<File> p = new Predicate<File>() {
            @Override
            public boolean test(File file) {
                return file.isFile();
            }
        };
        return arrayList.stream().filter(p).count();
    }

    public boolean closeSeparator() {
        boolean result;
        result = originalPath.substring(originalPath.length()-1).equals( File.pathSeparatorChar);
        return result;
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
