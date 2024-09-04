<?php

$customEnvFilePath = '../.env';
if (file_exists($customEnvFilePath)) {
    $lines = file($customEnvFilePath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        list($key, $value) = explode('=', $line, 2);
        putenv("$key=$value");
        $_ENV[$key] = $value;
    }
}

function getDB()
{
	$dbData = getClientDBData();

	if( isset($dbData->dbname) )
	{
		$dbhost="localhost";
		$dbport= ( strpos($_SERVER['HTTP_HOST'], 'localhost') === false ? "3306" : "3307");
		$dbuser = $dbData->dbuser;
		$dbpass = $dbData->dbpass;
		$dbname = $dbData->dbname;
		$dbConnection = new PDO("mysql:host=$dbhost;port=$dbport;dbname=$dbname", $dbuser, $dbpass);
		$dbConnection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		return $dbConnection;
	}
	else
	{
		echo "No user found!";
		// var_dump($_SERVER['HTTP_ORIGIN']);
	}
}

function getMISDB()
{
	$dbhost="localhost";
	$dbport= ( strpos($_SERVER['HTTP_HOST'], 'localhost') === false ? "3306" : "3307");
	$dbuser="dbusr";
	$dbpass="kK4OE/H_om@jI)J*P";
	$dbname="kenyabuzz";
	$dbConnection = new PDO("mysql:host=$dbhost;port=$dbport;dbname=$dbname", $dbuser, $dbpass);
	$dbConnection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $dbConnection;
}

function getClientDBData()
{
	$dbConnection = getMISDB();

	$subDomain = getSubDomain();
	$sth = $dbConnection->prepare("SELECT client_id, dbusername, dbpassword FROM clients WHERE subdomain = :subDomain");
	$sth->execute(array(':subDomain' => $subDomain));
	$appData = $sth->fetch(PDO::FETCH_OBJ);

	$dbData = new stdClass();
	if( $appData )
	{
		$dbData->dbuser = $appData->dbusername;
		$dbData->dbpass = $appData->dbpassword;
		$dbData->dbname = "eduweb_" . $subDomain;
		$dbData->subdomain = $subDomain;
	}
	$dbConnection = null;
	return $dbData;
}


function getPgDB()
{
	$dbhost = getenv('PG_DB_HOST');
	$dbport = getenv('PG_DB_PORT');

	$usr = getenv('PG_DB_USER');
	$dbuser = rot47($usr);

	$pass = getenv('PG_DB_PASS');
	$dbpass = rot47($pass);

	$dbn = getenv('PG_DB_NAME');
	$dbname = rot47($dbn);

	$dbConnection = new PDO("pgsql:host=$dbhost;port=$dbport;dbname=$dbname", $dbuser, $dbpass);
	$dbConnection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $dbConnection;
}

function setDBConnection($subDomain)
{
	$dbConnection = getMISDB();
	$sth = $dbConnection->prepare("SELECT client_id, dbusername, dbpassword FROM clients WHERE subdomain = :subDomain");
	$sth->execute(array(':subDomain' => $subDomain));
	$appData = $sth->fetch(PDO::FETCH_OBJ);

	$dbhost="localhost";
	$dbport= ( strpos($_SERVER['HTTP_HOST'], 'localhost') === false ? "3306" : "3307");
	$dbuser = $appData->dbusername;
	$dbpass = $appData->dbpassword;
	$dbname = "eduweb_" . $subDomain;
	$dbConnection = new PDO("mysql:host=$dbhost;port=$dbport;dbname=$dbname", $dbuser, $dbpass);
	$dbConnection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $dbConnection;
}

function getSubDomain()
{
    if( isset($_SERVER['HTTP_X_VERLOC']) ) {
		$epoch_time = $_SERVER['HTTP_X_VERLOC']; // header with encoded values
		$decoded = rot47($epoch_time); // decoding
		$decoded_values = explode (";", $decoded); // split the string using ";". [0] = domain, [1] = timestamp
		$currentTimestamp = time();

		// we want to check the origin and timestamp

		// Calculate the timestamp difference in seconds
		$timestampDifference = $currentTimestamp - $decoded_values[1];

		// Check if the timestamp difference is within 2 minutes (120 seconds)
		if ($timestampDifference <= 120) {
			// this is within 2 minutes since the time of request
			if($decoded_values[0] == "kenyabuzz.com" || $decoded_values[0] == "portal.kenyabuzz.com" || $decoded_values[0] == "api.kenyabuzz.com"){
				return true;
			}else{
				return false;
			}
		} else {
			// this is older than 2 minutes
			return false;
		}
		
	} elseif ( isset($_SERVER['HTTP_REFERER']) ) {

    	$url = $_SERVER['HTTP_REFERER'];
		$domain = substr($url, strpos($url, '://')+3);
		$domain = ( strpos($domain, '/') !== false ? substr($domain, 0, strpos($domain, '/')) : $domain ); // check if domain has slash
		$subdomain = substr($domain, 0, strpos($domain, '.'));
		if( ($domain == "kenyabuzz.com" || $domain == "portal.kenyabuzz.com") && ($subdomain == "kenyabuzz" || $subdomain == "api" || $subdomain == "portal") ){
			return true;
		}else{
			return false;
		}

    } else {

		if(isset($_SERVER['HTTP_ORIGIN'])){
			$url = $_SERVER['HTTP_ORIGIN'];
			$domain = substr($url, strpos($url, '://')+3);
			$domain = ( strpos($domain, '/') !== false ? substr($domain, 0, strpos($domain, '/')) : $domain ); // check if domain has slash
			$subdomain = substr($domain, 0, strpos($domain, '.'));
			if( ($domain == "kenyabuzz.com" || $domain == "portal.kenyabuzz.com") && ($subdomain == "kenyabuzz" || $subdomain == "api" || $subdomain == "portal") ){
				return true;
			}else{
				return false;
			}
		}

    }

}

function rot47($input) {
    $output = '';

	for ($i = 0; $i < strlen($input ?? ''); $i++) {
		$char = $input[$i];
		$ascii = ord($char); // Get ASCII value of the character

		// Check if the character is a printable ASCII character
		if ($ascii >= 33 && $ascii <= 126) {
			$rot47 = ($ascii + 47 - 33) % 94 + 33; // Apply Rot47 transformation
			$output .= chr($rot47); // Convert ASCII value back to character
		} else {
			$output .= $char; // Leave non-printable characters unchanged
		}
	}
    
    return $output;
}

?>
