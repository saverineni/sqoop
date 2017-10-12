# generate sql from mwb
# usage: sh mwb2sql.sh {mwb file} {output file} - sh mwbtosql.sh date.mwb m.sql
# prepare: set env MYSQL_WORKBENCH

if [ "$MYSQL_WORKBENCH" = "" ]; then
  export MYSQL_WORKBENCH="/Applications/MySQLWorkbench.app/Contents/MacOS/MySQLWorkbench"
fi

export INPUT=$(cd $(dirname $1);pwd)/$(basename $1)
export OUTPUT=$(cd $(dirname $2);pwd)/$(basename $2)

echo $dirname$1
echo $INPUT
echo $OUTPUT

"$MYSQL_WORKBENCH" \
  --model $INPUT \
  --run-python "
import os
import grt
c = grt.root.wb.doc.physicalModels[0].catalog
grt.modules.DbMySQLFE.generateSQLCreateStatements(c, c.version, {})
grt.modules.DbMySQLFE.createScriptForCatalogObjects(os.getenv('OUTPUT'), c, {})" \
  --quit-when-done
