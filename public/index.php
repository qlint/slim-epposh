<?php
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;
use Selective\BasePath\BasePathMiddleware;
use ShoppeCors\Middleware\CorsMiddleware;

require __DIR__ . '/../vendor/autoload.php';
require '../lib/CorsMiddleware.php';
require '../lib/db.php';

error_reporting(E_ALL);  // uncomment this only when testing
ini_set('display_errors', 1); // uncomment this only when testing
ini_set('memory_limit', '1024M');
ini_set('max_execution_time', '300'); //600 seconds = 10 minutes
date_default_timezone_set("Africa/Nairobi");

$app = AppFactory::create();

// Add Slim routing middleware
$app->addRoutingMiddleware();

// Set the base path to run the app in a subdirectory.
// This path is used in urlFor().
$app->add(new BasePathMiddleware($app));

$app->options('/{routes:.+}', function ($request, $response, $args) {
   return $response;
});

// Add the CORS middleware to the pipeline
$app->add(new CorsMiddleware());

$app->addErrorMiddleware(true, true, true);

/*************** Auth Functions ***************/
require('auth_functions.php');

$app->get('/', function (Request $request, Response $response, $args) {
    $response->getBody()->write("Hello world!");
    return $response;
});

$app->get('/healthcheck', function (Request $request, Response $response, $args) {
    $db = getPgDB();
    $sth = $db->prepare("SELECT CURRENT_TIMESTAMP AS time_now");
    $sth->execute( array() );
    $res = $sth->fetch(PDO::FETCH_OBJ);
 
    if ($res) {
       $payload =   json_encode(array('response' => 'success', 'data' => 'The health timestamp is '.$res->time_now ));
       unset($db,$res);
 
       $response->getBody()->write($payload);
       return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
    } else {
       $payload =   json_encode(array('response' => 'success', 'data' => 'Could not fetch data' ));
       unset($db,$res);
 
       $response->getBody()->write($payload);
       return $response->withHeader('Content-Type', 'application/json')->withStatus(400);
    }
    
});

$app->run();