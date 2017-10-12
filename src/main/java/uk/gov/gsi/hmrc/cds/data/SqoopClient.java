package uk.gov.gsi.hmrc.cds.data;

import com.cloudera.sqoop.SqoopOptions;

import java.io.IOException;


public class SqoopClient {

    private SqoopOptions sqoopOptions = new SqoopOptions();
    private CdsSqoopTool cdsSqoopTool = new CdsSqoopTool();
    private static final String HIVE_DATABASE_NAME_CLASSIFIER = "${DATAVAULT_DB}";

    private void setUp() {
        sqoopOptions.setConnectString(GenerateHql.CONNECTION_STRING + GenerateHql.PORT + "/" + GenerateHql.DB_NAME);
        sqoopOptions.setUsername(GenerateHql.USERNAME);
        sqoopOptions.setDriverClassName(GenerateHql.DRIVER);
        sqoopOptions.setHiveDropDelims(true);
        sqoopOptions.setHiveDatabaseName(HIVE_DATABASE_NAME_CLASSIFIER);
    }

    public void runSqoop(final String filePath, final String fileName) throws IOException {
        setUp();
        cdsSqoopTool.generateDataVaultHQL(sqoopOptions, filePath, fileName);
    }


}
