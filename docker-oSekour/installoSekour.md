
## Dans des vm ou des containers LXC, GNU/debian ou Ubuntu


### Sur la machine accueillant le Manager et où sera créé les conteneurs Docker faire les commandes


```
touch installDockerManager.sh | chmod u+x installDockerManager.sh
touch uninstallDocker.sh | chmod u+x uninstallDocker.sh
```

### Sur les machines accueillant les workers

```
touch installDockerWorker.sh | chmod u+x installDockerWorker.sh
touch uninstallDocker.sh | chmod u+x uninstallDocker.sh
```

### Il faudra juste copier/coller les scripts et faire les commandes :

- pour lancer l'installation sur le manager
`./installDockerManager.sh`

- pour lancer l'installation sur les workers
`./installDockerWorker.sh`

- pour tout désinstaller et nettoyer la vm
`./uninstallDocker.sh`

-----------------------------
