# Définition des variables
$downloadUrl = "https://www.cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi"
$installerPath = "$env:TEMP\CloudbaseInitSetup_Stable_x64.msi"
$newUsername = "Administrateur"  # Remplacez par le nom d'utilisateur souhaité
$configFilePath = "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf"

# Téléchargement de l'installateur
Write-Host "Téléchargement de l'installateur depuis $downloadUrl..."
try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath -ErrorAction Stop
    Write-Host "Téléchargement réussi : $installerPath"
} catch {
    Write-Error "Erreur lors du téléchargement : $_"
    exit 1
}

# Installation de Cloudbase-Init
Write-Host "Installation de Cloudbase-Init..."
try {
    Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" /quiet /norestart" -Wait -ErrorAction Stop
    Write-Host "Installation terminée avec succès."
} catch {
    Write-Error "Erreur lors de l'installation : $_"
    exit 1
}

# Configuration de l'utilisateur
Write-Host "Configuration de l'utilisateur..."
try {
    Set-Content -Path $configFilePath -Value "
[DEFAULT]
username = $newUsername
"
    Write-Host "Configuration de l'utilisateur ajoutée avec succès."
} catch {
    Write-Error "Erreur lors de la configuration de l'utilisateur : $_"
    exit 1
}

# Configuration du port COM1 série
Write-Host "Configuration du port COM1 série..."
try {
    Add-Content -Path $configFilePath -Value "
serial_port = COM1
serial_port_settings = 9600,8,N,1
"
    Write-Host "Configuration du port COM1 série ajoutée avec succès."
} catch {
    Write-Error "Erreur lors de la configuration du port série : $_"
    exit 1
}

# Nettoyage de l'installateur
Write-Host "Nettoyage de l'installateur..."
try {
    Remove-Item -Path $installerPath -Force
    Write-Host "Fichier d'installation supprimé : $installerPath"
} catch {
    Write-Error "Erreur lors de la suppression de l'installateur : $_"
}

# Redémarrage de l'ordinateur
Write-Host "Redémarrage de l'ordinateur dans 10 secondes..."
Start-Sleep -Seconds 10
try {
    Restart-Computer -Force
} catch {
    Write-Error "Erreur lors du redémarrage : $_"
    exit 1
}
