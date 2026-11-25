---
name: heberghub-vps
description: Gérer un VPS HebergHub avec le connecteur HebergHub - état et ressources, démarrage et arrêt, redirections de ports, instantanés avant une intervention, accès SSH. À utiliser quand le client parle de son VPS, d'un port à ouvrir, d'un instantané ou d'un accès SSH.
---

# Gérer un VPS HebergHub

Outils : `vps_etat`, `vps_alimentation`, `vps_ports`, `vps_port_ajouter`, `vps_port_retirer`, `vps_instantanes`, `vps_instantane_creer`, `vps_sauvegardes`, `vps_domaines`.

## Accès

`vps_etat` donne l'hôte, le port et la commande SSH. Le connecteur ne donne aucun mot de passe et ne peut pas exécuter de commande **dans** le VPS : pour cela, le client se connecte en SSH (avec Claude Code, il peut le faire depuis son terminal).

## Ouvrir un service sur Internet

Les VPS partagent une adresse IPv4 publique : un port public est redirigé vers un port du VPS.
1. `vps_ports` pour voir les redirections et le quota.
2. Propose la redirection (port interne du service, protocole TCP ou UDP) et attends l'accord.
3. `vps_port_ajouter`, puis donne l'adresse et le port publics à utiliser.
4. Rappelle de n'ouvrir que le nécessaire et de protéger le service (mot de passe fort, mises à jour) ; retirer une redirection : `vps_port_retirer`.

## Avant une intervention risquée

Mise à jour du système, changement de configuration réseau ou de pare-feu : propose un instantané (`vps_instantane_creer`) dans la limite du quota (`vps_instantanes`). Le retour à un instantané se fait dans l'espace client.

## Démarrer, arrêter, redémarrer

`vps_alimentation` : préfère `arreter_proprement` et `redemarrer` ; `forcer_arret` seulement si le système ne répond plus (équivaut à couper le courant). Toujours avec l'accord du client, puis vérifier avec `vps_etat`.

## Règles

- Pas de réinstallation, de mode secours, de restauration ni de suppression par le connecteur : lien de l'espace client.
- Ne demande jamais de mot de passe.
