<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <?php 
        $n1 = $_GET["operand1"];
        $n2 = $_GET["operand2"];
        $op = $_GET["opp"];
        if($n1=="" or $n2==""){
        ?> 
        <p align="center">Il faut saisir les deux operandes <a href="index.html"> revenir au form</a></p>
        <?php 
        }elseif($op=="vide"){
        ?> 
        <p align="center">Il faut choisir un operateur<a href="index.html">  revenir au form</a></p>
        <?php 
        }
        elseif($op=="/" and $n2==0) {
        ?>
        <p align="center">Erreur division par 0 <a href="index.html">  revenir au form</a></p>

        <?php 
        }else {


        switch($op){
            case "+" :$a = $n1 +$n2;
            break;
            case "-" :$a = $n1 -$n2;
            break;
            case "*" :$a = $n1 *$n2;
            break;
            case "/" :$a = $n1/$n2;
            break;

        }
         ?>
    <p align="center">Le resultet de <?php echo $n1. $op .$n2;?> est : <?php echo $a?> </p> 

    <?php }
    ?>
</body>
</html> 