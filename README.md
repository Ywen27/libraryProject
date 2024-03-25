# 📚 Système de gestion de bibliothèque
*Read this in [English](README_en.md)*

## 📝 Description du projet :
Ce système de gestion de bibliothèque est une application web en Java avec Maven conçue pour simplifier la gestion d'une bibliothèque. Il offre des fonctionnalités pour les administrateurs et les lecteurs (utilisateurs).

### 🛠️ Technologies Utilisées
- Base de données : [MySQL](library.sql)
- IDE : Intellij IDEA
- Pool de connexions de données : Druid
- Conteneur Web : Apache Tomcat
- Outils de gestion de projet : [Maven](pom.xml)
- Outils de contrôle de versions : Git
- Technologie back-end : [Spring](src/main/resources/spring.xml) + [SpringMVC](src/main/resources/springmvc.xml) + [MyBatis](src/main/resources/generatorConfig.xml)
- Framework front-end : bootstrap

### 💼 Fonctionnalités pour l'administrateur :
- 🔐 Authentification : L'administrateur doit se connecter à l'aide d'un nom d'utilisateur et d'un mot de passe.
- 📋 Gestion des prêts : L'administrateur peut consulter la liste des prêts, faire un prêt pour le lecteur, modifier le statut d'un prêt(en cours de prêt, retourné, perdu, etc.), c'est-à-dire rendre un livre.
- 📚 Gestion des livres : L'administrateur peut consulter la liste des livres, ajouter de nouveaux livres, modifier les informations des livres existants et supprimer des livres.
- 👥 Gestion des utilisateurs : L'administrateur peut consulter la liste des utilisateurs, modifier leurs informations et supprimer des utilisateurs.
- 🏷️ Gestion des types de livres : L'administrateur peut consulter la liste des types de livres, ajouter de nouveaux types et supprimer des types.
- 📢 Gestion des annonces : L'administrateur peut faire une annonce si souhaitée.
- 📊 Statistiques : L'administrateur peut consulter des statistiques sur les livres par type.
- 👑 Il y a deux catégories d'administrateurs : Senior et Ordinaire. Les administrateurs seniors ont la capacité de gérer les administrateurs, tandis que les administrateurs ordinaires ne peuvent pas.
- #### Page de connexion
![Page de connexion](src/main/webapp/images/loginPage.png)
- #### Page d'accueil
![Page d'accueil](src/main/webapp/images/homePage.png)
- #### Page de gestion des prêts
![Page de gestion des prêts](src/main/webapp/images/LendManagePage.png)

### ‍🎓 Fonctionnalités pour les lecteurs
- 🔐 Authentification : Les lecteurs doit se connecter à l'aide d'un nom d'utilisateur et d'un mot de passe.
- ✏️ Les utilisateurs peuvent modifier leurs informations personnelles ainsi que leur mot de passe.
- 🔍 Recherche de livres : Les utilisateurs peuvent rechercher des livres par titre, auteur, genre.
- 📘 Consultation des informations d'un livre : Les utilisateurs peuvent consulter les informations d'un livre, telles que le titre, l'auteur, le genre, et la disponibilité, etc.
- 📆 Consulter les prêts personnels : Les utilisateurs peuvent regarder leur chronologie d'emprunt de livres.
- 📢 Consulter les annonces.
- #### Page de profil d'un lecteur
![Page de profil d'un lecteur](src/main/webapp/images/profileReader.png)
- #### Page de livre d'un lecteur
![Page de livre d'un lecteur](src/main/webapp/images/bookPageReader.png)







