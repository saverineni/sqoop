package uk.gov.gsi.hmrc.cds.data;

import ch.vorburger.exec.ManagedProcessException;
import ch.vorburger.mariadb4j.DB;
import ch.vorburger.mariadb4j.DBConfigurationBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class HiveGenerator {

    private static Logger logger = LoggerFactory.getLogger(HiveGenerator.class);

    public void generateHiveHql(String resourcePath, String sqlFileName) throws ManagedProcessException, SQLException, IOException {
        DBConfigurationBuilder configBuilder = DBConfigurationBuilder.newBuilder().setPort(GenerateHql.PORT);
        DB db = DB.newEmbeddedDB(configBuilder.build());
        db.start();
        try (Connection conn = DriverManager.getConnection(configBuilder.getURL(""), GenerateHql.USERNAME, "")) {
            db.source(sqlFileName);
            logger.info("*********Finished Importing SQL***********");
            logger.info("*********Started creating SQL***********");
            new SqoopClient().runSqoop(resourcePath, getFileNameByExt(sqlFileName, ".q"));
        } finally {
            db.stop();
        }

    }

    private String getFileNameByExt(String fileName, String ext) {
        return fileName.substring(0, fileName.lastIndexOf(".")) + ext;
    }


}