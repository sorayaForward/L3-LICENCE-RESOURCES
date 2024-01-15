<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Veuillez remplir les champs de ce formulaire :</h1>
    <form action="solde.php" method="POST">
        <label>Solde initial :<input type="text" name="initial"/></label>
        </br>    
        <label>Taux D'interet :
            <select name="taux">
                    <option ></option>
                    <?php
                    for($i=7;$i<=25;$i++) { ?>
                        <option value=<?php echo $i ?>><?php echo $i ?></option>
                    <?php
                    }
                    ?>
            </select>%
        </label>  
        </br>      
        <label>Nbr d'annees :
            <select name="annee">
                    <option ></option>
                <?php
                for($i=2;$i<=10;$i++) { ?>
                    <option value=<?php echo $i ?>><?php echo $i ?></option>
                <?php
                }
                ?>
            </select>
        </br>    
        </label>
        <input type="submit" value="Calculer"/>


    </form>
</body>
</html>