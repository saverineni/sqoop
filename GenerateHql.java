package uk.gov.gsi.hmrc.cds.data;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.jdbc.ScriptRunner;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;

public class GenerateHql {

    public static final String CONNECTION_STRING = PropertiesFileUtil.getProperty("CONNECTION_STRING");
    public static final String DB_NAME = PropertiesFileUtil.getProperty("DB_NAME");
    public static final String USERNAME = PropertiesFileUtil.getProperty("USERNAME");
    public static final String PASSWORD = PropertiesFileUtil.getProperty("PASSWORD");
    public static final String DRIVER = PropertiesFileUtil.getProperty("DRIVER");
    private static final String SQL_FILE_EXTENSION = ".sql";
    private static final String HQL_FILE_EXTENSION = ".q";
    private static final String RESOURCE_PATH = "src/main/resources/";

    private static Logger logger = LoggerFactory.getLogger(GenerateHql.class);

    public static void main(String... args) throws IOException, InterruptedException, SQLException, ClassNotFoundException {
        logger.info(">>>> Start of generation of Hive HQL from MySql Workbench file <<<< ");
        GenerateHql sql = new GenerateHql();
        String RESOURCES_PATH = "src/main/resources/DataVault_MySQLWB.mwb";
        sql.generateHqlFromMwb(RESOURCES_PATH);
    }

    public void generateHqlFromMwb(String wmbFilePath) throws IOException, InterruptedException, SQLException, ClassNotFoundException {
        String filePath = FilenameUtils.getFullPath(wmbFilePath);
        String fileName = FilenameUtils.getName(wmbFilePath);
        String sqlFileName = getFileNameByExt(fileName, SQL_FILE_EXTENSION);
        final String hqlFileName = getFileNameByExt(fileName, HQL_FILE_EXTENSION);

        ProcessBuilder builder = new ProcessBuilder("/bin/bash", getTempFile(), fileName, RESOURCE_PATH+sqlFileName);
        builder.directory(new File(filePath));
        Process process = builder.start();
        int exitCode = process.waitFor();
        if (exitCode == 0)
            mysqlLoad(filePath, sqlFileName);

        logger.info(">>>> SQL generated successfully <<<<");

        new SqoopClient().runSqoop(RESOURCE_PATH, hqlFileName);
        logger.info(">>>> End of generation of Hive HQL from MySql Workbench file <<<<");
    }

    private String getTempFile() throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(getClass().getClassLoader().getResource("mwbtosql.sh").openStream()));
        File tempFile = File.createTempFile("tempfile", ".sh", new File(RESOURCE_PATH));
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(tempFile)));

        Scanner sc = new Scanner(br);
        while (sc.hasNextLine()) {
            bw.write(sc.nextLine());
            bw.newLine();
        }
        bw.flush();
        tempFile.deleteOnExit();
        return tempFile.getName();
    }

    private void mysqlLoad(final String filePath, final String sqlFileName) throws ClassNotFoundException, SQLException, IOException {

        try (BufferedReader br = new BufferedReader(new FileReader(filePath + sqlFileName))) {
            Connection connection = DriverManager.getConnection(CONNECTION_STRING, USERNAME, PASSWORD);

            ScriptRunner sr = new ScriptRunner(connection);
            sr.runScript(br);
        }
    }

    private String getFileNameByExt(String fileName, String ext) {
        return fileName.substring(0, fileName.lastIndexOf(".")) + ext;
    }

}
