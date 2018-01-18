<h3>Rechercher vos réservations</h3>

<p> Veuillez saisir votre ID client : </p>

<div class="flexo">
    <form action="content/getresainfo.php" method="post">
        <input type="search" id="idclient" name="idclient"/>

        <button value="submit" type="submit" class="button">Trouver</button>

    </form>
</div>

<?php if($_SESSION['info']!='ini'): ?>

        <?php
            if(!empty($_SESSION['errors'])){

                echo "<div class='flexo error'><p>";
                echo $_SESSION['errors'];
                echo "</p></div>";
	    } 

            if(!empty($_SESSION['info'])){
                $arraybill = $_SESSION['info'];
	    } 
        ?>

<h3>Liste de mes réservations</h3>

<p> Nombre de billets trouvés : <?php echo sizeof($arraybill); ?> </p>
<?php foreach($arraybill as $key=>$infobill): ?>

<div class="flexo">
    <table>
        <tr>
            <td> N° billet</td>
            <td> N° train</td>
            <td> N° voiture</td>
            <td> N° place</td>
            <td>Départ</td>
            <td>Arrivée</td>
            <td>Date</td>
            <td>Heure de départ</td>
            <td>Heure d'arrivée</td>
        </tr>
        <tr>
        <?php foreach($infobill as $key=>$value): ?>
            <td> <?php echo $value; ?> </td>
        <?php endforeach; ?>
        </tr>
    </table>
</div>

<?php endforeach; ?>
<?php endif; ?> 
