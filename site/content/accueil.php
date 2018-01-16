
<h3>Aperçu des trains disponibles</h3>
<div class="flexo">
<table>
    <tr text-align=center><td colspan=3>Trains disponibles</td></tr>
    <tr>
        <td> Numéro du train </td>
        <td> Nombre de voitures </td>
        <td> Nombre de places restantes </td>
    </tr>
    <?php getDispoTrains();?>
</table>
</div>

<h3>Taux de réservation</h3>
<div class="flexo">
<table>
    <tr text-align=center><td colspan=3>Remplissage des trains</td></tr>
    <tr>
        <td> Numéro du train </td>
        <td> Numéro de voitures </td>
        <td> Nombre de places réservées </td>
    </tr>
    <?php getReservTrains();?>
</table>
</div>
