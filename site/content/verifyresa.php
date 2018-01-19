<?php
require '../config.php';
session_start();
$_SESSION['info'] = [];
$_SESSION['errors'] = [];

function findId() {

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {

            $nom = $_POST['nom'];
            $prenom = $_POST['prenom'];
            $depart = $_POST['depart'];
            $arrivee = $_POST['arrivee'];
            $voiture = (int) $_POST['voiture'];
            $reduction = $_POST['reduction'];
            $majorite = (bool) $_POST['majorite'];


            $errors = array();

            if ($depart == $arrivee) { 
                $errors = "La gare de départ et d'arrivée ne 
                peuvent être identiques !"; 
            }

            if(!preg_match("/^[a-zA-Z'-]+$/",$nom)) {
                $errors = "Nom invalide !";
            }

            if(!preg_match("/^[a-zA-Z'-]+$/",$prenom)) {
                $errors = "Prénom invalide !";
            }

            if (count($errors) == 0) {

		try {
    		$cnx = new PDO('mysql:host='.config('host').';
    		    dbname='.config('database').';charset=utf8',
    		    config('user'),
    		    config('passit'));
    		} catch(Exception $e) {

    		die('Erreur :'.$e->getMessage());

    		}

                #envoyer le billet, recup de id_client, num billet, horaires..
                $req = $cnx->prepare('call trouver_trajet(
                    :depart,
                    :arrivee,
                    :voiture,
                    :prenom,
                    :nom,
                    :majorite,
                    :reduction,
                    @id_client,
                    @id_trajet,
                    @no_place,
                    @prix)');

                $req->bindValue(':nom', $nom, PDO::PARAM_STR);
                $req->bindValue(':prenom', $prenom, PDO::PARAM_STR);
                $req->bindValue(':depart', $depart, PDO::PARAM_STR);
                $req->bindValue(':arrivee', $arrivee, PDO::PARAM_STR);
                $req->bindValue(':reduction', $reduction, PDO::PARAM_STR);
                $req->bindValue(':voiture', $voiture, PDO::PARAM_INT);
                $req->bindValue(':majorite', $majorite, PDO::PARAM_BOOL);

                $req->execute();

                $req->closeCursor();

                $row = $cnx->query("SELECT 
                    @id_client AS idclient,
                    @id_trajet AS idtrajet,
                    @no_place AS place,
                    @prix AS prix")->fetch(PDO::FETCH_ASSOC);

                $arrayresa = array();

        	if ($row) {
                    $idclient = $row['idclient'];
                    $idtrajet = $row['idtrajet'];
                    $place = $row['place'];

                    $arrayresa = array(
		        $idclient,
		        $idtrajet,
		        $place,
		        $row['prix'],
                        $reduction,
                        $voiture);
        	}

                $reqId = $cnx->prepare('SELECT
                    numero_train,
                    gare_depart,
                    ville_depart,
                    gare_arrivee,
                    ville_arrivee,
                    date_depart,
                    heure_depart,
                    heure_arrivee
                    from trajet WHERE id=?');

                #$reqId->bindValue(':idtraj', (int) $idtrajet, PDO::PARAM_INT);
                $reqId->execute(array($idtrajet));

                while ($element = $reqId->fetch()) {

                        $infoConf = array(
                            $element['numero_train'],
                            $element['gare_depart'],
                            $element['ville_depart'],
                            $element['gare_arrivee'],
                            $element['ville_arrivee'],
                            $element['date_depart'],
                            $element['heure_depart'],
                            $element['heure_arrivee']);
		}

                $reqId->closeCursor();


                if(!empty($arrayresa)) {
	            $_SESSION['infores'] = $arrayresa;
                    $_SESSION['infoconf'] = $infoConf;
                } else {
                    $_SESSION['errorsres'] = "Trajet non disponible !";
                }

                $_SESSION['isclean'] = true;
                header('Location: /?page=confirmation');
                exit;
            }
        }

	if(!empty($errors)) {
	    $_SESSION['errorsbil'] = $errors;
            $_SESSION['isclean'] = true;
	    header('Location: /?page=billets');
	    exit;
	}

}

findId()

?>
