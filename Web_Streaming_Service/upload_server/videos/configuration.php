<?php
$global['configurationVersion'] = 2;
$global['webSiteRootURL'] = 'http://192.168.10.96/WK-Enc/';
$global['systemRootPath'] = '/var/www/html/WK-Enc/';
$global['webSiteRootPath'] = '';

$global['disableConfigurations'] = false;
$global['disableBulkEncode'] = false;
$global['disableImportVideo'] = false;
$global['disableWebM'] = false;

$mysqlHost = 'localhost';
$mysqlUser = 'root';
$mysqlPass = '1234';
$mysqlDatabase = 'aVideo2-Encoder';

$global['allowed'] = array('mp4', 'avi', 'mov', 'flv', 'mp3', 'wav', 'm4v', 'webm', 'wmv', 'mpg', 'mpeg', 'f4v', 'm4v', 'm4a', 'm2p', 'rm', 'vob', 'mkv', '3gp');
/**
 * Do NOT change from here
 */
if(empty($global['webSiteRootPath'])){
    preg_match('/https?:\/\/[^\/]+(.*)/i', $global['webSiteRootURL'], $matches);
    if(!empty($matches[1])){
        $global['webSiteRootPath'] = $matches[1];
    }
}
if(empty($global['webSiteRootPath'])){
    die('Please configure your webSiteRootPath');
}


require_once $global['systemRootPath'].'objects/include_config.php';
