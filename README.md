# projetI4 : Snake

Réalisation d'un projet de création du jeu snake dans le cadre du cours de I4-2 à l'INSA Rouen Normandie. 

Ce projet se divise en 2 parties. Une partie dédiée à l'algorithmique et la programmation en langage Pascal et une autre à l'écriture du rapport en Latex. 

## Auteurs
Kévin Gatel, Julien Gavaud, Hengshuo LI, Simon Morin, Yizhe Wang, Théo Willekens


## Description du projet 
Ce projet se base sur le principe du jeu connu de tous : le snake. 
Le joueur déplace un serpent qui évolu au sein d'une map finie délimitée par des murs. 
Des pommes apparaissent sur la map et le joueur doit déplacer le serpent de telle sorte que celui-ci puisse "les manger" en passant dessus. 
A chaque pomme mangée le serpent grandit et les points du joueurs sont incrémentés. Le but du jeu étant d'obtenir le plus de points possible.
Si le serpent touche un mur ou son propre corps celui-ci meurt et la partie s'arrête. 
En plus de cela des pots de fleurs apparaissent au fur et à mesure sur la map. Si le serpent se cogne dans un pot de fleur celui-ci rétrécit et le joueur perd des points. 
Dans le cas ou le serpent se cogne dans plus de pots de fleurs qu'il n'a de point de vie alors la partie s'arrête.

## Installation

### Free Pascal Compiler (fpc)
Le code source du jeu est en Pascal et SDL. Pour l'étudier, le compléter et lancer la compilation le logiciel Geany peut être utilisé. Pour compiler le code, le compilateur Free Pascal Compiler version 3.0.4 (ou ultérieur) doit être installé sur votre machine. Vous trouverez les indications nécessaires pour l'installation sur la page suivante: https://doc.ubuntu-fr.org/fpc (sous la distibution Ubuntu).
Pour plus d'information vous pouvez vous rendre sur le wiki de Free Pascal à l'adresse suivante : https://wiki.freepascal.org/FPC_and_SDL

Pour pouvoir compiler la SDL avec Free Pascal Compiler il vous faudra télécharger le paquet SDL1.2 à l'adresse suivante : https://www.libsdl.org/download-1.2.php

### Note
Si vous souhaitez compiler le code Pascal sous Windows il vous faudra changer les adresses des fichiers textes contenues au sein du code source: Les "/" devront être remplacer par des "\".

### LaTeX
Le rapport est lui codé en Latex. Pour l'étudier, le compléter et lancer la compilation le logiciel Kile peut être utilisé. Il faudra préalablement installer la librairie Latex se trouvant à l'adresse suivante: https://doc.ubuntu-fr.org/latex (sous la distibution Ubuntu). 


## License
[MIT](https://choosealicense.com/licenses/mit/)
