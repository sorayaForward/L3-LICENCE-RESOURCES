<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display age</title>
</head>
<body>
    Votre age est :
    <?php 
        echo $_GET["age"];

    ?>
    </br>
    Votre age apres 10 ans sera :
    <?php    
              $a = $_GET["age"]+10;
              echo $a;
    ?>
    <?php    
    for ($i=0;$i<3;$i++){
    ?>
        </br>
        Hello Soraya
    <?php
         }
    ?>
    </br>
    <h1>Multiplication</h1>
    <?php
    $n = $_GET["number"];
    for ($i=0;$i<=10;$i++){  
        echo $n."*".$i."=".$n*$i;
    ?>
    </br>
    <?php
    }
    ?>  

</body>
</html>      
