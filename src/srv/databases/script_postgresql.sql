-- Criação do banco de dados

create database default_mysql;

-- Ciação de um usuario

create user user with password 'user123';
alter role user set client_encoding to 'utf8';
alter role user set default_transaction_isolation to 'read committed';
alter role user set timezone to 'utc';

grant all privileges on database default_mysql to user;

-- Seleção do banco de dados

\c default_mysql;

-- Criação da primeira tabela

create table if not exists clients(
    id serial primary key,
    nome varchar(255) not null,
    email varchar(255)
);

-- Criação da segunda tabela

create table if not exists pedido(
    id serial primary key,
    client_id int,
    produto varchar(255),
    quantidade int,
    foreign key (client_id) references clients(id)
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
