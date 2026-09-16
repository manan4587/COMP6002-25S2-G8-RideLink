# Windows Run Commands

Open two terminals.

## Terminal 1 Backend
```bat
cd backend
npm install
copy .env.example .env
npm run dev
```

## Terminal 2 Flutter
```bat
cd frontend_flutter
flutter pub get
flutter run -d chrome
```

## With Firebase enabled
```bat
flutter run -d chrome --dart-define=USE_FIREBASE_AUTH=true
```

## Android emulator API URL later
```bat
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5000/api/v1
```
