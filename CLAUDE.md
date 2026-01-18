# Barcode - Simulateur de caissier/caissière

Jeu 3D Godot 4.5 où le joueur incarne un caissier de supermarché. Il ne peut pas bouger mais peut tourner la tête. Les articles arrivent sur un tapis roulant et doivent être scannés en orientant le code-barre vers le lecteur.

## Structure du projet

```
scenes/
├── main.tscn              # Scène principale (caisse, tapis, scanner, UI)
└── items/
    └── grocery_item.tscn  # Article scannable (RigidBody3D)

scripts/
├── game_manager.gd        # Logique du jeu (spawn, grab, scan)
├── player.gd              # Caméra première personne (rotation souris)
├── grocery_item.gd        # Comportement des articles + détection tapis
└── beep_generator.gd      # Génération procédurale du son de bip
```

## Gameplay

- **Position joueur** : z=-1.6, face au comptoir (z=-0.8)
- **Tapis roulant** : x=-1.5, articles avancent de gauche à droite (x+)
- **Scanner** : Sur le comptoir, zone de détection verte, laser rouge

## Contrôles

- **Souris** : Regarder autour
- **Clic gauche** : Prendre/lâcher un objet
- **Q/E/R** : Tourner l'objet (axes X/Y/Z)
- **Molette** : Tourner l'objet (axe X)
- **Échap** : Libérer/capturer la souris

## Points techniques importants

1. **Collision des objets tenus** : `collision_layer = 0` quand tenu, donc la détection du scan se fait en continu dans `_physics_process` (pas via Area3D signal)

2. **Détection tapis roulant** : Vérification position (X, Y, Z) dans `grocery_item.gd` - les objets ne bougent que s'ils sont sur le tapis (Y >= 0.8)

3. **Scan d'article** :
   - Distance à la zone scanner <= 0.25
   - Code-barre doit faire face au scanner (dot product > 0.3)
   - Son de bip généré programmatiquement (1000Hz, 0.15s)

4. **CSGBox3D** : `use_collision = true` nécessaire pour les collisions physiques

## Éléments visuels

- Viseur "+" blanc au centre de l'écran
- Zone de détection : cube vert semi-transparent
- Laser : ligne rouge sur le scanner
- Code-barre : partie blanche sur les articles

## À faire (idées futures)

- Interface de score
- Différents types d'articles
- File de clients
- Système de difficulté progressive
