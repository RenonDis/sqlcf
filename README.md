# sqlcf
The subtle merging of sncf and sql

sql design : https://sqldbm.com/Project/Share/EJePP5Q-HqOJzN0dG-JjPg/

php sql : https://zestedesavoir.com/tutoriels/351/paginer-avec-php-et-mysql/

Nous voulons faire la gestion d’une agence de voyage SNCF. Un billet de
voyage est identifié par cette agence, par son numéro et se caractérise également
par :

* La ville de destination
* La gare de départ
* La date de départ
* L’heure de départ
* La gare d’arrivée
* La date d’arrivée
* L’heure d’arrivée
* Le prix du billet

Le billet va être utilisé dans un train identifié par son numéro et comporte
plusieurs voitures. Une voiture est identifiée par son numéro et le nombre de
places disponibles. Chaque place est identifiée par un numéro et sa situation
fenêtre/couloir.

La réservation concerne le client identifié par son nom, il peut être adulte
ou enfant et il a droit ou non à une réduction. Un réduction est identifiée par
son type (J-8, J-30, Découverte, etc.) et se caractérise par un pourcentage. La
réservation s’achève par une confirmation ou une annulation. Il faut calculer le
prix total à payer déduit de la réduction.
