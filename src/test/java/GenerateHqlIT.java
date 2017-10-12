import org.apache.commons.io.FileUtils;
import org.junit.After;
import org.junit.Test;
import uk.gov.gsi.hmrc.cds.data.GenerateHql;

import java.io.File;
import java.nio.charset.Charset;

import static org.junit.Assert.assertEquals;

public class GenerateHqlIT {

    private static final String SRC_TEST_RESOURCES = "src/test/resources/";
    private static final File EXPECTED_HIVE_FILE = new File(SRC_TEST_RESOURCES + "hivefiles/expected-DataVault_MySQLWB.q");
    private static final String WMB_FILE_PATH = SRC_TEST_RESOURCES + "testwmbfiles/DataVault_MySQLWB.mwb";
    private static final File ACTUAL_HIVE_FILE = new File(SRC_TEST_RESOURCES + "hive-hql/DataVault_MySQLWB.q");

    @Test
    public void GeneratesHql() throws Exception {
        File resourcesDirectory = new File(WMB_FILE_PATH);
        GenerateHql hql = new GenerateHql();
        hql.setResourcePath(SRC_TEST_RESOURCES);
        hql.generateHqlFromMwb(resourcesDirectory.getPath());
        assertEquals(FileUtils.readLines(EXPECTED_HIVE_FILE, Charset.defaultCharset()), FileUtils.readLines(ACTUAL_HIVE_FILE, Charset.defaultCharset()));
    }

    @After
    public void cleanResources() {
        if (ACTUAL_HIVE_FILE.exists()) {
            ACTUAL_HIVE_FILE.deleteOnExit();
        }
    }
}
