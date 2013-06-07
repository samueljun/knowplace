#! /bin/bash
# This script resets the database by running the three sql files in sequence

if [ -a sql/reset.sql ]; then
	rm sql/reset.sql
fi

cat sql/destroy.sql sql/create.sql sql/testdata.sql > sql/reset.sql
cat sql/reset.sql | psql -1 -h localhost -d mydb -U postgres