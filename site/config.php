<?php

/**
 * Used to store website configuration information.
 *
 * @var string
 */
function config($key = '')
{
    $config = [
        'name' => 'Get A Train !',
        'nav_menu' => [
            'accueil' => 'Accueil',
            'billets' => 'Billets',
            'informations' => 'Informations',
            'resa' => 'Mes Réservations',
            'contact' => 'Contact',
        ],
        'template_path' => 'template',
        'content_path' => 'content',
        'pretty_uri' => true,
        'version' => 'v2.0',
        'database' => 'sncf',
        'host' => 'localhost',
        'user' => 'sncfadmin',
        'passit' => 'mypassword',
    ];

    return isset($config[$key]) ? $config[$key] : null;
}
