#!/bin/bash
set -e
set -u

#--Global Variables---
USERNAME="$POSTGRES_USER"
FILEPATH="/sql_files"
FILE_NAME="schema.sql"
DEFAULT_DB="postgres"
POSTGRES_MULTIPLE_DB=$(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' ')

echo "[ USER_NAME : $USERNAME ]"
echo "[ $POSTGRES_MULTIPLE_DB ]"

echo "[ running database creation script ]"


function create_database(){
	local DB_NAME=$1
	echo "[ --------------- Creating $DB_NAME Database----------------- ]"
	psql -v ON_ERROR_STOP=1 $DEFAULT_DB  $USERNAME <<-EOSQL
		CREATE DATABASE $DB_NAME;
		GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $USERNAME;
	EOSQL
	echo "[ --------------- $DB_NAME Successfully Created ---------- ]"
}

function create_tables_under_database(){
	local DB_NAME=$1
	echo "[ ------------ Creating Tables under $DB_NAME ------------------- ]"
	psql -v ON_ERROR_STOP=1 $DB_NAME $USERNAME -f "$FILEPATH/$FILE_NAME"
	echo "[ ------------ Successfully Created Tables Under $DB_NAME --------- ]"
}




#-----main function-----function creates database and checks if db == mmdb then it creates tables for that
if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]
then
for db in $POSTGRES_MULTIPLE_DB
	do
		create_database $db
    create_tables_under_database $db
	done
fi