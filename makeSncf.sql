create database sncf;

use sncf;

# create tables
create table train ( id integer primary key, numero int );
create table voiture ( id integer primary key, numero int, places_dispo int, train_id int, foreign key (train_id) references train(id) );
create table place ( numero int, cote_fenetre bool, voiture_id int, foreign key (voiture_id) references voiture(id), primary key(numero, voiture_id) );
create table billet( id_agence int, numero int, id_client int default NULL, ville_depart char(15), gare_depart char(15), ville_arrivee char(15), gare_arrivee char(15), date_depart date, heure_depart time, date_arrivee date, heure_arrivee time, prix float, train_id int, foreign key(train_id) references train(id), primary key(numero, id_agence));
create table reduction (reduction_type char(15) primary key, pourcentage float);
create table client_sncf (nom char(15), prenom char(15), majeur bool, reduction_type char(15), id int primary key, foreign key (reduction_type) references reduction(reduction_type) );


##########   Remplissage BD   ##########

# reduction
insert into reduction () values ('J-8', 0.25);
insert into reduction () values ('J-30', 0.35);
insert into reduction () values ('Decouverte', 0.4);
insert into reduction () values ('-50%', 0.5);
insert into reduction () values ('Jeune', 0.5);

# train
insert into train () values (1, 123);
insert into train () values (2, 456);
insert into train () values (3, 789);
insert into train () values (4, 101);
insert into train () values (5, 121);

# voiture
insert into voiture () values (1, 20, 100, 1);
insert into voiture () values (2, 12, 100, 1);
insert into voiture () values (3, 3, 100, 2);
insert into voiture () values (4, 8, 100, 2);
insert into voiture () values (5, 16, 100, 3);
insert into voiture () values (6, 4, 100, 3);
insert into voiture () values (7, 5, 100, 4);
insert into voiture () values (8, 16, 100, 4);
insert into voiture () values (9, 1, 100, 5);
insert into voiture () values (10, 8, 100, 5);

# place
insert into place () values (45, true, 5);

# client_sncf
insert into client_sncf () values ('Aymar', 'Jean', true, NULL, 1);
insert into client_sncf () values ('Zbar', 'Joe', false, 'Jeune', 2);
insert into client_sncf () values ('Alezieubleu', 'Isabelle', true, 'J-8', 3);
insert into client_sncf () values ('Dupont', 'Marc', true, 'J-30', 4);
insert into client_sncf () values ('Boille', 'Danny', false, 'Decouverte', 5);
insert into client_sncf () values ('De-La-Tour', 'Franck', true, '-50%', 6);

# billet
insert into billet () values ( 1, 1234, 1, 'Lyon', 'Part-Dieu', 'Marseille', 'St-Charles', '2018-02-25', '15:30:00', '2018-02-25', '17:40:00', 55.0, 1);
insert into billet () values ( 1, 1025, 2, 'Valence', 'Valence-Ville', 'Lyon', 'Jean-Mace', '2018-03-02', '8:00:00', '2018-03-02', '8:55:00', 19.5, 2);
insert into billet () values ( 1, 548, 3, 'Macon', 'Macon-Gare', 'Paris', 'Gare de Lyon', '2018-01-25', '12:34:00', '2018-01-25', '14:45:00', 52.0, 3);
insert into billet () values ( 1, 789, 4, 'Toulouse', 'Gare Toulouse', 'Biarritz', 'Gare du Soleil', '2018-02-13', '5:25:00', '2018-02-13', '6:30:00', 35.0, 4);
insert into billet () values ( 1, 54, 5, 'Nancy', 'Gare Nancy', 'Metz', 'Gare Metz', '2018-05-02', '13:00:00', '2018-05-02', '13:40:00', 15.0, 5);



##########   Create Views   ##########
# train numero | voiture numero | places dispo
select train.numero as train_numero, voiture.numero as voiture_numero, voiture.places_dispo from train, voiture
where voiture.train_id = train.id;

# client prenom | client nom | type reduction | taux de reduction
select client_sncf.prenom, client_sncf.nom, reduction.reduction_type, reduction.pourcentage from client_sncf, reduction
where reduction.reduction_type = client_sncf.reduction_type;

# billet n° | ville depart | ville arrivee | heure depart | date depart | train n°
select billet.numero as 'numero billet', billet.ville_depart, billet.ville_arrivee, billet.heure_depart, billet.date_depart, train.numero as 'numero train' from billet, train
where billet.train_id = train.id;

# train n° | nb voitures | nb total de places dispo
select train.numero,
(select count(*) from voiture where voiture.train_id = train.id) as 'nombre voitures',
(select sum(voiture.places_dispo) from voiture where voiture.train_id = train.id) as 'places total dispo'
from train;


##########   Triggers   ##########


