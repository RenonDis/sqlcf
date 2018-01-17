
<h3>Aperçu des billets réservés</h3>
<div class="flexo">
<table>
    <tr text-align=center><td colspan=6>Billets réservés</td></tr>
    <tr>
        <td> Numéro du billet </td>
        <td> Numéro du train </td>
        <td> Ville de départ </td>
        <td> Ville d'arrivée</td>
        <td> Heure de départ </td>
        <td> Date de départ </td>
    </tr>
    <?php getBilletListe();?>
</table>
</div>

<h3>Réserver un billet</h3>

<div class="flexo">
    <form action="resabillet" method="post">
        <table class="tableform">
            <tr>
                <td>Départ</td>
                <td>
                    <select id="depart">
                        <option>Biarritz</option>
                        <option>Lyon</option>
                        <option>Macon</option>
                        <option>Marseille</option>
                        <option>Metz</option>
                        <option>Nancy</option>
                        <option>Paris</option>
                        <option>Toulouse</option>
                        <option>Valence</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Arrivée</td>
                <td>
                    <select id="arrivee">
                        <option>Biarritz</option>
                        <option>Lyon</option>
                        <option>Macon</option>
                        <option>Marseille</option>
                        <option>Metz</option>
                        <option>Nancy</option>
                        <option>Paris</option>
                        <option>Toulouse</option>
                        <option>Valence</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Voiture</td>
                <td>
                    <select id="voiture">
                    <?php for ($i = 1; $i <= 2; $i++) : ?>
                        <option value="<?php echo $i; ?>">
                            <?php echo $i; ?>
                        </option>
                    <?php endfor; ?> 
                    </select>
                </td>
            </tr>
            <tr>
                <td>Place</td>
                <td>
                    <select id="place">
                    <?php for ($i = 1; $i <= 200; $i++) : ?>
                        <option value="<?php echo $i; ?>">
                            <?php echo $i; ?>
                        </option>
                    <?php endfor; ?> 
                    </select>
                </td>
            </tr>
            <tr>
                <td>Réduction</td>
                <td>
                    <select id="reduction">
                        <option>Decouverte</option>
                        <option>Jeune</option>
                        <option>J-30</option>
                        <option>J-8</option>
                        <option>-50%</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td colspan=2>
	            <button 
                        value="submit" 
                        type="submit" 
                        class="button">Demander un billet</button>
                </td>
            </tr>
        </table>


    </form>
</div>
