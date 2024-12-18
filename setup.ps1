# Variables
$downloadUrl = "https://www.cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi"
$installerPath = "$env:TEMP\CloudbaseInitSetup_Stable_x64.msi"
$newUsername = "Administrateur"  # Remplacez par le nom d'utilisateur souhaité

# Téléchargement de l'installateur
Write-Host "Téléchargement de l'installateur..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath

# Installation de Cloudbase-Init
Write-Host "Installation de Cloudbase-Init..."
Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" /quiet /norestart" -Wait

# Configuration de l'utilisateur
Write-Host "Configuration de l'utilisateur..."
Set-Content -Path "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" -Value "
[DEFAULT]
username = $newUsername
"

# Configuration du port COM1 série
Write-Host "Configuration du port COM1 série..."
Set-Content -Path "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" -Append -Value "
serial_port = COM1
serial_port_settings = 9600,8,N,1
"

# Nettoyage de l'installateur
Write-Host "Nettoyage de l'installateur..."
Remove-Item -Path $installerPath -Force

# Redémarrage de l'ordinateur
Write-Host "Redémarrage de l'ordinateur dans 10 secondes..."
Start-Sleep -Seconds 10
Restart-Computer -Force
