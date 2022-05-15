#!bin/bash
if [ $# -ne 2 ]; then
  echo $1
  PGPASSWORD=password psql -h localhost -p 5432 -U user -d sample -f $1
else
  echo plese specify 1 file name
fi
