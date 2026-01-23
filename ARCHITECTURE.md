# Architecture Documentation

## Overview

Alias Pro follows **Clean Architecture** principles with a feature-first organization. Each feature is self-contained with clear separation between presentation, domain, and data layers.

## Architecture Layers

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│  (Widgets, Screens, Providers)      │
├─────────────────────────────────────┤
│          Domain Layer               │
│  (Entities, Use Cases, Interfaces)  │
├─────────────────────────────────────┤
│           Data Layer                │
│  (Repositories, Data Sources)       │
└─────────────────────────────────────┘
```

### 1. Presentation Layer

**Responsibility**: UI and user interaction

**Components**:

- **Screens**: Full-page views (HomeScreen, GameScreen, etc.)
- **Widgets**: Reusable UI components (CustomButton, CategoryCard)
- **Providers**: State management using Riverpod

**Example**:

```dart
// Provider
final gameProvider = StateNotifierProvider<GameNotifier, Game?>(
  (ref) => GameNotifier(ref),
);

// Screen
class GameScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    // UI implementation
  }
}
```

### 2. Domain Layer

**Responsibility**: Business logic and entities

**Components**:

- **Entities**: Pure Dart classes (Game, Category, GameResult)
- **Use Cases**: Business operations (optional in MVP)

**Rules**:

- No dependencies on other layers
- Pure Dart code (no Flutter imports)
- Immutable entities
- Strong typing (no `dynamic`)

**Example**:

```dart
class Game {
  final String categoryId;
  final int score;
  final bool isActive;

  const Game({
    required this.categoryId,
    required this.score,
    required this.isActive,
  });

  Game copyWith({int? score}) => Game(
    categoryId: categoryId,
    score: score ?? this.score,
    isActive: isActive,
  );
}
```

### 3. Data Layer

**Responsibility**: Data access and persistence

**Components**:

- **Repositories**: Abstract data access
- **Data Sources**: Concrete implementations
  - Local: SharedPreferences
  - Remote: Firebase (Auth, Firestore)

**Example**:

```dart
// Repository
class CategoryRepository {
  Future<List<Category>> loadCategories() async {
    // Load from JSON asset
  }
}

// Provider
final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(),
);
```

## State Management: Riverpod

### Provider Types Used

1. **Provider**: Immutable dependencies

   ```dart
   final authDatasourceProvider = Provider<FirebaseAuthDatasource>(
     (ref) => FirebaseAuthDatasource(),
   );
   ```

2. **StateNotifierProvider**: Mutable state

   ```dart
   final gameProvider = StateNotifierProvider<GameNotifier, Game?>(
     (ref) => GameNotifier(ref),
   );
   ```

3. **FutureProvider**: Async data loading

   ```dart
   final categoriesProvider = FutureProvider<List<Category>>(
     (ref) async => await ref.read(categoryRepositoryProvider).loadCategories(),
   );
   ```

4. **StreamProvider**: Real-time updates
   ```dart
   final authProvider = StreamProvider<User?>(
     (ref) => ref.watch(authDatasourceProvider).authStateChanges,
   );
   ```

### State Flow Example: Game Play

```
User Action (button press)
    ↓
Widget Event Handler
    ↓
Provider Notifier Method
    ↓
State Update
    ↓
Consumer Widget Rebuild
    ↓
UI Update
```

## Navigation: GoRouter

**Declarative routing** with type-safe navigation:

```dart
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/game/:categoryId',
        name: 'game',
        builder: (context, state) {
          final categoryId = state.pathParameters['categoryId']!;
          return GameScreen(categoryId: categoryId);
        },
      ),
    ],
  );
});
```

**Navigation Usage**:

```dart
// Navigate to game
context.go('/game/animals');

// Navigate back
context.go('/');
```

## Data Flow

### Game Flow Diagram

```
┌──────────────┐
│ User selects │
│  Category    │
└──────┬───────┘
       ↓
┌──────────────────────┐
│ CategoryRepository   │
│ loads words          │
└──────┬───────────────┘
       ↓
┌──────────────────────┐
│ GameNotifier         │
│ initializes game     │
└──────┬───────────────┘
       ↓
┌──────────────────────┐
│ TimerNotifier        │
│ starts countdown     │
└──────┬───────────────┘
       ↓
┌──────────────────────┐
│ User guesses/skips   │
└──────┬───────────────┘
       ↓
┌──────────────────────┐
│ Score updated        │
│ Next word shown      │
└──────┬───────────────┘
       ↓
┌──────────────────────┐
│ Time ends            │
│ → Result Screen      │
└──────┬───────────────┘
       ↓
┌──────────────────────┐
│ LocalStorage saves   │
│ GameResult           │
└──────────────────────┘
```

## Dependency Injection

**Riverpod serves as DI container**:

```dart
// Define dependency
final localStorageProvider = Provider<LocalStorageDatasource>(
  (ref) => LocalStorageDatasource(),
);

// Inject dependency
class GameNotifier extends StateNotifier<Game?> {
  GameNotifier(this._ref) : super(null);

  final Ref _ref;

  void saveResult() {
    final storage = _ref.read(localStorageProvider);
    storage.saveGameResult(/* ... */);
  }
}
```

## Testing Strategy

### Unit Tests

- Test domain entities
- Test business logic in notifiers
- Mock dependencies using Riverpod override

```dart
void main() {
  test('Game increases score on correct guess', () {
    final game = Game.initial(/* ... */);
    final updated = game.copyWith(
      score: game.score + 1,
    );
    expect(updated.score, 1);
  });
}
```

### Widget Tests (Future)

```dart
testWidgets('GameScreen shows timer', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(home: GameScreen()),
    ),
  );
  expect(find.text('01:30'), findsOneWidget);
});
```

## Performance Considerations

### Provider Optimization

- Use `.autoDispose` for temporary state
- Use `.family` for parameterized providers
- Minimize provider rebuilds with `select`

### Memory Management

- Timer disposal in `TimerNotifier`
- Stream subscription cleanup
- Asset caching

### Build Optimization

- `const` constructors everywhere
- `ListView.builder` for lists
- Separate stateful/stateless widgets

## Security

### Firebase Rules

```javascript
// Firestore Security Rules
match /users/{userId} {
  allow read: if request.auth != null;
  allow write: if request.auth.uid == userId;
}
```

### Data Validation

- Input sanitization in providers
- Type checking with null safety
- Score bounds enforcement

## Future Architecture Enhancements

### Sprint 2+

- **Use Cases Layer**: Extract complex business logic
- **DTOs**: Separate data models from domain entities
- **Error Handling**: Custom exception hierarchy
- **Logging**: Structured logging service
- **Analytics**: Event tracking layer

### Scalability

- **Modular Features**: Extract features to packages
- **Code Generation**: freezed for immutability
- **API Layer**: Abstract backend communication
- **Offline-First**: Sync queue for Firebase operations
