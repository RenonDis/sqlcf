<?php

function getDispoTrains() {
    
    $cnx = new PDO('mysql:host=localhost;dbname=sncf;charset=utf8', 'sncfadmin', 'admin');

    // Partie "Requête"
    $query = 'SELECT * FROM `diponibilitestrain`';
    $resultSet = $cnx->query($query);
    
    // Partie "Boucle"
    while ($element = $resultSet->fetch()) {
            echo "<tr><td>" . $element['n° train'] . "</td><td>" . $element['nombre voitures'] . "</td><td>" . $element['places total dispo'] . "</td></tr>";
                }
    }


function getReservTrains() {

    $cnx = new PDO('mysql:host=localhost;dbname=sncf;charset=utf8', 'sncfadmin', 'admin');

    // Partie "Requête"
    $query = 'SELECT * FROM `voitreserv`';
    $resultSet = $cnx->query($query);
    
    // Partie "Boucle"
    while ($element = $resultSet->fetch()) {
            echo "<tr><td>" . $element['n° train'] . "</td><td>" . $element['n° voiture'] . "</td><td>" . $element['nb places reservées'] . "</td></tr>";
                }
    }


function getBilletListe() {

    $cnx = new PDO('mysql:host=localhost;dbname=sncf;charset=utf8', 'sncfadmin', 'admin');

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


?>
            
