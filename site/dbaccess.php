<?php

function getDispoTrains() {
    
    try {
    $cnx = new PDO('mysql:host='.config('host').';
        dbname='.config('database').';charset=utf8',
        config('user'), 
        config('passit'));

    } catch(Exception $e) {

    die('Erreur :'.$e->getMessage());

    }

    // Partie "Requête"
    $query = 'SELECT * FROM `placesrestantes`';
    $resultSet = $cnx->query($query);
    
    // Partie "Boucle"
    while ($element = $resultSet->fetch()) {
            echo "<tr><td>" . $element['n° train'] . "</td>
                <td>" . $element['nombre voitures'] . "</td>
                <td>" . $element['nb places restantes'] . "</td></tr>";
                }
    }


function getReservTrains() {

    try {
    $cnx = new PDO('mysql:host='.config('host').';
        dbname='.config('database').';charset=utf8',
        config('user'), 
        config('passit'));

    } catch(Exception $e) {

    die('Erreur :'.$e->getMessage());

    }

    // Partie "Requête"
    $query = 'SELECT * FROM `voit_reserv`';
    $resultSet = $cnx->query($query);
    
    // Partie "Boucle"
    while ($element = $resultSet->fetch()) {
            echo "<tr><td>" . $element['n° train'] . "</td><td>" . $element['n° voiture'] . "</td><td>" . $element['nb places reservées'] . "</td></tr>";
                }
    }


function getBilletListe() {

    try {
    $cnx = new PDO('mysql:host='.config('host').';
        dbname='.config('database').';charset=utf8',
        config('user'), 
        config('passit'));

    } catch(Exception $e) {

    die('Erreur :'.$e->getMessage());

    }

    // Partie "Requête"
    $query = 'SELECT * FROM `listbillet`';
    $resultSet = $cnx->query($query);
    
    // Partie "Boucle"
    while ($element = $resultSet->fetch()) {
            echo "<tr><td>" . $element['n° billet'] . "</td>
                <td>" . $element['n° train'] . "</td>
                <td>" . $element['ville_depart'] . "</td>
                <td>" . $element['ville_arrivee'] . "</td>
                <td>" . $element['heure_depart'] . "</td>
                <td>" . $element['date_depart'] . "</td></tr>";
                }
    }

function getTrajets() {

    try {
    $cnx = new PDO('mysql:host='.config('host').';
        dbname='.config('database').';charset=utf8',
        config('user'), 
        config('passit'));

    } catch(Exception $e) {

    die('Erreur :'.$e->getMessage());

    }

    // Partie "Requête"
    $query = 'SELECT * FROM `train_infos`';
    $resultSet = $cnx->query($query);
    
    // Partie "Boucle"
    while ($element = $resultSet->fetch()) {
            echo "<tr><td>" . $element['numero'] . "</td>
                <td>" . $element['gare_depart'] . "</td>
                <td>" . $element['gare_arrivee'] . "</td>
                <td>" . $element['date_depart'] . "</td>
                <td>" . $element['heure_depart'] . "</td>
                <td>" . $element['heure_arrivee'] . "</td></tr>";
                }
    }

function getProchainsDeparts() {

    try {
    $cnx = new PDO('mysql:host='.config('host').';
        dbname='.config('database').';charset=utf8',
        config('user'), 
        config('passit'));

    } catch(Exception $e) {

    die('Erreur :'.$e->getMessage());

    }

    // Partie "Requête"
    $query = 'SELECT * FROM `train_infos`';
    $resultSet = $cnx->query($query);
    
    // Partie "Boucle"
    while ($element = $resultSet->fetch()) {
            echo "<tr><td>" . $element['numero'] . "</td>
                <td>" . $element['gare_depart'] . "</td>
                <td>" . $element['gare_arrivee'] . "</td>
                <td>" . $element['date_depart'] . "</td>
                <td>" . $element['heure_depart'] . "</td>
                <td>" . $element['heure_arrivee'] . "</td></tr>";
                }
    }

function getResa() {

    try {
    $cnx = new PDO('mysql:host='.config('host').';
        dbname='.config('database').';charset=utf8',
        config('user'), 
        config('passit'));

    } catch(Exception $e) {

    die('Erreur :'.$e->getMessage());

    }

    // Partie "Requête"
    $query = 'SELECT * FROM `reduction`';
    $resultSet = $cnx->query($query);
    
    // Partie "Boucle"
    while ($element = $resultSet->fetch()) {
            echo "<tr><td>" . $element['reduction_type'] . "</td>
                <td>" . $element['pourcentage'] . "</td></tr>";
                }
    }

	

?>
            
