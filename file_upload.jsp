<%
    class FileUpload
        {
        String saveFile(com.jspsmart.upload.File upFile, String path, ServletContext application)
            throws java.io.IOException, com.jspsmart.upload.SmartUploadException
            {
            path = application.getRealPath(path);

            String filename = upFile.getFileName().replaceAll("\\s", "");

            java.io.File f = new java.io.File(path, filename);

            // ensure uniqueness
            for (int i = 1; f.exists(); i++)
                {
                if (filename.matches(".*\\[\\d+\\]\\..*"))
                    filename = filename.replaceFirst("\\[\\d+\\]\\.", ".");

                filename = filename.replaceFirst("\\.(?=[^.]+$)", "[" + i + "].");

                f = new java.io.File(path, filename);
                }

            upFile.saveAs(f.getPath());

            return filename;
            }
        }
%>
