create database sncf;

use sncf;

##########   Create tables   ##########
create table train ( 
numero integer primary key);

create table voiture ( 
numero int, 
places_dispo int, 
numero_train int, foreign key (numero_train) references train(numero),
primary key (numero, numero_train) );

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

create table trajet (
id int unique,
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

create table reservation (
id int unique,
id_client int, foreign key (id_client) references client_sncf(id),
id_trajet int, foreign key (id_trajet) references trajet(id),
numero_place int,
numero_voiture int, foreign key (numero_voiture) references voiture(numero),
prix_reduit float);

# table à supprimer
/*
create table billet( 
numero int primary key, 
id_client int, foreign key (id_client) references client_sncf(id),
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
prix float);*/
 
##########   Création Admin   ##########
grant all privileges on sncf.* to sncfadmin@'localhost' identified by 'mypassword';

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
insert into train () values (6);

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
insert into voiture () values (1, 100, 6);
insert into voiture () values (2, 100, 6);
# place
# insert into place () values (45, true, 5);

# client_sncf
insert into client_sncf () values ('Aymar', 'Jean', true, NULL, 1);
insert into client_sncf () values ('Zbar', 'Joe', false, 'Jeune', 2);
insert into client_sncf () values ('Alezieubleu', 'Isabelle', true, 'J-8', 3);
insert into client_sncf () values ('Dupont', 'Marc', true, 'J-30', 4);
insert into client_sncf () values ('Boille', 'Danny', false, 'Decouverte', 5);
insert into client_sncf () values ('De-La-Tour', 'Franck', true, '-50%', 6);

# trajet
insert into trajet () values ( 1, 1, 'Lyon', 'Part-Dieu', 'Valence', 'Valence-Ville', '2018-02-25', '15:30:00', '2018-02-25', '16:40:00', 15.0);
insert into trajet () values ( 2, 2, 'Lyon', 'Part-Dieu', 'Macon', 'Macon-Gare', '2018-02-12', '8:30:00', '2018-02-12', '9:45:00', 25.0);

insert into trajet () values ( 3, 3, 'Valence', 'Valence-Ville', 'Lyon', 'Part-Dieu', '2018-01-25', '12:34:00', '2018-01-25', '14:45:00', 15.0);
insert into trajet () values ( 4, 4, 'Valence', 'Valence-Ville', 'Macon', 'Macon-Gare', '2018-03-02', '8:00:00', '2018-03-02', '9:55:00', 39.5);

insert into trajet () values ( 5, 5, 'Macon', 'Macon-Gare', 'Lyon', 'Part-Dieu', '2018-01-25', '12:34:00', '2018-01-25', '13:45:00', 25.0);
insert into trajet () values ( 6, 6, 'Macon', 'Macon-Gare', 'Valence', 'Valence-Ville', '2018-01-28', '12:34:00', '2018-01-28', '14:45:00', 52.0);

# reservation
insert into reservation () values (1, 2, 1, 10, 2, 7.5);
insert into reservation () values (2, 3, 2, 21, 2, 18.75);
insert into reservation () values (3, 1, 3, 13, 1, 15.0);
insert into reservation () values (4, 4, 4, 48, 2, 25.68);
insert into reservation () values (5, 3, 5, 9, 2, 18.75);
insert into reservation () values (6, 5, 6, 16, 1, 31.2);

##########   Create Views   ##########

create view billet as
select reservation.id as numero,
reservation.id_client,
reservation.numero_place,
reservation.numero_voiture,
trajet.numero_train,
trajet.ville_depart,
trajet.gare_depart, 
trajet.ville_arrivee, 
trajet.gare_arrivee,
trajet.date_depart, 
trajet.heure_depart, 
trajet.date_arrivee, 
trajet.heure_arrivee,
trajet.prix as 'prix non réduit'
from reservation, trajet
where (reservation.id_trajet = trajet.id);


# n° train | n° voiture | places dispo (reservées ou non)
create view diponibilites_voit as
select train.numero as 'n° train', 
voiture.numero as 'n° voiture', 
voiture.places_dispo 
from train, voiture
where voiture.numero_train = train.numero;

# client prenom | client nom | type reduction | taux de reduction
create view clientreduc as
select client_sncf.prenom, 
client_sncf.nom, 
reduction.reduction_type, 
reduction.pourcentage 
from client_sncf, reduction
where reduction.reduction_type = client_sncf.reduction_type;

# billet n° | ville depart | ville arrivee | heure depart | date depart | n° train
create view listbillet as
select billet.numero as 'n° billet', 
billet.ville_depart, 
billet.ville_arrivee, 
billet.heure_depart, 
billet.date_depart, 
train.numero as 'n° train' 
from billet, train
where billet.numero_train = train.numero;

# n° train | nb voitures | nb total de places dispo (reservées ou non)
create view disponibilites_train as
select train.numero as 'n° train',
(select count(*) from voiture where voiture.numero_train = train.numero) as 'nombre voitures',
(select sum(voiture.places_dispo) from voiture where voiture.numero_train = train.numero) as 'places total dispo'
from train;

# train n° | voiture n° | n° place reservée | côté fenêtre
create view cotefen as
select train.numero as 'n° train',
voiture.numero as 'n° voiture',
billet.numero_place as 'n° place reservée',
billet.numero_place % 2 = 0 as 'côté fenêtre'
from billet, train, voiture 
where billet.numero_train = train.numero and billet.numero_voiture = voiture.numero and train.numero = voiture.numero_train;


# train n° | voiture n° | nb places reservées
create view voit_reserv as
select train.numero as 'n° train',
voiture.numero as 'n° voiture',
(select count(*) from billet where billet.numero_train = train.numero and billet.numero_voiture = voiture.numero) as 'nb places reservées'
from train, voiture
where train.numero = voiture.numero_train;

# n° train | nb voitures | nb total places restantes
create view placesrestantes as
select train.numero as 'n° train',
(select count(*) from voiture where voiture.numero_train = train.numero) as 'nombre voitures',
(select (select sum(voiture.places_dispo) 
				from voiture 
				where voiture.numero_train = train.numero)
		- count(*) from billet where billet.numero_train = train.numero) as 'nb places restantes'
from train;

# date depart | heure depart | ville depart
create view prochains_departs as
select trajet.date_depart, 
trajet.heure_depart, 
trajet.ville_depart,
trajet.ville_arrivee
from trajet
where ( curdate() < trajet.date_depart or (curdate() = trajet.date_depart and curtime() < trajet.heure_depart));

# n° train | gare départ | gare arrivée | date départ | heure départ
create view train_infos as
select distinct     train.numero, 
                    trajet.gare_depart, 
                    trajet.gare_arrivee, 
                    trajet.date_depart, 
                    trajet.heure_depart,
                    trajet.heure_arrivee
from train, trajet
where trajet.numero_train = train.numero;





##########   Triggers   ##########
