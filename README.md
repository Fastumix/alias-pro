# Alias Pro - Flutter MVP

Production-ready Alias гра на Flutter з Clean Architecture, Riverpod та Firebase.

## 🎯 Функціональність MVP

- ✅ 5 категорій × 50 слів = 250 слів
- ✅ Solo режим з таймером 90 секунд
- ✅ +1 за вгадане слово, -1 за пропуск
- ✅ Локальні рекорди (SharedPreferences)
- ✅ Firebase Auth (анонімна) + Firestore
- ✅ 5 екранів: Home → Categories → Game → Result → Profile

## 🏗 Архітектура

```
lib/
├── features/
│   ├── auth/                    # Firebase Anonymous Auth
│   │   ├── data/
│   │   │   └── datasources/
│   │   │       └── firebase_auth_datasource.dart
│   │   └── presentation/
│   │       └── providers/
│   │           └── auth_provider.dart
│   │
│   ├── game/                    # Ігрова логіка
│   │   ├── domain/
│   │   │   └── entities/
│   │   │       ├── category.dart
│   │   │       ├── game.dart
│   │   │       └── game_result.dart
│   │   ├── data/
│   │   │   └── repositories/
│   │   │       └── category_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── game_provider.dart
│   │       │   └── timer_provider.dart
│   │       └── screens/
│   │           ├── home_screen.dart
│   │           ├── categories_screen.dart
│   │           ├── game_screen.dart
│   │           └── result_screen.dart
│   │
│   └── profile/                 # Профіль і статистика
│       ├── data/
│       │   ├── datasources/
│       │   │   └── local_storage_datasource.dart
│       │   └── repositories/
│       │       └── user_repository.dart
│       └── presentation/
│           ├── providers/
│           │   └── profile_provider.dart
│           └── screens/
│               └── profile_screen.dart
│
├── shared/                      # Спільні компоненти
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   └── colors.dart
│   └── widgets/
│       ├── custom_button.dart
│       └── category_card.dart
│
├── config/                      # Конфігурація
│   ├── routes.dart
│   └── constants.dart
│
└── main.dart
```

## 📦 Залежності

```yaml
dependencies:
  flutter_riverpod: ^2.4.10      # State Management
  firebase_core: ^2.24.0          # Firebase Core
  firebase_auth: ^4.14.0          # Authentication
  cloud_firestore: ^4.14.0        # Database
  go_router: ^12.0.0              # Navigation
  shared_preferences: ^2.2.2      # Local Storage
```

## 🚀 Встановлення

### 1. Клонуйте репозиторій
```bash
git clone <repository-url>
cd alias-pro
```

### 2. Встановіть залежності
```bash
flutter pub get
```

### 3. Налаштуйте Firebase

#### iOS
1. Створіть проект у [Firebase Console](https://console.firebase.google.com/)
2. Додайте iOS app
3. Завантажте `GoogleService-Info.plist`
4. Помістіть у `ios/Runner/`

#### Android
1. У Firebase Console додайте Android app
2. Завантажте `google-services.json`
3. Помістіть у `android/app/`

### 4. Запустіть додаток
```bash
flutter run
```

## 🧪 Тестування

```bash
# Запустити всі unit тести
flutter test

# Запустити конкретний тест
flutter test test/game_entity_test.dart

# З покриттям коду
flutter test --coverage
```

## 🎮 Ігрова логіка

### Правила
- **Тривалість**: 90 секунд
- **Вгадано**: +1 бал
- **Пропуск**: -1 бал (мінімум 0)
- **Перемога**: максимум балів за час

### Екрани Flow
```
Home Screen
    ↓
Categories Screen (5 категорій)
    ↓
Game Screen (таймер + слово + кнопки)
    ↓
Result Screen (статистика)
```

## 🎨 Теми

Додаток підтримує світлу та темну теми з автоматичним перемиканням на основі системних налаштувань.

## 📊 State Management

### Riverpod Providers

**Game Providers:**
- `gameProvider` - поточна гра (StateNotifierProvider)
- `timerProvider` - таймер (StateNotifierProvider)
- `categoriesProvider` - список категорій (FutureProvider)
- `categoryByIdProvider` - категорія за ID (FutureProvider.family)

**Auth Providers:**
- `authProvider` - статус авторизації (StreamProvider)
- `authNotifierProvider` - дії авторизації (Provider)

**Profile Providers:**
- `totalGamesProvider` - загальна кількість ігор (FutureProvider)
- `bestScoreProvider` - кращий рахунок (FutureProvider)
- `categoryStatsProvider` - статистика по категоріях (FutureProvider)

## 🔥 Firebase Structure

### Firestore
```
users/
  {userId}/
    ├── uid: string
    ├── nickname: string (optional)
    ├── totalGames: number
    ├── bestScores: map
    │   ├── animals: number
    │   ├── movies: number
    │   └── ...
    └── lastUpdated: timestamp
```

### Authentication
- Анонімна авторизація (Firebase Anonymous Auth)
- Автоматичний вхід при запуску

## 📱 Підтримувані платформи

- ✅ iOS 12.0+
- ✅ Android 5.0+ (API 21+)
- ✅ Web (beta)

## 🛠 Технічний стек

- **Flutter**: 3.2.0+
- **Dart**: 3.2.0+
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Backend**: Firebase (Auth + Firestore)
- **Local Storage**: SharedPreferences
- **Architecture**: Clean Architecture

## 📝 Заборонені технології (MVP)

- ❌ OpenAI API (Sprint 5)
- ❌ Multiplayer (Sprint 4)
- ❌ In-app purchases (Sprint 7)
- ❌ GetX/Bloc/Redux
- ❌ Navigator 1.0
- ❌ dynamic типи

## 🎯 Roadmap

### Sprint 1 (MVP) ✅
- Solo режим
- 5 категорій
- Локальні рекорди
- Firebase Auth

### Sprint 2 (Planned)
- Онлайн рекорди
- Нікнейми
- Аватари

### Sprint 3 (Planned)
- Більше категорій
- Кастомні категорії

### Sprint 4 (Planned)
- Multiplayer режим

### Sprint 5 (Planned)
- AI генерація слів

## 📄 Ліцензія

MIT License

## 👨‍💻 Автор

Senior Flutter Developer з 10+ років досвіду

---

**Версія**: 1.0.0 (MVP Edition)
**Дата**: January 2026
