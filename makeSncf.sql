create database sncf;

use sncf;

create table train ( id integer primary key, numero int );

create table voiture ( id integer primary key, numero int, train_id int, foreign key (train_id) references train(id) );
