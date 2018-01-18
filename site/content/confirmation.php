<h3>Résumé de votre commande</h3>

<!--
<p> Merci d'avoir choisi GET A TRAIN ! pour voyager !</p>
-->

<?php if ($_SESSION['errorsres']): ?>
<div class="flexo error">
<p><?php echo $_SESSION['errorsres'] ?></p>
</div>

<?php elseif ($_SESSION['infores']): ?>
<p>Un trajet correspond à vos critères ! Veuillez confirmer :
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

<div class="flexo">
<a class="button" href="content/doresa.php">Confirmer votre billet !</a>
<a class="button" href="/?page=billets">Annuler</a>
</div>

<?php else: ?>
<div class="flexo error">
<p>Votre session a expiré !</p>
</div>
<?php endif; ?>
