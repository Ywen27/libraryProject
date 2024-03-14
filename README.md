# Système de gestion de bibliothèque
*Read this in [English](README_en.md)*

## Description du projet :
Ce système de gestion de bibliothèque est une application web conçue pour simplifier la gestion d'une bibliothèque. Il offre des fonctionnalités pour les administrateurs et les lecteurs (utilisateurs).

### Fonctionnalités pour l'administrateur :
- Authentification : L'administrateur doit se connecter à l'aide d'un nom d'utilisateur et d'un mot de passe.
- Gestion des prêts : L'administrateur peut consulter la liste des prêts, faire un prêt pour le lecteur, modifier le statut d'un prêt(en cours de prêt, retourné, perdu, etc.), c'est-à-dire rendre un livre.
- Gestion des livres : L'administrateur peut consulter la liste des livres, ajouter de nouveaux livres, modifier les informations des livres existants et supprimer des livres.
- Gestion des utilisateurs : L'administrateur peut consulter la liste des utilisateurs, modifier leurs informations et supprimer des utilisateurs.
- Gestion des types de livres : L'administrateur peut consulter la liste des types de livres, ajouter de nouveaux types et supprimer des types.
- Gestion des annonces : L'administrateur peut faire une annonce si souhaitée.
- Statistiques : L'administrateur peut consulter des statistiques sur les livres par type.
- Il y a deux catégories d'administrateurs : Senior et Ordinaire. Les administrateurs seniors ont la capacité de gérer les administrateurs, tandis que les administrateurs ordinaires ne peuvent pas.

### Fonctionnalités pour les lecteurs
- Authentification : Les lecteurs doit se connecter à l'aide d'un nom d'utilisateur et d'un mot de passe.
- Les utilisateurs peuvent modifier leurs informations personnelles ainsi que leur mot de passe.
- Recherche de livres : Les utilisateurs peuvent rechercher des livres par titre, auteur, genre.
- Consultation des informations d'un livre : Les utilisateurs peuvent consulter les informations d'un livre, telles que le titre, l'auteur, le genre, et la disponibilité, etc.
- Consulter les prêts personnels : Les utilisateurs peuvent regarder leur chronologie d'emprunt de livres.
- Consulter les annonces.

## Technologies Utilisées
- Base de données : MySQL
- IDE : IDEA
- Pool de connexions de données : Druid
- Conteneur Web : Apache Tomcat
- Outils de gestion de projet : Maven
- Outils de contrôle de versions : Git
- Technologie back-end : Spring + SpringMVC + MyBatis（SSM）
- Framework front-end : bootstrap




