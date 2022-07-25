param (
  [string] $SSID,
  [string] $pw  = $null
)

set-strictMode -version 3

$pw_xml = ''
if ($pw -ne $null) {
   $pw_xml = @"
       <sharedKey> 
          <keyType>passPhrase</keyType> 
          <protected>false</protected> 
          <keyMaterial>$PW</keyMaterial> 
       </sharedKey> 
"@
}

@"
<?xml version="1.0"?> 
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"> 
  <name>$SSID</name> 
  <SSIDConfig><SSID><name>$SSID</name></SSID></SSIDConfig> 
  <connectionType>ESS</connectionType> 
  <connectionMode>auto</connectionMode> 
  <MSM> 
    <security> 
       <authEncryption> 
         <authentication>WPA2PSK</authentication> 
          <encryption>AES</encryption> 
          <useOneX>false</useOneX> 
       </authEncryption> 
$pw_xml
      </security> 
  </MSM> 
  <MacRandomization xmlns="http://www.microsoft.com/networking/WLAN/profile/v3"> 
      <enableRandomization>false</enableRandomization> 
  </MacRandomization> 
</WLANProfile> 
"@ | out-file -encoding ascii wlan-profile.xml


netsh wlan add profile filename="wlan-profile.xml"
netsh wlan connect name="$SSID"

remove-item wlan-profile.xml
