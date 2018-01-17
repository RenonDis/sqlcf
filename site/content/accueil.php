<!--
<h3>Prochains départs</h3>
<div class="flexo">
<table>
    <tr text-align=center><td colspan=6>Trains disponibles</td></tr>
    <tr>
        <td> Numéro du train </td>
        <td> Gare de départ </td>
        <td> Gare d'arrivée </td>
        <td> Date de départ </td>
        <td> Heure de départ </td>
        <td> Heure d'arrivée </td>
    </tr>
    <?php #getProchainsDeparts();?>
</table>
</div>
-->

<h3>Aperçu des trains disponibles</h3>
<div class="flexo">
<table>
    <tr text-align=center><td colspan=6>Trains disponibles</td></tr>
    <tr>
        <td> Numéro du train </td>
        <td> Gare de départ </td>
        <td> Gare d'arrivée </td>
        <td> Date de départ </td>
        <td> Heure de départ </td>
        <td> Heure d'arrivée </td>
    </tr>
    <?php getTrajets();?>
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
