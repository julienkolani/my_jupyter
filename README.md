
# Guide d'utilisation du JupyterLab Docker

Ce guide vous aidera à télécharger, construire et utiliser une image Docker pour JupyterLab, en personnalisant certains paramètres tels que l'utilisateur principal, le volume, le port, et le mot de passe.

## Téléchargement des fichiers Docker

### Dockerfile

Vous pouvez télécharger les fichiers avec la commande suivante :

```bash
git clone https://github.com/tutorial.git
```

## Construction et exécution du conteneur Docker

Pour construire et exécuter le conteneur Docker, utilisez les commandes suivantes :

```bash
docker-compose up -d
```

## Modification de l'utilisateur principal dans le Dockerfile

Vous pouvez changer l'utilisateur principal dans le Dockerfile en modifiant la section suivante :

```Dockerfile
RUN useradd -m -s /bin/bash NOUVEL_UTILISATEUR && \
    echo "NOUVEL_UTILISATEUR:VOTRE_MOT_DE_PASSE" | chpasswd && \
    usermod -aG root NOUVEL_UTILISATEUR
```

## Génération du hachage SHA1 pour le mot de passe

Utilisez la commande suivante pour générer le hachage SHA1 du mot de passe souhaité :

```bash
python -c "import hashlib

password = 'VOTRE_MOT_DE_PASSE'

hashed_password = hashlib.sha1(password.encode()).hexdigest()

print(f'Le hachage SHA1 du mot de passe est : sha1:{hashed_password}')
"
```

## Ajout du hachage SHA1 dans le Dockerfile

Ajoutez le hachage SHA1 généré à la section correspondante du Dockerfile :

```Dockerfile
RUN echo "c.ServerApp.password = 'sha1:VOTRE_HACHAGE_SHA1'" > /home/NOUVEL_UTILISATEUR/.jupyter/jupyter_lab_config.py
```

## Personnalisation des ports et des volumes dans docker-compose.yml

Modifiez les ports et les volumes selon vos préférences dans le fichier docker-compose.yml :

```yaml
ports:
  - "VOTRE_PORT_HOTE:8000"

volumes:
  - /VOTRE/REPERTOIRE_HOTE:/home/NOUVEL_UTILISATEUR/host
```

## Suppression du conteneur Docker

Pour supprimer le conteneur Docker, utilisez la commande suivante :

```bash
docker-compose down
```
