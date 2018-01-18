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
 
##########   Création Admin   ##########
grant all privileges on sncf.* to sncfadmin@'localhost' identified by 'mypassword';

##########   Remplissage BD   ##########

# reduction
insert into reduction () values ('', 0);
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
insert into reservation () values (8, 2, 1, 1, 1, 7.5);
##########   Create Views   ##########

# client prenom | client nom | type reduction | taux de reduction
create view client_reduction as
select client_sncf.prenom, 
client_sncf.nom, 
reduction.reduction_type, 
reduction.pourcentage 
from client_sncf, reduction
where reduction.reduction_type = client_sncf.reduction_type;

# numero | id_client | n° place | n° voiture | n° train | ville départ | gare départ | ... | prix brut
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
trajet.prix as 'prix_brut'
from reservation, trajet
where (reservation.id_trajet = trajet.id);

# billet n° | ville depart | ville arrivee | heure depart | date depart | n° train
create view liste_billets as
select billet.numero as 'n° billet', 
billet.ville_depart, 
billet.ville_arrivee, 
billet.heure_depart, 
billet.date_depart, 
train.numero as 'n° train' 
from billet, train
where billet.numero_train = train.numero;

# n° train | n° voiture | places dispo (reservées ou non)
create view disponibilites_voiture as
select train.numero as 'n° train', 
voiture.numero as 'n° voiture', 
voiture.places_dispo 
from train, voiture
where voiture.numero_train = train.numero;

# n° train | nb voitures | nb total de places dispo (reservées ou non)
create view disponibilites_train as
select train.numero as 'n° train',
(select count(*) from voiture where voiture.numero_train = train.numero) as 'nombre voitures',
(select sum(voiture.places_dispo) from voiture where voiture.numero_train = train.numero) as 'places total dispo'
from train;

# train n° | voiture n° | n° place reservée | côté fenêtre
create view liste_places_reservees as
select train.numero as numero_train,
voiture.numero as numero_voiture,
billet.numero_place as numero_place,
billet.numero_place % 2 = 0 as cote_fenetre
from billet, train, voiture 
where billet.numero_train = train.numero and billet.numero_voiture = voiture.numero and train.numero = voiture.numero_train;

# train n° | voiture n° | nb places reservées
create view places_reservees_voiture as
select train.numero as 'n° train',
voiture.numero as 'n° voiture',
(select count(*) from billet where billet.numero_train = train.numero and billet.numero_voiture = voiture.numero) as 'nb places reservées'
from train, voiture
where train.numero = voiture.numero_train;

# n° train | nb voitures | nb total places restantes
create view places_restantes_par_train as
select train.numero as 'n° train',
(select count(*) from voiture where voiture.numero_train = train.numero) as 'nombre voitures',
(select (select sum(voiture.places_dispo) 
				from voiture 
				where voiture.numero_train = train.numero)
		- count(*) from billet where billet.numero_train = train.numero) as 'nb places restantes'
from train;

# n° train | n° voitures | nb places restantes
create view places_restantes_par_voiture as
select train.numero as 'n° train',
voiture.numero as 'n° voiture',
(select voiture.places_dispo - count(*) 
	from billet 
    where billet.numero_voiture = voiture.numero and billet.numero_train = train.numero) as 'nb places restantes'
from train, voiture
where train.numero = voiture.numero_train;

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

# gare | ville
create view gare_ville as
(select gare_depart as gare, ville_depart as ville from trajet) union 
(select gare_arrivee as gare, ville_arrivee as ville from trajet);


##########   Procédures   ##########
delimiter |
create procedure effectuer_reservation(IN id_trajet INT, IN id_client INT, IN reduc_type VARCHAR(15), 
									   IN no_voiture INT, IN no_place INT, OUT id_reservation INT)
begin
	declare no_train int;
    declare prix float;
    
    select trajet.numero_train into no_train from trajet where trajet.id = id_trajet;
    
    # on vérifie que la place est toujours libre
	if( not exists (select * 
					from liste_places_reservees
                    where (liste_places_reservees.numero_train = no_train and
						   liste_places_reservees.numero_voiture = no_voiture and
                           liste_places_reservees.numero_place = no_place))) then 
		
        select count(*) + 1 from reservation into id_reservation;
        select trajet.prix into prix from trajet where trajet.id = id_trajet;
        call appliquer_reduction(reduc_type, prix);
        insert into reservation () values (id_reservation, id_client, id_trajet, no_place, no_voiture, prix);
	else 
		set id_reservation = NULL;
	end if;
end|
delimiter ;

