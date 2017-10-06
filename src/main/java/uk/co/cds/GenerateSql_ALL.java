package uk.co.cds;

import ch.vorburger.exec.ManagedProcessException;
import ch.vorburger.mariadb4j.DB;
import ch.vorburger.mariadb4j.DBConfigurationBuilder;
import org.apache.ibatis.jdbc.ScriptRunner;
import org.h2.jdbcx.JdbcConnectionPool;
import org.h2.tools.RunScript;

import java.io.*;
import java.sql.*;
import java.util.Scanner;

public class GenerateSql_ALL {

    public static final String RESOURCES_PATH = "src/main/resources";

//    String driverClassName = "org.h2.Driver";
//    //String url = "jdbc:h2:mem:myDb;INIT=runscript from '~/create.sql'";
//    String url = "jdbc:h2:mem:myDb;INIT=runscript from 'create.sql'";
//    String username = "sa";
//    String password = "sa";
    //String url = "jdbc:h2:mem:test;INIT=runscript from '~/create.sql'";

    public static void main(String args[]) throws IOException, InterruptedException, SQLException, ManagedProcessException, ClassNotFoundException {
        GenerateSql_ALL sql = new GenerateSql_ALL();
        ProcessBuilder builder = new ProcessBuilder("/bin/bash", sql.getTempFile(), "DataVault_MySQLWB.mwb", "DataVault_MySQLWB.sql");
        builder.directory(new File(RESOURCES_PATH));
        Process process = builder.start();

        BufferedReader inStreamReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        while (inStreamReader.readLine() != null) {
            System.out.println(inStreamReader.readLine());
        }
        int exitCode = process.waitFor();
        assert exitCode == 0;
        //sql.populateInMemoryDbase();
//        sql.populateInMemoryHslDBDbase();
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


    private void populateInMemoryDbase() throws ManagedProcessException, SQLException {
        DBConfigurationBuilder configBuilder = DBConfigurationBuilder.newBuilder();
        configBuilder.setPort(33306);
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/test", "root", "");
        DB db = DB.newEmbeddedDB(configBuilder.build());
        try {
            db.start();
            File sqlFile = new File("resources/DataVault_MySQLWB.sql");
            db.source(sqlFile.getAbsolutePath());
            conn = DriverManager.getConnection("jdbc:mysql://localhost/DataVault", "root", "");
            getTableNames(conn);
            System.out.println("*********Finished Importing ***********");
        } finally {
            conn.close();
            db.stop();
        }

    }

    private void populateInMemoryHslDBDbase() throws ManagedProcessException, SQLException, ClassNotFoundException, IOException {
        InputStreamReader inputStreamReader = new InputStreamReader(getClass().getClassLoader().getResource("DataVault_MySQLWB.sql").openStream());

        JdbcConnectionPool cp = JdbcConnectionPool.create("jdbc:h2:~/test", "sa", "");
        Connection conn = cp.getConnection();
        RunScript.execute(conn, inputStreamReader);
        conn.close();
        cp.dispose();
    }

    private void mysqlLoad() throws ClassNotFoundException, SQLException, IOException {
        InputStreamReader inputStreamReader = new InputStreamReader(getClass().getClassLoader().getResource("DataVault_MySQLWB.sql").openStream());
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?" + "user=root&password=root");
        ScriptRunner sr = new ScriptRunner(connection);
        sr.runScript(inputStreamReader);
        Statement statement = connection.createStatement();
        statement.close();
        connection.close();
    }

    private void getTableNames(Connection conn) {
        try {

            DatabaseMetaData dbmd = conn.getMetaData();
            String[] types = {"TABLE"};
            ResultSet rs = dbmd.getTables(null, null, "%", types);
            StringBuilder builder = new StringBuilder();
            while (rs.next()) {
                builder.append(rs.getString("TABLE_NAME") + ",");
            }
            System.out.println(builder);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
