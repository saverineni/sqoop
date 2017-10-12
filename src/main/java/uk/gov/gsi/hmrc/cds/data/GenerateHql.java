package uk.gov.gsi.hmrc.cds.data;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

public class GenerateHql {

    public static final String CONNECTION_STRING = PropertiesFileUtil.getProperty("CONNECTION_STRING");
    public static final String DB_NAME = PropertiesFileUtil.getProperty("DB_NAME");
    public static final String USERNAME = PropertiesFileUtil.getProperty("USERNAME");
    public static final int PORT = PropertiesFileUtil.getIntProperty("PORT");
    public static final String DRIVER = PropertiesFileUtil.getProperty("DRIVER");
    private static final String SQL_FILE_EXTENSION = ".sql";
    private String resourcePath = "src/main/resources/";
    private static Logger logger = LoggerFactory.getLogger(GenerateHql.class);

    public static void main(String args[]) {
        GenerateHql sql = new GenerateHql();
        String RESOURCES_PATH = "src/main/resources/wmbfiles/DataVault_MySQLWB.mwb";//"src/main/resources";
        sql.generateHqlFromMwb(RESOURCES_PATH);
    }

    public void generateHqlFromMwb(String wmbFilePath) {
        logger.info("*********Started Converting wmb file to hive HQL***********");
        String wmbFileAbsolutePath = new File(wmbFilePath).getAbsolutePath();
        String wmbFileName = FilenameUtils.getName(wmbFilePath);
        String sqlFileName = getFileNameByExt(wmbFileName, SQL_FILE_EXTENSION);
        File sqlFile = new File(resourcePath + sqlFileName);
        File tempShFile = getTempFile();
        try {
            ProcessBuilder builder = new ProcessBuilder("/bin/bash", tempShFile.getName(), wmbFileAbsolutePath, sqlFile.getAbsolutePath());
            builder.directory(new File(resourcePath));
            Process process = builder.start();

            int exitCode = process.waitFor();
            if (exitCode == 0) {
                logger.info("*********Finished creating SQL***********");
                addResourcesFolderToClasspath(new File(resourcePath));
                new HiveGenerator().generateHiveHql(resourcePath, sqlFileName);
            }
            logger.info("*********Finished creating hive HQL***********");
        } catch (InterruptedException e) {
            logger.error("Exception occurred " + e);
        } catch (Exception e) {
            logger.error("Exception occurred " + e);
        } finally {
            cleanResources(sqlFile, tempShFile);
        }

    }

    private File getTempFile() {
        Path path = Paths.get(resourcePath + "mwbtosql.sh");
        File tempFile = null;
        try {
            List<String> lines = Files.readAllLines(path, StandardCharsets.UTF_8);
            tempFile = File.createTempFile("mwbtosql-tmp", ".sh", new File(resourcePath));
            try (BufferedWriter bw = new BufferedWriter(new FileWriter(tempFile))) {
                for (String line : lines) {
                    bw.write(line);
                    bw.newLine();
                }
                bw.flush();
            }
        } catch (IOException e) {
            logger.error("Exception occurred" + e);
        }
        return tempFile;
    }


    private void addResourcesFolderToClasspath(File file) throws Exception {
        Method method = URLClassLoader.class.getDeclaredMethod("addURL", new Class[]{URL.class});
        method.setAccessible(true);
        method.invoke(ClassLoader.getSystemClassLoader(), new Object[]{file.toURI().toURL()});
    }

    private String getFileNameByExt(String fileName, String ext) {
        return fileName.substring(0, fileName.lastIndexOf(".")) + ext;
    }

    private void cleanResources(File sqlFile, File tempShFile) {
        sqlFile.deleteOnExit();
        tempShFile.deleteOnExit();
    }

    public void setResourcePath(String resourcePath) {
        this.resourcePath = resourcePath;
    }

}
