-- Criação do banco de dados

create database if not exists default_mysql;

-- Ciação de um usuario

create user 'user'@'localhost' identified by "user2023";
grant all privileges on default_mysql.* to 'user'@'localhost';
flush privileges;

-- Seleção do banco de dados

use database default_mysql;

-- Criação da primeira tabela

create table if not exists clients(
    id int auto_increment primary key,
    nome varchar(255) not null,
    email varchar(255)
);

-- Criação da segunda tabela

create table if not exists pedido(
    id int auto_increment primary key,
    client_id int,
    produto varchar(255),
    quantidade int,
    foreign key (client_id) references client(id)
);

-- Inserção de dados na primeira tabela

insert into clients (nome,email) values 
    ("admin", "admin@gmail.om"),
    ("user", "user@gmail.com");


-- Inserção de dados na segunda tabela

insert into  pedido (client_id,produto,quantidade) values
    (1, "A", 3),
    (2, "B", 5);

-- Seleção de todos os registros das tableas
select * from cliente;
select * from pedido;
