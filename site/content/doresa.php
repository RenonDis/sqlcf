<?php
require '../config.php';

session_start();

function confirmTrajet() {

    if (!empty($_SESSION['infores'])) {
    
        $idclient = (int) $_SESSION['infores'][0];
        $idtrajet = (int) $_SESSION['infores'][1];
        $place = (int) $_SESSION['infores'][2];
        $reduction = $_SESSION['infores'][4];
        $voiture = (int) $_SESSION['infores'][5];
        
        error_log((string) $idclient);
        error_log((string) $idtrajet);
        error_log((string) $place);
        error_log((string) $reduction);
        error_log((string) $voiture);
    
        try {
        $cnx = new PDO('mysql:host='.config('host').';
            dbname='.config('database').';charset=utf8',
            config('user'),
            config('passit'));
        } catch(Exception $e) {
    
        die('Erreur :'.$e->getMessage());
    
        }
    
        $reqTrajet = $cnx->prepare('call effectuer_reservation(
            :idtrajet,
            :idclient,
            :reduction,
            :voiture,
            :place,
            @idresa)');
    
        $reqTrajet->bindValue(':idtrajet', $idtrajet, PDO::PARAM_STR);
        $reqTrajet->bindValue(':idclient', $idclient, PDO::PARAM_STR);
        $reqTrajet->bindValue(':reduction', $reduction, PDO::PARAM_STR);
        $reqTrajet->bindValue(':voiture', $voiture, PDO::PARAM_INT);
        $reqTrajet->bindValue(':place', $place, PDO::PARAM_BOOL);
    
        $reqTrajet->execute();
        $reqTrajet->closeCursor();

        #$row = $cnx->query("SELECT @idresa AS idresa")->fetch(PDO::FETCH_ASSOC);

	#error_log((string) $row['idresa']);

        $_SESSION['isclean'] = true;
        header('Location: /?page=merci');
        exit;
    } 

}

confirmTrajet();

?>
