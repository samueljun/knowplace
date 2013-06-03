#! /bin/bash
# This script resets the database by running the three sql files in sequence

cat destroy.sql create.sql testdata.sql | psql -1 -h localhost -d mydb -U postgres
