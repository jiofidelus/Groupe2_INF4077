# TP INFO4077
## Description


# Contributors

NOM ET PRENOM |        MATRICULE
--------------|---------------------
NGUEJIP MUKETE YVES JORDAN       | 17Q2742
Kitio Azanfack Sage Excelle      | 15T2364
BIME MOUEGUE ESDRAS JOEL         | 14R2110
NJOUONKOU NKANJONE MAXIME ANICET | 17Q2772

# Description de l'application
EPI-CORON est une application de surveillance de la nouvelle maladie a CORONA VIRUS (COVID 19)
Elle permet grace a une interface intuitive d'avoir assez d'information sur la maladie, ainsi
il est plus facile pour un professionnel de santé d'etre assisté dans ses consultations.

EPI-CORON fonctionne grace a une base de données des symptomes connues, et le diagnostique se fait 
a partir de la frequence observé dans les cas.

EPI-CORON peut generer un ensemble de questionnaire qui va faciliter la consulation et generer un
resultat qui peut etre verifié par un medecin

EPI-CORON conserve les statistique sur des serveur Rapide basé en Allemagne, Fais avec les technologies
- Golang
- NodeJS (Express)

EPI-CORON est dévélopper en plusieur version
- Android (avec Java)
- Flutter (avec Dart)
- Web (Avec Vue JS et IONIC)


## Capture d'ecran
TODO: Ajouter les capture d'ecrans

## Generateur d'application de surveillance
Un generateur d'application a aussi été mis a la disposible de nos utilisateur.
Ce genertateur permet de generer des application FLUTTER pour surveiller les maladies que vous auriez defini sur la page web du generateur

### Comment sa fonction
Le generateur est basé sur les modéle de la maladie et les symptome, dés que vous avez enregistré votre maladie et ses symptome connues, plusieur fichier JSON sont crées selon vos définition.

Puis ses fichiers sont recuperer par un backend qui va les utiliser pour generer un application

Les données de votre application vont communiquer avec une base de données

#### NB: Afin de pouvoir mettre a jour votre application vous devez avoir un numero particulier qui va identifier votre application

### Technologie derriere le generateur
- NodeJS: Initialement, le generateur etais conçu en GoLang, mais du au contrainte de temps, nous somme aller sur un langage beaucoup moins exigent et nous avons adopter NODEJS et Express

- React JS: L'interface web du generateur a été fais avec REACT JS

- MongoDB: La base de données des application sont stocker dans un cluster MONGO DB

# Fonctionnalité
- Ajout des patients
- Consultation des patients
- Informations sur la maladie
- Statistique sur les consultations
- Envoies des SMS
- Utilisation du GPS pour recuperer la position
- Capture des images du patients
- Enregistrement de la voix du patients

# Comment installer
- Clonner le projet
- `cd web-mobile`
- `npm install -g @ionic/cli`
- `npm install -g mapbox-gl`
- `npm install`
- `ionic serve`

# Comment Contribuer

- Fork le projet
- Ajoutez la/les contribution(s)
- Faire un pull request
