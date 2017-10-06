package uk.co.cds;

import ch.vorburger.exec.ManagedProcessException;
import org.apache.ibatis.jdbc.ScriptRunner;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class GenerateSql {

    public static final String RESOURCES_PATH = "/Users/suresh.averineni/Documents/mysql-mwb/";//"src/main/resources";
    public static final String CONNECTION_URL = "jdbc:mysql://localhost:3306/mydb?user=root&password=root";

    public static void main(String args[]) throws IOException, InterruptedException, SQLException, ManagedProcessException, ClassNotFoundException {
        GenerateSql sql = new GenerateSql();
        ProcessBuilder builder = new ProcessBuilder("/bin/bash", sql.getTempFile(), "DataVault_MySQLWB.mwb", "DataVault_MySQLWB.sql");
        builder.directory(new File(RESOURCES_PATH));
        Process process = builder.start();

        int exitCode = process.waitFor();
        assert exitCode == 0;
        sql.mysqlLoad();
    }

    private String getTempFile() throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(getClass().getClassLoader().getResource("mwbtosql.sh").openStream()));
        File tempFile = File.createTempFile("tempfile", ".sh", new File(RESOURCES_PATH));
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(tempFile)));

        Scanner sc = new Scanner(br);
        while (sc.hasNextLine()) {
            bw.write(sc.nextLine());
            bw.newLine();
        }
        bw.flush();
        return tempFile.getName();
    }

    private void mysqlLoad() throws ClassNotFoundException, SQLException, IOException {
        InputStreamReader inputStreamReader = new InputStreamReader(new FileInputStream(new File(RESOURCES_PATH + "DataVault_MySQLWB.sql")));
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(CONNECTION_URL);
        ScriptRunner sr = new ScriptRunner(connection);
        sr.runScript(inputStreamReader);
        Statement statement = connection.createStatement();
        statement.close();
        connection.close();
    }
}
