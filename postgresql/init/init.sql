--ユーーの作成
CREATE USER sample;
CREATE DATABASE sample;
--ユーザーにDBの権限をまとめて付与
GRANT ALL PRIVILEGES ON DATABASE sample TO sample;
\c sample
--テーブルを作成
CREATE TABLE book (
  id integer,
  name varchar(30)
);
--テーブルにデータを挿入
INSERT INTO book VALUES (1,'The Very Hungry Caterpillar');
