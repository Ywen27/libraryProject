# Système de gestion de bibliothèque
*Read this in [English](README_en.md)*
## Technologies Utilisées
- Base de données: MySQL
- IDE: IDEA
- Pool de connexions de données: Druid
- Conteneur Web: Apache Tomcat
- Outils de gestion de projet: Maven
- Outils de contrôle de versions: Git
- Technologie back-end: Spring + SpringMVC + MyBatis（SSM）
- Framework front-end：bootstrap

## Description du projet:
Ce système de gestion de bibliothèque est une application web conçue pour simplifier la gestion d'une bibliothèque. Il offre des fonctionnalités pour les administrateurs et les utilisateurs (clients).

#Fonctionnalités pour l'administrateur:

- Authentification : L'administrateur doit se connecter à l'aide d'un nom d'utilisateur et d'un mot de passe.
- Gestion des prêts : L'administrateur peut consulter la liste des livres prêtés, modifier leur statut (en cours de prêt, retourné, perdu, etc.) et gérer les dates de retour.
- Gestion des livres : L'administrateur peut consulter la liste des livres, ajouter de nouveaux livres, modifier les informations des livres existants et supprimer des livres.
- Gestion des utilisateurs : L'administrateur peut consulter la liste des utilisateurs, modifier leurs informations et supprimer des utilisateurs.
- Gestion des types de livres : L'administrateur peut consulter la liste des types de livres, ajouter de nouveaux types et supprimer des types.
- Gestion des annonces: L'administrateur peut faire une annonce si souhaité.
- Statistiques : L'administrateur peut consulter des statistiques sur les prêts, les livres et les utilisateurs.

# Fonctionnalités pour les utilisateurs

Recherche de livres : Les utilisateurs peuvent rechercher des livres par titre, auteur, genre, etc.
Consultation des informations d'un livre : Les utilisateurs peuvent consulter les informations d'un livre, telles que le titre, l'auteur, le genre, la date de publication, etc.
Réservation d'un livre : Les utilisateurs peuvent réserver un livre qui n'est pas disponible.
Prolongation d'un prêt : Les utilisateurs peuvent prolonger la durée d'un prêt en cours.
Consultation de l'historique des prêts : Les utilisateurs peuvent consulter l'historique de leurs prêts.
