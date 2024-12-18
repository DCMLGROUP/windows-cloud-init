# Installation et Configuration de Cloudbase-Init sur Windows

Ce script PowerShell est conçu pour automatiser l'installation et la configuration de **Cloudbase-Init** sur un système Windows. Cloudbase-Init permet de configurer automatiquement des machines dans des environnements cloud supportant l'utilisation de disques Cloud-Init, comme **Proxmox VE** ou d'autres plateformes similaires.

## Prérequis

Avant d'exécuter ce script, assurez-vous des points suivants :

1. **Port Série** : La machine doit être configurée avec un port COM (série) en plus du disque Cloud-Init.
2. **Droits Administrateur** : L'exécution du script nécessite des droits d'administration.

## Contenu du Script

### Variables

- `$downloadUrl` : URL de téléchargement de l'installateur Cloudbase-Init.
- `$installerPath` : Emplacement temporaire pour stocker l'installateur.
- `$newUsername` : Nom de l'utilisateur que Cloudbase-Init créera sur la machine.

### Étapes du Script

1. **Téléchargement de l'installateur** : Le script télécharge le fichier MSI d'installation depuis l'URL officielle.
2. **Installation silencieuse de Cloudbase-Init** : Utilisation de `msiexec` pour installer le logiciel en mode silencieux.
3. **Configuration du fichier `cloudbase-init.conf`** :
   - Définit le nom d'utilisateur qui sera créé.
   - Configure le port COM1 avec les paramètres série requis (à 9600 bauds, 8 bits de données, sans parité, et 1 bit d'arrêt).
4. **Nettoyage de l'installateur** : Suppression du fichier MSI téléchargé.
5. **Redémarrage du système** : La machine redémarre pour appliquer les modifications.

## Instructions d'Utilisation

### 1. Exécution du Script

Pour exécuter le script :

1. Copiez le script dans un fichier avec l'extension `.ps1` (par exemple : `install_cloudbase_init.ps1`).
2. Lancez PowerShell en mode administrateur.
3. Exécutez la commande suivante :

   ```powershell
   .\setup.ps1
   ```

### 2. Vérification

Après redémarrage de la machine :

- Assurez-vous que le fichier `cloudbase-init.conf` se trouve dans `C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf` et contient les configurations attendues.
- Vérifiez que le port COM1 est configuré correctement dans les paramètres de la machine virtuelle.

## Exemple d’Utilisation dans Proxmox VE

Pour utiliser ce script avec **Proxmox VE** :

1. Créez une machine virtuelle dans Proxmox avec les spécifications suivantes :
   - Un disque attaché configuré pour Cloud-Init.
   - Un port COM ajouté à la machine virtuelle.
2. Démarrez la machine et laissez le script configurer Cloudbase-Init automatiquement.

## Notes

- Le fichier `cloudbase-init.conf` peut être modifié pour ajouter d'autres paramètres selon vos besoins.
- Ce script est conçu pour une installation standard et silencieuse. Si des modifications supplémentaires sont requises, ajustez le script en conséquence.

## Références

- [Site officiel de Cloudbase Solutions](https://www.cloudbase.it)
- [Documentation Proxmox VE](https://pve.proxmox.com/wiki/Main_Page)

## Avertissement

Ce script doit être exécuté avec précaution. Assurez-vous de l’adapter à votre environnement et de tester dans un environnement de préproduction avant une utilisation en production.

