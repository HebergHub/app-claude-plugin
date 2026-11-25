# HebergHub pour Claude

Gérez vos services HebergHub (VPS, hébergement web, serveurs de jeu, applications PaaS, factures, tickets) depuis Claude. Claude se connecte avec votre compte de la boutique, voit l'état de vos services et agit pour vous **après votre accord** : démarrer, arrêter, redémarrer, redéployer, envoyer une commande à un serveur de jeu, modifier un fichier de configuration, ouvrir un ticket. Il ne voit aucun mot de passe et ne peut rien supprimer, réinstaller, restaurer, résilier ni payer.

Adresse du connecteur : `https://boutique.heberghub.fr/mcp`

## claude.ai, Claude Desktop, application mobile

1. Personnaliser → Connecteurs → Ajouter → **Ajouter un connecteur personnalisé**.
2. Nom : `HebergHub` ; URL : `https://boutique.heberghub.fr/mcp`.
3. Connexion : « Se connecter maintenant ». Client OAuth : laissez le choix par défaut ou « Enregistrer automatiquement ».
4. Connectez-vous à la boutique et autorisez l'accès.

Skills (facultatif) : téléchargez les archives sur la [page de la dernière version](https://github.com/HebergHub/app-claude-plugin/releases/latest) et ajoutez-les dans Personnaliser → Skills → Téléverser une skill.

Guide complet (connexion, autorisations, outils, limites, dépannage) : [heberghub.fr/claude](https://heberghub.fr/claude).

## Claude Code

Avec le plugin (connecteur + skills) :

```text
/plugin marketplace add HebergHub/app-claude-plugin
/plugin install heberghub@heberghub
```

puis `/mcp` pour vous connecter. Sans plugin, le connecteur seul :

```bash
claude mcp add --transport http heberghub https://boutique.heberghub.fr/mcp
```

## Skills

| Skill | Usage |
|---|---|
| `heberghub-diagnostic` | Un service est en panne, lent ou inaccessible |
| `heberghub-minecraft` | Réglages, joueurs, plugins et lenteurs d'un serveur Minecraft |
| `heberghub-paas` | Déploiement, journaux et variables d'une application PaaS |
| `heberghub-vps` | État, ports, instantanés et accès d'un VPS |

## Gérer l'accès

Page **Claude** de votre espace client (`https://boutique.heberghub.fr/claude`) : connexions actives et révocation, mode lecture seule, pause, journal des actions de Claude.
