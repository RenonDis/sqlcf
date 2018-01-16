create database sncf;

use sncf;

# create tables
create table train ( 
numero integer primary key);

create table voiture ( 
numero int, 
places_dispo int, 
numero_train int, 
foreign key (numero_train) references train(numero),
primary key (numero, numero_train) );

/*
create table place ( 
numero int, 
cote_fenetre bool, 
voiture_numero int, foreign key (voiture_numero) references voiture(numero), 
train_numero int, foreign key (train_numero) references train(numero),
primary key(numero, voiture_numero, train_numero) );
*/

create table billet( 
numero int primary key, 
id_client int,
numero_place int,
numero_voiture int, foreign key (numero_voiture) references voiture(numero),
numero_train int, foreign key (numero_train) references train(numero),
ville_depart char(15), 
gare_depart char(15), 
ville_arrivee char(15), 
gare_arrivee char(15),
date_depart date, 
heure_depart time, 
date_arrivee date, 
heure_arrivee time,
prix float);
 
create table reduction (
reduction_type char(15) primary key, 
pourcentage float);

create table client_sncf (
nom char(15), 
prenom char(15), 
majeur bool, 
reduction_type char(15), 
id int primary key, 
foreign key (reduction_type) references reduction(reduction_type) );


##########   Remplissage BD   ##########

# reduction
insert into reduction () values ('J-8', 0.25);
insert into reduction () values ('J-30', 0.35);
insert into reduction () values ('Decouverte', 0.4);
insert into reduction () values ('-50%', 0.5);
insert into reduction () values ('Jeune', 0.5);

# train
insert into train () values (1);
insert into train () values (2);
insert into train () values (3);
insert into train () values (4);
insert into train () values (5);

# voiture
insert into voiture () values (1, 100, 1);
insert into voiture () values (2, 100, 1);
insert into voiture () values (1, 100, 2);
insert into voiture () values (2, 100, 2);
insert into voiture () values (1, 100, 3);
insert into voiture () values (2, 100, 3);
insert into voiture () values (1, 100, 4);
insert into voiture () values (2, 100, 4);
insert into voiture () values (1, 100, 5);
insert into voiture () values (2, 100, 5);

# place
# insert into place () values (45, true, 5);

# client_sncf
insert into client_sncf () values ('Aymar', 'Jean', true, NULL, 1);
insert into client_sncf () values ('Zbar', 'Joe', false, 'Jeune', 2);
insert into client_sncf () values ('Alezieubleu', 'Isabelle', true, 'J-8', 3);
insert into client_sncf () values ('Dupont', 'Marc', true, 'J-30', 4);
insert into client_sncf () values ('Boille', 'Danny', false, 'Decouverte', 5);
insert into client_sncf () values ('De-La-Tour', 'Franck', true, '-50%', 6);

# billet
insert into billet () values ( 1, 2, 10, 2, 1, 'Lyon', 'Part-Dieu', 'Marseille', 'St-Charles', '2018-02-25', '15:30:00', '2018-02-25', '17:40:00', 55.0);
insert into billet () values ( 2, 3, 21, 2, 2, 'Valence', 'Valence-Ville', 'Lyon', 'Jean-Mace', '2018-03-02', '8:00:00', '2018-03-02', '8:55:00', 19.5);
insert into billet () values ( 3, 4, 13, 1, 3, 'Macon', 'Macon-Gare', 'Paris', 'Gare de Lyon', '2018-01-25', '12:34:00', '2018-01-25', '14:45:00', 52.0);
insert into billet () values ( 4, 5, 42, 1, 4, 'Toulouse', 'Gare Toulouse', 'Biarritz', 'Gare du Soleil', '2018-02-13', '5:25:00', '2018-02-13', '6:30:00', 35.0);
insert into billet () values ( 5, 6, 53, 2, 5, 'Nancy', 'Gare Nancy', 'Metz', 'Gare Metz', '2018-05-02', '13:00:00', '2018-05-02', '13:40:00', 15.0);



##########   Create Views   ##########
# n° train | n° voiture | places dispo (reservées ou non)
select train.numero as 'n° train', 
voiture.numero as 'n° voiture', 
voiture.places_dispo 
from train, voiture
where voiture.numero_train = train.numero;

# client prenom | client nom | type reduction | taux de reduction
select client_sncf.prenom, 
client_sncf.nom, 
reduction.reduction_type, 
reduction.pourcentage 
from client_sncf, reduction
where reduction.reduction_type = client_sncf.reduction_type;

# billet n° | ville depart | ville arrivee | heure depart | date depart | n° train
select billet.numero as 'n° billet', 
billet.ville_depart, 
billet.ville_arrivee, 
billet.heure_depart, 
billet.date_depart, 
train.numero as 'n° train' 
from billet, train
where billet.numero_train = train.numero;

# n° train | nb voitures | nb total de places dispo (reservées ou non)
select train.numero as 'n° train',
(select count(*) from voiture where voiture.numero_train = train.numero) as 'nombre voitures',
(select sum(voiture.places_dispo) from voiture where voiture.numero_train = train.numero) as 'places total dispo'
from train;

# train n° | voiture n° | n° place reservée | côté fenêtre
select train.numero as 'n° train',
voiture.numero as 'n° voiture',
billet.numero_place as 'n° place reservée',
billet.numero_place % 2 = 0 as 'côté fenêtre'
from billet, train, voiture 
where billet.numero_train = train.numero and billet.numero_voiture = voiture.numero and train.numero = voiture.numero_train;


# train n° | voiture n° | nb places reservées
select train.numero as 'n° train',
voiture.numero as 'n° voiture',
(select count(*) from billet where billet.numero_train = train.numero and billet.numero_voiture = voiture.numero) as 'nb places reservées'
from train, voiture
where train.numero = voiture.numero_train;


##########   Triggers   ##########