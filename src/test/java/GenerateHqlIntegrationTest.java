import org.apache.commons.io.FileUtils;
import org.junit.Test;
import uk.co.cds.GenerateHql;

import java.io.File;

import static junit.framework.TestCase.assertTrue;

public class GenerateHqlIntegrationTest {

    public static final String SRC_TEST_RESOURCES = "src/test/resources/";
    private static final File EXPECTED_HIVE_FILE = new File("hivefiles/expectedHiveFile.q");

    @Test
    public void GeneratesHql() throws Exception {
        File resourcesDirectory = new File(SRC_TEST_RESOURCES + "testwmbfiles/DataVault_MySQLWB.mwb");
        GenerateHql hql = new GenerateHql();
        hql.setResourcePath(SRC_TEST_RESOURCES);
        hql.generateHqlFromMwb(resourcesDirectory.getPath());
        File actualHiveFile = new File("DataVault_MySQLWB.q");
        assertTrue("The files differ!", FileUtils.contentEquals(EXPECTED_HIVE_FILE, actualHiveFile));
    }
}
