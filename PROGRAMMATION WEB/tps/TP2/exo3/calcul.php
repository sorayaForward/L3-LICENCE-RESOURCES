<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculer</title>
</head>
<body>
<?php $n = $_POST["n"];
      $p = $_POST["p"];
      if($n!="" && $p!=""){
?>
<table border="1">
    <tr>  
        <th>X</th>
        <?php for($i=$n;$i<=$p;$i++){ ?>
        <th><?php echo $i ?></th>
        <?php }?>
    </tr>

    <?php for($i=$n;$i<=$p;$i++){ ?>
        <tr>  
        <td>  
            <?php echo $i ?>
        </td>
        <?php for($j=$n;$j<=$p;$j++){ ?>
            <td>
                <?php echo $i*$j ?>
            </td>
        <?php }?>
        </tr>  
    <?php }?>
<table>

<?php      
        if($n>=$p) echo "La valeur de n doit être inférieure à celle de p"; 
        echo "<br>";
        if($n<0 || $p<0) echo "Il faut saisir des entieres positives"; 
        echo "<br>";
        if(!is_numeric($n) || !is_numeric($p)) echo "Il faut saisir des valeurs entières positives.";
        echo "<br>";
?>

<?php 
      } else echo "Il faut saisir tous les champs "
?>
<a href="index.html">revenir au form</a>
        


</body>
</html>