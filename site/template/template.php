<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title><?php pageTitle(); ?> | <?php siteName(); ?></title>
    <link rel="stylesheet" type="text/css" href="template/style.css" media="screen">
</head>
<body>
<div class="wrap">

    <header>
        
        <h1><?php siteName(); ?></h1>
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
