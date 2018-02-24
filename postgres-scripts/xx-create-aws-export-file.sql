SELECT locality_pid, locality_name, postcode, state, ST_AsBinary(geom) AS geom FROM admin_bdys_201802.locality_bdys_display;



psql -U postgres -c "COPY (SELECT locality_pid, locality_name, postcode, state, ST_AsBinary(geom) AS geom FROM admin_bdys_201802.locality_bdys_display) TO stdout DELIMITER '|'" geo | gzip > locality_bdys_display.psv.gz


--athena table definition
locality_pid string, locality_name string, postcode string, state string, geom binary


CREATE EXTERNAL TABLE `locality_bdys_display`(
  `locality_pid` string, 
  `locality_name` string, 
  `postcode` string, 
  `state` string, 
  `geom` binary)
ROW FORMAT SERDE 
  'com.esri.hadoop.hive.serde.JsonSerde' 
STORED AS INPUTFORMAT 
  'com.esri.json.hadoop.EnclosedJsonInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://minus34.com/opendata/psma-201802/admin_bdys'



CREATE EXTERNAL TABLE `locality_bdys_display`(
  `locality_pid` string, 
  `locality_name` string, 
  `postcode` string, 
  `state` string, 
  `geom` binary)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '|'
  ESCAPED BY '\\'
  LINES TERMINATED BY '\n' 
STORED AS INPUTFORMAT 
  'com.esri.json.hadoop.EnclosedJsonInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://minus34.com/opendata/psma-201802/admin_bdys'
