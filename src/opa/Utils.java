package opa;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FilenameUtils;


public class Utils {
	
	public static Map<String, String> gatherStrings(List<FileItem> items) {
		Map<String, String> map = new HashMap<String, String>();
		
		for(FileItem item : items) {
			
			if(item.isFormField())
				map.put(item.getFieldName(), item.getString());
		}
		
		return map;
	}
	
	public static Map<String, File> gatherFiles(List<FileItem> items, String baseDir) throws Exception {
		Map<String, File> map = new HashMap<String, File>();
		
		for(FileItem item : items) {
			
			if(!item.isFormField() && !"".equals(item.getName())) {
		        String filename = FilenameUtils.getName(item.getName()); // internet explorer 5.5 gives full path
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
}