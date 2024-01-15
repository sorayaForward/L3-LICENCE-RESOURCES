<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>exo4</title>
</head>
<body>
    <table width="400" border="1" borderColor="black" 
    cellspacing="10px"  cellpadding="5px" align="center">
        <caption>Présentation d'un tableau récapitulatif</caption>
        <?php 
            $hauteur = "50px";      
            $val = 1;
            for ($i=1;$i<=4;$i++){     
        ?>
            
            <tr>
            
                <?php 
                for ($j=1;$j<=4;$j++){   
                    if($j==1){$a = "20%"; $al = "left";}
                    elseif($j==2){$a = "25%"; $al = "center";}
                    elseif($j==3){$a = "40%"; $al = "center";}
                    elseif($j==4){ $a = "15%"; $al = "right";}
                ?> 
                    <td height=<?php echo $hauteur?> width=<?php echo $a?> align=<?php echo $al ?> bgcolor=<?php 
                    
                                if($val%3==0)
                                    {echo "white";}
                                elseif($val%2==0)
                                    {echo "orange";}
                                else  {echo "yellow";}

                    ?>
                    <font color="blue" size="3"><?php echo $val ?></font></td>
                <?php 
                    $val++;}
                ?>

            </tr>

            <?php 
                }
            ?>
    
       
    </table>     
</body>
</html>