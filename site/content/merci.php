<h3>Billet réservé</h3>

<?php if ($_SESSION['infores']): ?>

<p> Merci d'avoir choisi GET A TRAIN ! pour voyager !</p>

<div class="flexo" style="border:1px solid green;">
<p>Votre identifiant client est le <?php echo $_SESSION['infores'][0] ?> !
 Veuillez le conserver pour consulter vos billets dans 
 <a href="/?page=resa">Mes réservations</a>.</p>
</div>

<p>Rappel de votre trajet :
<div class="flexo">
<table>
    <tr>
        <td>N° Place</td>
        <td>N° Train</td>
        <td>Gare de départ</td>
        <td>Ville de départ</td>
        <td>Gare d'arrivée</td>
        <td>Ville d'arrivée</td>
        <td>Date</td>
        <td>Heure de départ</td>
        <td>Heure d'arrivée</td>
        <td>Prix</td>
    </tr>
    <tr>
        <td><?php echo $_SESSION['infores'][2] ?></td>
        <?php foreach($_SESSION['infoconf'] as $key=>$value): ?>
            <td><?php echo $value ?></td>
        <?php endforeach; ?>
        <td><?php echo $_SESSION['infores'][3] ?> &euro;</td>
    </tr>
</table>
</div>

<?php else: ?>
<div class="flexo error">
<p>Votre session a expiré !</p>
</div>
<?php endif; ?>
