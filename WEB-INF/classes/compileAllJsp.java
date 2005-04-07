import java.util.*;
import java.io.*;

/**
 *  Description of the Class
 *
 *@author     root
 *@created    June 4, 2004
 */

public class compileAllJsp {

	/**
	 *  The main program for the compileAllJsp class
	 *
	 *@param  args             The command line arguments
	 *@exception  IOException  Description of the Exception
	 */
	public static void main(String[] args)
		throws IOException {

	String  host  = args[0];
	//e.g. http://www.abc.com:8080
	File    dir   = new File(args[1]);
		//e.g.  c:\\tomcat\\webapps\\app-name
		visitAllDirsAndFiles(dir, host);
	}


	// Process all files and directories under dir
	/**
	 *  Description of the Method
	 *
	 *@param  dir   Description of the Parameter
	 *@param  host  Description of the Parameter
	 */
	public static void visitAllDirsAndFiles(File dir, String host) {

		if (dir.isDirectory()) {
		String[]  children  = dir.list();

			for (int i = 0; i < children.length; i++) {
				visitAllDirsAndFiles(new File(dir, children[i]), host);
			}
		}

		else {
			visitAllFiles(dir, host);
		}

	}


	// Process only files under dir
	/**
	 *  Description of the Method
	 *
	 *@param  dir   Description of the Parameter
	 *@param  host  Description of the Parameter
	 */
	public static void visitAllFiles(File dir, String host) {
	Request  classified  = new Request();
	String   compileUrl  = null;
	int      count       = 0;

		if (dir.isDirectory()) {

		String[]  children  = dir.list();

			for (int i = 0; i < children.length; i++) {

				visitAllFiles(new File(dir, children[i]), host);
			}
		}

		else {

			if ((dir.toString().indexOf(".jsp") > -1) && (dir.toString().indexOf("~") == -1)) {
				compileUrl = host + dir.toString().substring(dir.toString().indexOf("webapps") + 7, dir.toString().length()) + "?jsp_precompile=true";
				compileUrl = compileUrl.replace('\\', '/');
				classified.setHost(compileUrl);
				classified.action();
				System.out.println(compileUrl);
			}

		}

	}

}

