--ユーーの作成
CREATE USER sample;
CREATE DATABASE sample;
--ユーザーにDBの権限をまとめて付与
GRANT ALL PRIVILEGES ON DATABASE sample TO sample;
\c sample
--テーブルを作成
CREATE TABLE Test (
  id integer,
  name varchar(30),
  value Integer
);
--テーブルにデータを挿入
INSERT INTO Test VALUES (1,'The Very Hungry Caterpillar', 10);
INSERT INTO Test VALUES (2,'aaa', 20);
INSERT INTO Test VALUES (3,'bbb', 30);
INSERT INTO Test VALUES (4,'ccc', 40);
INSERT INTO Test VALUES (5,'ddd', 50);
