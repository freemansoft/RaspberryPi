# Usage:
# Enable-Ethernet-Gadget -$PIBootDrive F: -NetworkName my-ssid -NetworkPassord my-network-password

#Commandline parameters
param (
    # Change this to your SD card boot location or pass in as parameter
    $PiBootDrive="f:", 
    $NetworkName,
    $NetworkPassword
    )

$SshFileNamePath = "$PiBootDrive\\ssh"
Write-Debug "SshFileNamePath: $SshFileNamePath"

$ConfigFilePath="$PiBootDrive\\config.txt"
$EnableGadgetOverlay="dtoverlay=dwc2"
Write-Debug "ConfigFilePath $ConfigFilePath"

$CmdlineConfigFilePath="$PiBootDrive\\cmdline.txt"
Write-Debug "CmdlineConfigFilePath = $CmdlineConfigFilePath"

$CmdlinePatternOrig="rootwait quiet"
$CmdlinePatternFinal="rootwait modules-load=dwc2,g_ether quiet"

$WpaSupplicantPath="$PiBootDrive\\wpa_supplicant.conf"

####################################################
# We know this file is always there
if (!(Test-Path $ConfigFilePath)){
    Write-Warning "Exiting: Can't find files in $PiBootDrive.  Is PiBootDrive set correctly?"
    exit
}

####################################################
# make a backup with date so we don't overwrite original backup
$backup = @{
LiteralPath= "$ConfigFilePath", "$CmdlineConfigFilePath"
CompressionLevel = "Fastest"
DestinationPath = "$PiBootDrive\backup-cmd-config-$(get-date -f yyyy-MM-dd-hhmmss).zip"
}
echo 'Backing up files to', $backup.DestinationPath
Compress-Archive @backup

####################################################
# touch ssh to enable ssh
echo "Enabling ssh"
Add-Content $SshFileNamePath $null

####################################################
# add the overly to config.txt
$ConfigContentOrig = Get-Content $ConfigFilePath
Write-Debug "$ConfigFilePath full contents:`n $ConfigContentOrig"
# see if the final pattern is already in file
$ConfigContainsOverlay = $ConfigContentOrig | %{$_ -match $EnableGadgetOverlay}
Write-Debug "ConfigTxtContainsOverlay: $ConfigContainsOverlay"
If($ConfigContainsOverlay -notcontains $true){
    echo "Enabling ethernet gadget in $ConfigFilePath"
    Add-Content -NoNewline -Path $ConfigFilePath "`n# Enable ethernet gadget`n"
    Add-Content -NoNewline -Path $ConfigFilePath $EnableGadgetOverlay
} else {
    echo "Ethernet gadget already exists in $ConfigFilePath"
}

####################################################
# add overlay to cmdline.txt
# add the overlay to the end of the right line in cmdline.txt
$CmdlineContentOrig=Get-Content -path $CmdlineConfigFilePath -Raw
Write-Debug "cmdline.txt before processing`n $CmdlineContentOrig"
# see if original or final pattern are in file
$CmdlineContainsOrig = $CmdlineContentOrig | %{$_ -match $CmdlinePatternOrig}
$CmdlineContainsTarget = $CmdlineContentOrig | %{$_ -match $CmdlinePatternFinal}
if($CmdlineContainsOrig -contains $true){
    echo "Adding ethernet gadget to $CmdlineConfigFilePath"
    $CmdlineContentFinal = $CmdlineContentOrig -replace "$CmdlinePatternOrig", "$CmdlinePatternFinal"
    Write-Debug "cmdline.txt after `n $CmdlineContentFinal"
    Set-Content -NoNewline -Path $CmdlineConfigFilePath -Value $CmdlineContentFinal
} elseif ($CmdlineContainsTarget -contains $true ) {
    echo "Ethernet gadget already exists in $CmdlineConfigFilePath"
} else {
    echo "Ethernet gadget not added to $CmdlineConfigFilePath because I'm confused about contents"
}


###################################################
# enable wireless if values provided
if ( ( $NetworkName -ne $null) -and ($NetworkPassword -ne $null)){
    echo "Configuring $WpaSupplicantPath for network $NetworkName"
    $WpaSupplicantString = 
'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
    ssid="NetworkName"
    psk="NetworkPassword"
    key_mgmt=WPA-PSK
}
'
    $WpaSupplicantString = $WpaSupplicantString -replace "`r", ""
    $WpaSupplicantString = $WpaSupplicantString -replace "NetworkName", "$NetworkName"
    $WpaSupplicantString = $WpaSupplicantString -replace "NetworkPassword", "$NetworkPassword"
    Set-Content -NoNewline -Path $WpaSupplicantPath -Value $WpaSupplicantString
} else {
    echo "Network not enabled: NetworkName or NetworkPassword not provided"
}

###################################################
# 
echo "Copying aircrack-install.sh to boot volume in case you want to install and use it"
echo "Copying firewall.sh to boot volume in case you want to allow SSH only on USB0"
echo "Copying hostname-custom-serial.sh to boot volume in case you want to set hostname to pi-<serial>.local"
Copy-Item -Path "*.sh" -Destination "$PiBootDrive"
