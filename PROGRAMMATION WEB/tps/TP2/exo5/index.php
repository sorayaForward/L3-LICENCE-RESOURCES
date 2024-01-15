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
session_start();
if(!isset($_SESSION['MystereyNumber']))
{
$_SESSION['MystereyNumber'] = rand(1,1000);
}
echo $_SESSION['MystereyNumber'];

?>

<form methode="POST">
    <input type="text" name="n" value="" placeholder="Choose a unmber btw 1-100"/>
</form>

<?php
if (isset($_POST["n"])) {
    $GivingNumber = $_POST["n"];
    echo "<br>";
if ( $_SESSION['MystereyNumber'] > $GivingNumber)
    echo "give more!";
else if ( $_SESSION['MystereyNumber'] < $GivingNumber)
    echo "give less !";
else
    echo "Bravo c correct !";
}
?> 






</body>
</html>
