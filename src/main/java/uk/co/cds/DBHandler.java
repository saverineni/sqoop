package uk.co.cds;

import java.sql.*;

public class DBHandler {

    private String connectionString;
    private Connection connection;
    private ResultSet rs;
    private String userName;
    private String password;

    public DBHandler() {
        connectionString = "";
    }

    public DBHandler(String connectionString) throws SQLException {
        this.connectionString = connectionString;
        this.connect();
    }

    public DBHandler(String connectionString, String userName, String password) throws SQLException {
        this.connectionString = connectionString;
        this.userName = userName;
        this.password = password;
        this.connect();
    }

    public void setConnectionString(String connectionString) {
        this.connectionString = connectionString;
    }


    public final void connect() throws SQLException {
        connection = DriverManager.getConnection(connectionString, userName, password);
    }

    public ResultSet executeQuery(String query) throws SQLException {
        if (connection != null) {
            Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery(query);
        }
        return rs;
    }


    public void close() throws SQLException {
        if (connection != null) {
            connection.close();
        }
    }

}
