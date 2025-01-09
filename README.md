
# **Baluchon**

  

**Baluchon** est une application iOS conçue pour simplifier les préparatifs de voyage. Elle regroupe trois fonctionnalités principales : taux de change, traduction, et météo, le tout avec une interface moderne et intuitive.

  

## **📝 Description**

  

Baluchon offre des outils essentiels pour les voyageurs :

  

- Convertir rapidement des devises.

- Traduire des phrases entre le français et l’anglais.

- Consulter la météo locale et celle de votre destination.

  

## **📜 Fonctionnalités principales**

  

**1\. Taux de change**

- Convertit une monnaie locale en USD à l’aide de l’API Fixer.io.

- Interface intuitive avec un champ pour sélectionner la devise de départ et celle d’arrivée grâce à un PickerView.

  

**2\. Traduction**

- Traduit des phrases du français vers l’anglais en utilisant l’API Google Translate.

- Possibilité de changer la langue source et la langue cible.

  

**3\. Météo**

- Affiche les prévisions météorologiques actuelles pour Paris et New York à l’aide de l’API OpenWeather.

- Permet de visualiser les éphémérides de plusieurs villes grâce à un UIPageViewController avec des transitions fluides.

  

## **🎨 Design et ergonomie**

- **Responsive Design** : Adapté à toutes les tailles d’écrans iPhone.

- **UI optimisée** : Des animations de couleur et d’image en fonction des conditions météorologiques pour une expérience visuelle immersive.

- **Localisation en temps réel** : Utilisation de CLLocationManager pour afficher la météo de votre emplacement actuel.

  

## **🛠️ Architecture technique**

 **Architecture MVC** :

 - **Modèle** :

	-  Gestion des appels API avec un fichier de services dédié.

	-  Fichiers de parsing pour traiter les données JSON (taux de change, traduction, météo).

	-  Gestion des paramètres (devise, langue, localisation actuelle).

-  **Vue** :

	-  Interfaces distinctes pour chaque fonctionnalité.

	-  Utilisation d’animations et d’effets pour améliorer l’expérience utilisateur.

-  **Contrôleur** :

	- Un contrôleur pour chaque écran (conversion, traduction, météo).

	- Un PageViewController pour afficher plusieurs vues météo.

  

## **🚀 Installation**

1\. Clonez le dépôt GitHub :

  
```bash
git clone https://github.com/GianiGBS/Baluchon.git

cd Baluchon
```

  

2\. Ouvrez le projet dans Xcode.

3\. Lancez l’application sur un simulateur ou un appareil physique compatible.

  

## **✅ Tests**

- **Tests unitaires** : Vérification des fonctionnalités principales (conversion, traduction, météo).

- **Couverture complète** : Toutes les parties critiques du code sont testées pour garantir leur stabilité.

  

## **🎁 Bonus**

1\. **Personnalisation des paramètres** :

- Changer la devise de départ et d’arrivée.

- Modifier la langue source et cible.

2\. **Effets visuels** :

- Transitions fluides entre les éphémérides des villes.

- Animations de couleurs et d’images basées sur la météo.

3\. **Météo locale** :

- Détection automatique de la localisation pour afficher la météo de votre position actuelle.

  

## **🤝 Contribution**

  

Les contributions sont bienvenues ! Si vous avez des idées ou des suggestions, n’hésitez pas à ouvrir une issue ou une pull request.

  

## **📜 Licence**

  

Ce projet est sous licence MIT. Consultez le fichier LICENSE pour plus d’informations.

  

## **🎥 Démonstration**

  

L’application Baluchon permet :

  

1\. De convertir rapidement des devises.

2\. De traduire facilement des phrases entre le français et l’anglais.

3\. De consulter la météo de votre ville et de votre destination avec des animations modernes.

##
