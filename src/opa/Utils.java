package opa;

import java.io.File;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Chris Longtin
 * @email chris.longtin@gmail.com
 * 
 *        This class holds miscellaneous utility methods.
 * 
 */
public class Utils {

    private final static Log log = LogFactory.getLog(Utils.class);

    /**
     * Given a list of FileItem's, gather all of the key/value pairs from them.
     * This method exclude and FileItem's that are Files.
     * 
     * WARNING: request parameter's can have multi-values per key. I suspect opa
     * doesn't utilize this 'feature' anyways. If two of the FileItem's have the
     * same fieldName, then the latest one will overwrite them all. does not
     * honor it.
     * 
     * @param items
     * @return Map of key/value pairs
     */
    public static Map<String, String> gatherStrings(List<FileItem> items) {
        Map<String, String> map = new HashMap<String, String>();
        
        for(FileItem item : items) {
            
            if(item.isFormField())
                map.put(item.getFieldName(), item.getString());
        }
        
        return map;
    }

    /**
     * Given a list of FileItem's, gather all of the FileItems that are actually
     * Files and save them to baseDir.
     * 
     * WARNING: request parameter's can have multi-values per key. I suspect opa
     * doesn't utilize this 'feature' anyways. If two of the FileItem's have the
     * same fieldName, then the latest one will overwrite them all. does not
     * honor it.
     * 
     * @param items
     * @param baseDir directory to store files
     * @return Map of filenames and File's
     * @throws Exception If there is an error in storing any of the files to baseDir
     */
    public static Map<String, File> gatherFiles(List<FileItem> items, String baseDir) throws Exception {
        Map<String, File> map = new HashMap<String, File>();
        
        for(FileItem item : items) {
            
            if(!item.isFormField() && !"".equals(item.getName())) {
                // internet explorer 5.5 gives full path, we only want the name
                String filename = FilenameUtils.getName(item.getName()); 
                
                filename = filename.replaceAll("\\s", "");
                
                File file = new File(baseDir, filename);

                // ensure uniqueness
                for (int i = 1; file.exists(); i++) {
                    if (filename.matches(".*\\[\\d+\\]\\..*"))
                        filename = filename.replaceFirst("\\[\\d+\\]\\.", ".");

                    filename = filename.replaceFirst("\\.(?=[^.]+$)", "[" + i + "].");

                    file = new File(baseDir, filename);
                }

                map.put(item.getFieldName(), file);
                item.write(file);
            }
        }
        
        return map;
    }
    
    /**
     * This method will convert a ResultSet row into a key/value Map.
     * 
     * @param rs
     * @return A key/value map that may be empty if no fields were present in
     *         the ResultSet or null if an error occurred while getting data
     *         from the ResultSet
     */
    public static Map<String, Object> resultSetToMap(ResultSet rs) {
        Map<String, Object> map = new HashMap<String, Object>();
        
        try {
            ResultSetMetaData metaData = rs.getMetaData();
            for(int i = 1 ; i <= metaData.getColumnCount() ; ++i) { // heh, offset starting at 1
                String key = metaData.getColumnName(i);
                Object value = rs.getObject(i);
                
                map.put(key, value);
            }
        }
        catch(Exception e) {
            log.error(e, e);
            map = null;
        }
        
        return map;
    }
}