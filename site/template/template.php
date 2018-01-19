<!DOCTYPE html>
<?php session_start();
if (isset($_SESSION['isclean'])) {
if (!$_SESSION['isclean']) {
	$_SESSION['infores'] = '';
	$_SESSION['errorsres'] = '';
	$_SESSION['infobil'] = '';
	$_SESSION['errorsbil'] = '';
	$_SESSION['info'] = '';
	$_SESSION['errors'] = '';
} else {
	$_SESSION['isclean'] = false;
}}
?>

<html>
<head>
    <meta charset="utf-8" />
    <title><?php pageTitle(); ?> | <?php siteName(); ?></title>
    <link rel="stylesheet" type="text/css" href="template/style.css" media="screen">
</head>
<body>
<div class="wrap">

    <header>
        
        <h1><a href="?page=accueil"><?php siteName(); ?></a></h1>
            <nav class="menu">
                <?php navMenu(); ?>
            </nav>
    </header>

    <article>
        <h2>> <?php pageTitle(); ?></h2>
        <?php pageContent(); ?>
    </article>

    <footer>Reuter &amp; Vallée</footer>

</div>
</body>
</html>
