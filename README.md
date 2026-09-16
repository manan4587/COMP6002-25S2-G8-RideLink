# RideLink Full Working Code: Flutter + Backend + Firebase + Mapbox

Folders:
- `backend` = Node.js Express API with Firebase Admin token verification and Mapbox Geocoding/Directions.
- `frontend_flutter` = Flutter app connected to backend APIs.

## Run backend
```bat
cd backend
npm install
copy .env.example .env
npm run dev
```
Test: `http://localhost:5000/api/v1/health`

## Run frontend on Chrome
```bat
cd frontend_flutter
flutter pub get
flutter run -d chrome
```

## Add Mapbox
Open `backend/.env` and add:
```env
MAPBOX_ACCESS_TOKEN=your_token_here
```
Test:
`http://localhost:5000/api/v1/mapbox/route?start=Landsdale WA&destination=Curtin University WA`

## Add Firebase Auth
Backend: put Firebase Admin service account values in `backend/.env`.
Frontend: replace placeholders in `frontend_flutter/lib/firebase_options.dart` or run `flutterfire configure`.
Then run:
```bat
flutter run -d chrome --dart-define=USE_FIREBASE_AUTH=true
```
When real Firebase is ready, set in backend `.env`:
```env
DEV_ALLOW_NO_AUTH=false
```

## Seats Needed feature
The app supports one passenger requesting multiple seats from one location:
`Manan + 1 passenger`, `Seats Needed: 2`.

## Note
This is a full runnable university prototype. It uses in-memory data so it runs immediately. A PostgreSQL + PostGIS production schema is included in `backend/database/schema.sql`.
