# 🚀 Швидкий старт без Firebase

## Запуск додатку БЕЗ налаштування Firebase

Ви можете запустити додаток відразу на Windows без Firebase:

### 1. Запуск на Windows

```powershell
cd C:\Users\pc\Apps\alias-pro
..\flutter\bin\flutter run -d windows
```

### 2. Що працює БЕЗ Firebase:

✅ **Повний ігровий процес**
- Вибір категорії
- Гра з таймером
- Підрахунок балів
- Результати

✅ **Локальне збереження**
- Рекорди зберігаються локально
- Статистика по категоріях
- Профіль користувача

❌ **Не працює БЕЗ Firebase:**
- Онлайн авторизація (використовується anonymous auth)
- Синхронізація між пристроями

### 3. Тимчасове відключення Firebase

Для запуску без Firebase, закоментуйте Firebase ініціалізацію:

**lib/main.dart:**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();  // <-- закоментуйте цей рядок
  
  runApp(
    const ProviderScope(
      child: AliasProApp(),
    ),
  );
}
```

**lib/config/routes.dart:**
```dart
redirect: (context, state) async {
  // Закоментуйте Firebase auth
  // final authState = ref.read(authProvider);
  // if (authState.value == null) {
  //   await ref.read(authNotifierProvider).signInAnonymously();
  // }
  
  return null;
},
```

### 4. Запуск

```powershell
..\flutter\bin\flutter run -d windows
```

---

## Налаштування Firebase (опціонально)

Якщо хочете повну функціональність, дотримуйтесь [FIREBASE_SETUP.md](FIREBASE_SETUP.md)

### Швидкий спосіб:

1. **Створіть Firebase проект**: https://console.firebase.google.com/
2. **Увімкніть Anonymous Auth**: Authentication → Sign-in method → Anonymous
3. **Створіть Firestore**: Firestore Database → Create database
4. **Додайте Windows app** у Firebase Console
5. **Скопіюйте конфігурацію** у `lib/firebase_options.dart`

---

## Альтернатива: Mock Firebase

Можна створити mock providers для розробки:

```dart
// lib/config/mock_firebase.dart
class MockFirebaseAuth {
  static Future<void> initialize() async {
    print('🔥 Mock Firebase initialized');
  }
}
```

**Переваги локального режиму:**
- ✅ Швидкий старт
- ✅ Не потрібен інтернет
- ✅ Всі дані локально
- ✅ Повна приватність

**Коли потрібен Firebase:**
- Синхронізація між пристроями
- Онлайн лідерборди
- Бекап даних у хмарі
