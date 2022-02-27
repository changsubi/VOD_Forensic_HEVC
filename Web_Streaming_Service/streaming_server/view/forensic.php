<?php
error_reporting(E_ALL);
ini_set("display_errors",1);

//get user information
$userAgent = $_SERVER['HTTP_USER_AGENT'];

//get browser
if(preg_match('/MSIE/i',$userAgent) && !preg_match('/Opera/i',$userAgent)){
    $browser = 'Internet_Explorer';
  }
  else if(preg_match('/Firefox/i',$userAgent)){
    $browser = 'Mozilla_Firefox';
  }
  else if (preg_match('/Chrome/i',$userAgent)){
    $browser = 'Google_Chrome';
    if (preg_match('/Edg/i',$userAgent)){
       $browser = 'Microsoft_Edge';
    }
  }
  else if(preg_match('/Safari/i',$userAgent)){
    $browser = 'Apple_Safari';
  }
  elseif(preg_match('/Opera/i',$userAgent)){
    $browser = 'Opera';
  }
  elseif(preg_match('/Netscape/i',$userAgent)){
    $browser = 'Netscape';
  }
  else{
    $browser = "Other";
  }

//get OS
if (preg_match('/linux/i', $userAgent)){
    $os = 'linux';}
  elseif(preg_match('/macintosh|mac os x/i', $userAgent)){
    $os = 'mac';}
  elseif (preg_match('/windows|win32/i', $userAgent)){
    $os = 'windows';}
  else {
    $os = 'Other';
}

//get IP
$ipaddress = '';
    if (getenv('HTTP_CLIENT_IP')){
        $ipaddress = getenv('HTTP_CLIENT_IP');
    }else if(getenv('HTTP_X_FORWARDED_FOR')){
        $ipaddress = getenv('HTTP_X_FORWARDED_FOR');
    }else if(getenv('HTTP_X_FORWARDED')){
        $ipaddress = getenv('HTTP_X_FORWARDED');
    }else if(getenv('HTTP_FORWARDED_FOR')){
        $ipaddress = getenv('HTTP_FORWARDED_FOR');
    }else if(getenv('HTTP_FORWARDED')){
        $ipaddress = getenv('HTTP_FORWARDED');
    }else if(getenv('REMOTE_ADDR')){
        $ipaddress = getenv('REMOTE_ADDR');
    }else{
        $ipaddress = 'UNKNOWN';
}

// current date(download)
$cur_day = date("Y-m-d_H:i:s");







//insert information
//print_r($_GET['invideo'].'/'.$_GET['user_id'].'/'.$_GET['user_name'].'/'.$_GET['user_email'].'/'.$_GET['user_phone']);
//print_r($browser.'/'.$os.'/'.$ipaddress.'/'.$cur_day);


//추가 identification_char (GET)


//insert command
//print_r('WKforensic '.$_GET['invideo'].' '.$_GET['hevcvideo'].'.hevc '.$_GET['user_id'].' '.$_GET['user_name'].' '.$_GET['user_email'].' '.$_GET['user_phone'].' '.$os.' '.$browser.' '.$ipaddress.' '.$cur_day.' '.$_GET['hevcvideo']);
$mp4tohevc = shell_exec('ffmpeg -y -i '.$_GET['invideo'].' -c:v copy '.$_GET['invideo'].'.hevc');
$mark_insert = shell_exec('WKforensic '.$_GET['invideo'].'.hevc '.$_GET['invideo'].'_out.hevc '.$_GET['user_id'].' '.$_GET['user_name'].' '.$_GET['user_email'].' '.$_GET['user_phone'].' '.$os.' '.$browser.' '.$ipaddress.' '.$cur_day.' '.$_GET['hevcvideo'].'.mp4_out '.$_GET['identification_char']);
print_r('WKforensic '.$_GET['invideo'].'.hevc '.$_GET['invideo'].'_out.hevc '.$_GET['user_id'].' '.$_GET['user_name'].' '.$_GET['user_email'].' '.$_GET['user_phone'].' '.$os.' '.$browser.' '.$ipaddress.' '.$cur_day.' '.$_GET['hevcvideo'].' '.$_GET['identification_char']);
//$a = shell_exec('WKforensic in out '.$_GET['user_id'].' '.$_GET['user_name'].' '.$_GET['user_email'].' '.$_GET['user_phone'].' '.$os.' '.$browser.' '.$ipaddress.' '.$cur_day);


//print_r('ffmpeg -i '.$_GET['invideo'].' -c:v copy /var/www/html/WKstream/videos/QTC_dir/'.$_GET['hevcvideo'].'.hevc');
//$a = shell_exec('ffmpeg -i '.$_GET['video'].' -c:v copy /var/www/html/WKstream/videos/test.hevc');
//json_encode($a);
?>
