# Guide d'installation

* Télécharger le dossier *sqlcf*
* Lancer le script *makeSncf.sql* sur votre serveur MySQL
* Vérifier que le driver *pdo_mysql* de votre installation PHP est bien activé
* Lancer le serveur en se plaçant dans le dossier *site/*
* Aller à l'adresse indiquée sur votre butineur préféré


# Guide d'utilisation

L'application est à destination des voyageurs cherchant à réserver un voyage entre deux gares distinctes.
Le site est composé de plusieurs onglets, avec différents rôles :

* Accueil 
* Billets 
* Informations
* Mes Réservations 

## Accueil

* Présentation des trains disponibles 
* Présentation des taux de réservation actuels

## Billets

<ul>
<li> Réservation des billets
<ul>
<li>Indiquer Nom, Prénom, Trajet, Voiture (~ classe), Réduction et Majeur/Mineur</li>
<li>Une page de confirmation donne les informations de votre trajet. Confirmez !</li>
<li>Une page récapitulative s'affiche, avec votre ID client, à conserver pour <em>Mes Réservations</em> !</li>
</ul>
</li>
</ul>

* Aperçu des billets déjà réservés (anonymisés : sans l'ID client associé)

## Informations

* Informations générales sur les réductions

## Mes Réservations

* En rentrant un ID client (fourni lors de la réservation), on peut y retrouver les billets réservés

## Contact

* Contactez-nous !


