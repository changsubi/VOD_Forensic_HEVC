<?php
$global['configurationVersion'] = 3.1;
$global['disableAdvancedConfigurations'] = 0;
$global['videoStorageLimitMinutes'] = 0;
$global['disableTimeFix'] = 0;
$global['logfile'] = '/var/www/html/WKstream/videos/avideo.log';
if(!empty($_SERVER['SERVER_NAME']) && $_SERVER['SERVER_NAME']!=='localhost' && !filter_var($_SERVER['SERVER_NAME'], FILTER_VALIDATE_IP)) { 
    // get the subdirectory, if exists
    $file = str_replace("\\", "/", __FILE__);
    $subDir = str_replace(array($_SERVER["DOCUMENT_ROOT"], 'videos/configuration.php'), array('',''), $file);
    $global['webSiteRootURL'] = "http".(!empty($_SERVER['HTTPS'])?"s":"")."://".$_SERVER['SERVER_NAME'].$subDir;
}else{
    $global['webSiteRootURL'] = 'http://192.168.10.96/WKstream/';
}
$global['systemRootPath'] = '/var/www/html/WKstream/';
$global['salt'] = '5f0d59f43d16b';
$global['disableTimeFix'] = 0;
$global['enableDDOSprotection'] = 1;
$global['ddosMaxConnections'] = 40;
$global['ddosSecondTimeout'] = 5;
$global['strictDDOSprotection'] = 0;
$global['noDebug'] = 0;
$global['webSiteRootPath'] = '';
if(empty($global['webSiteRootPath'])){
    preg_match('/https?:\/\/[^\/]+(.*)/i', $global['webSiteRootURL'], $matches);
    if(!empty($matches[1])){
        $global['webSiteRootPath'] = $matches[1];
    }
}
if(empty($global['webSiteRootPath'])){
    die('Please configure your webSiteRootPath');
}

$mysqlHost = 'localhost';
$mysqlPort = '3306';
$mysqlUser = 'root';
$mysqlPass = '1234';
$mysqlDatabase = 'test';

/**
 * Do NOT change from here
 */

require_once $global['systemRootPath'].'objects/include_config.php';