# trouve un trajet selon infos données par client
delimiter |
create procedure trouver_trajet(IN gare_depart VARCHAR(15), IN gare_arrivee VARCHAR(15), IN no_voiture INT, 
								IN prenom_client VARCHAR(15), IN nom_client VARCHAR(15), IN majeur bool, IN reduc_type VARCHAR(15),
                                OUT id_client INT, OUT id_trajet INT, OUT no_place INT, OUT prix float)
begin
	declare pourcentage_reduction float default 0.0;
    declare client_exists bool default false;
    
    ### Gestion client ###
    # check si client existe déjà, sinon on le crée
    select if (exists (select * 
					   from client_sncf
                       where (nom_client = client_sncf.nom and prenom_client = client_sncf.prenom)),
				true,
                false)
    into client_exists;
    
    if client_exists then
		select client_sncf.id
        from client_sncf
        where (client_sncf.nom = nom_client and client_sncf.prenom = prenom_client) 
        into id_client;
    else
		call creer_nouveau_client(prenom_client, nom_client, majeur,reduc_type, id_client);
    end if;
    
    
    ### Gestion trajet ###
	# recupere 1er trajet
	call trouver_premier_trajet(gare_depart, gare_arrivee, id_trajet);
    
    # attribue une place libre
    call trouver_place_libre(id_trajet, no_voiture, no_place);
    
    ### Gestion prix ###
    select trajet.prix into prix from trajet where trajet.id = id_trajet;
    call appliquer_reduction(reduc_type, prix);
end|
delimiter ;

# calculer prix réduit
delimiter |
create procedure appliquer_reduction(IN reduc_type VARCHAR(15), INOUT prix float)
begin
	declare pourcentage_reduction float default 0.0;
    
    select if( exists (select * 
					   from reduction
                       where reduction.reduction_type = reduc_type),
			  (select reduction.pourcentage 
              from reduction
              where reduction.reduction_type = reduc_type limit 1),
              0.0)
	into pourcentage_reduction;
    
    # calcule le nouveau prix
    set prix = prix * (1 - pourcentage_reduction);
end|
delimiter ;


# trouver une place libre sur un certain trajet et voiture
delimiter |
create procedure trouver_place_libre(IN id_trajet INT, IN no_voiture INT, OUT no_place INT)
begin
	declare no_train int default -1;
	declare nb_places_restantes int;
    declare nb_places_total int;
    declare place_trouvee bool default false;

    set no_place = 0;
    
    # find no train
    select numero_train into no_train
	from trajet
	where id_trajet = trajet.id;
    
    # check if (train, voiture) specified by ('no_train', 'no_voiture') is not full
    select 'nb places restantes' into nb_places_restantes
    from places_restantes_par_voiture
    where ('n° train' = no_train and 
		   'n° voiture' = no_voiture);
	
    # récupère le nb places total dans la voiture, train en question 
    select 'places total dispo' into nb_places_total
    from disponibilites_train
    where ('n° train' = no_train and
		   'n° voiture' = no_voiture);
    
    # parcourt toutes les places dans (train, voiture) pour trouver une place libre
	if nb_places_restantes = 0 then 
		set no_place = NULL;
	else
		repeat
			set no_place = no_place + 1;
            select if( not exists (select * 
				from liste_places_reservees 
                where (liste_places_reservees.numero_train = no_train and 
					   liste_places_reservees.numero_voiture = no_voiture and 
                       liste_places_reservees.numero_place = no_place)), true, false) 
			into place_trouvee;
		until place_trouvee end repeat;
    end if;
end|
delimiter ;

# trouver un trajet
delimiter |
create procedure trouver_premier_trajet(IN gare_depart VARCHAR(15), IN gare_arrivee VARCHAR(15), OUT id_traj INT)
begin
	select trajet.id into id_traj 
    from trajet
    where (trajet.gare_depart = gare_depart and trajet.gare_arrivee = gare_arrivee)
    limit 1;
end|
delimiter ;

select count(*) from client_sncf;

# créer nouveau client
delimiter |
create procedure creer_nouveau_client(IN prenom varchar(15), IN nom varchar(15), IN majeur bool, IN reduc_type VARCHAR(15), OUT id INT)
begin
	# id
	select count(*) + 1 into id from client_sncf;
    
	# client_sncf
	insert into client_sncf () values (nom, prenom, majeur, reduc_type, id);
end|
delimiter ;


##########   Triggers   ##########

# if delete client --> delete corresponding reservation
delimiter |
create trigger delete_reservation_from_deleted_client before delete
on client_sncf for each row
begin
	delete from reservation where reservation.id_client = old.id;

end |
delimiter ;







