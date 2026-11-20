# Hew-a 🍳

Tinder-style recipe discovery app. Swipe through menus, save the ones you like, and find dishes you can cook with what is already in your fridge.

Third-year university project, team (2022).

> Archived. Code is kept as it was submitted; only this README was rewritten later for clarity.

## Features
- Swipe feed of recipes, like / skip
- Virtual fridge: add ingredients, get menus that match
- Allergy filter
- Post your own recipe with photos, steps and ingredients
- Comments, likes and follows
- Personalized picks from an item-based recommender

## Tech
| Part | Stack |
|---|---|
| App | Flutter (Dart), GetX, Dio |
| Backend | Firebase Auth, Firebase Storage, SQLite |
| Recommender | Python, Flask, pandas, scikit-learn (cosine similarity, item-item) |

## Run
```bash
flutter pub get
flutter run
```
Recommender service:
```bash
cd lib/recommendation
pip install flask pandas numpy scipy scikit-learn
python app.py
```
