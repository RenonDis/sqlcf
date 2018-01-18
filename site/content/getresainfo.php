<?php
require '../config.php';
session_start();
$_SESSION['info'] = [];
$_SESSION['errors'] = [];

function findId() {

        $idclient = 0;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {

            $idclientbrut = $_POST['idclient'];

            $idclient = (int) $idclientbrut;
            echo $idclient;

            $errors = array();

            if ($idclient == 0) { $errors = "Identifiant non conforme : 
                un numéro non nul doit être saisi !"; }

            if (count($errors) == 0) {

		try {
    		$cnx = new PDO('mysql:host='.config('host').';
    		    dbname='.config('database').';charset=utf8',
    		    config('user'),
    		    config('passit'));

    		} catch(Exception $e) {

    		die('Erreur :'.$e->getMessage());

    		}

                $req = $cnx->prepare('SELECT	numero,
						numero_train,
						numero_place,
						numero_voiture,
						gare_depart,
						gare_arrivee,
						date_depart,
						heure_depart,
						heure_arrivee
			 FROM billet WHERE id_client=?');

                $req->execute(array($idclient));

                $arraybill = array();
                while ($element = $req->fetch()) {
                        $infobill = array(
                            $element['numero'],
                            $element['numero_train'],
                            $element['numero_voiture'],
                            $element['numero_place'],
                            $element['gare_depart'],
                            $element['gare_arrivee'],
                            $element['date_depart'],
                            $element['heure_depart'],
                            $element['heure_arrivee']);
                        array_push($arraybill, $infobill);
                            }

                if(!empty($infobill)) {
	            $_SESSION['info'] = $arraybill;
                } else {
                    $_SESSION['errors'] = "Identifiant non trouvé !";
                }

                $_SESSION['isclean'] = true;
                header('Location: /?page=resa');
                exit;
            }
        }

	if(!empty($errors)) {
	    $_SESSION['errors'] = $errors;
            $_SESSION['isclean'] = true;
	    header('Location: /?page=resa');
	    exit;
	}

}

findId()

?>
