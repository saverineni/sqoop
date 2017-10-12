package uk.co.cds;

import ch.vorburger.exec.ManagedProcessException;
import ch.vorburger.mariadb4j.DB;
import ch.vorburger.mariadb4j.DBConfigurationBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseLoader {

    private static Logger logger = LoggerFactory.getLogger(DatabaseLoader.class);

    public void populateInMemoryDbase(String sqlFileName) {
        DBConfigurationBuilder configBuilder = DBConfigurationBuilder.newBuilder().setPort(33306);
        DB db = null;
        try {
            db = DB.newEmbeddedDB(configBuilder.build());
            db.start();
            try (Connection conn = DriverManager.getConnection(configBuilder.getURL(""), "root", "")) {
                db.source(sqlFileName);
                logger.info("*********Finished Importing SQL***********");
               // new SqoopClient().runSqoop(RESOURCE_PATH, hqlFileName);
            }
        } catch (SQLException | ManagedProcessException e) {
            logger.error("Exception occurred " + e);
        } finally {
            try {
                db.stop();
            } catch (ManagedProcessException e) {
                logger.error("Exception occurred " + e);
            }
        }
    }
}