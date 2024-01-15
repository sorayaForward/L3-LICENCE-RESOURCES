
<?php
session_start();
?>
<table border="1">
<form method="POST" action="">
  <?php 
    $n = 0;
    for($i=1;$i<=7;$i++){ ?>
    <tr>  
    <?php for($j=1;$j<=7;$j++){ ?>
        <td>
        <?php $n=$n+1; echo $n ?>
        <input type="checkbox" name="num[]" value=<?php echo $n ?> />
        </td>
    <?php }?>
    </tr>  
  <?php }?>
  <input type="submit" value="Calculer"/>
  </form>
<table>
<?php 
if(isset($_POST["num"])){
  $num = $_POST["num"];
  if( count($num) == 6 ){
  echo "Vous avez choisit :";
  foreach ($num as $value) {
    # code..
    echo $value;
    echo ' ';
  }
  echo "<br>";
  echo "La machine a choisit :";
  $tab = array();
  $i=1;
  foreach ($num as $value) {
    $tab[$i] = rand(1,49);
    echo  $tab[$i];
    $i++;
    echo ' ';
    }
  echo "<br>";
  echo "Les nombres communs :";
  $nombre_trouve = array_intersect($num,$tab);

  foreach ($nombre_trouve as $value) {
    echo $value;
    echo " ";
  }
}else{echo "Il faut choisir 6 nombres";}
}else{echo "Il faut choisir des nombres";}
?>

