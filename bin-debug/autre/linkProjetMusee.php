<?php
$connection = mysql_connect('localhost', 'root', '') or die ('cannot reach database');
//Connexion à la base "test"
$db = mysql_select_db("projetmusee") or die ("this is not a valid database");


$requete = null ;
if($_GET['table'] == 'salle'){

	$requete = "SELECT * FROM salle ";
}else if($_GET['table'] == 'oeuvre'){

	if(isset($_GET['idOeuvre'])){
	
		$requete = "SELECT oeuvre.id, oeuvre.nom, oeuvre.path FROM oeuvre WHERE oeuvre.id='".$_GET['idOeuvre']."'";
	}else if(isset($_GET['nom'])){
	
		$requete = "SELECT oeuvre.id, oeuvre.nom, oeuvre.path FROM oeuvre WHERE oeuvre.nom='".$_GET['nom']."'";
	}
	
}else if($_GET['table'] == 'video'){

	$requete = "SELECT id, nom, path, idOeuvre, description FROM video WHERE video.idOeuvre='".$_GET['idOeuvre']."'";
}else if($_GET['table'] == 'description'){

	$requete = "SELECT * FROM description WHERE idOeuvre='".$_GET['idOeuvre']."'";

}else if($_GET['table'] == 'audio'){

	$requete = "SELECT * FROM audio WHERE idOeuvre='".$_GET['idOeuvre']."'";
}



//$table = $_GET['id'];
//Lecture de la base test_mxml
$result = mysql_query($requete);
//$result = mysql_query("SELECT * FROM salle");
//Calcul du nombre de lignes
$num_row = mysql_num_rows($result);

//Préparation de la sortie XML
echo '<?xml version="1.0" encoding="iso-8859-1"?>';
echo "<data>";
echo '<num>' .$num_row. '</num>';
if (!$result) {
die('Query failed: ' . mysql_error());
}
// lecture des meta-données et des noms des colonnes
$i = 0;
while ($i < mysql_num_fields($result)) {
$meta = mysql_fetch_field($result, $i);
$ColumnNames[] = $meta->name; //place col name dans array
$i++;
}
$specialchar = array("&",">","<"); //Caractères spéciaux
$specialcharReplace = array("&amp;","&gt;","&lt;"); //remplacement

/* Conversion des données de la table et des noms de colonnes en XML*/
$w = 0;
while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
echo "<row>";
foreach ($line as $col_value){
echo '<'.$ColumnNames[$w].'>';
$col_value_strip = str_replace($specialchar, $specialcharReplace, $col_value);
echo $col_value_strip;
echo '</'.$ColumnNames[$w].'>';
if($w == ($i - 1)) {$w = 0;}
else { $w++; }
}
echo "</row>";
}
/*
if($num_row == "1"){
	echo '<row></row>';
}
*/
echo "</data>";
mysql_free_result($result);
?>