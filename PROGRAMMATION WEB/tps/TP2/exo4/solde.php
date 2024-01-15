<?php 

$initialSolde = $_POST["initial"];
$tauxInteret = $_POST["taux"];
$nbrAnnee = $_POST["annee"];

if(!$initialSolde) echo "Il faut saisir votre solde initiale";
echo "<br>";
if(!$tauxInteret) echo "Il faut selecionner un taux d'interet";
echo "<br>";
if(!$nbrAnnee) echo "Il faut selecionner le nbr d'annees";

if($initialSolde && $tauxInteret && $nbrAnnee ) echo "Resultat = ".$initialSolde*$tauxInteret/$nbrAnnee;
echo "<br>";
?>
<a href="index.php">revenir au form</a>

