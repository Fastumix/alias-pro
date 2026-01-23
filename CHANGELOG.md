# Changelog

All notable changes to the Alias Pro project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-23

### Added (MVP Sprint 1)
- 🎮 Core game mechanics with 90-second timer
- 📚 5 categories with 50 words each (250 total words)
  - 🦁 Animals
  - 🎬 Movies
  - ⚽ Sport
  - 🍕 Food
  - 👑 Historical Figures
- 🏆 Scoring system (+1 correct, -1 skip, minimum 0)
- 💾 Local storage for game records (SharedPreferences)
- 🔥 Firebase Anonymous Authentication
- 📊 Profile screen with statistics
- 🎨 Light and Dark theme support
- 📱 5 screens navigation flow (Home → Categories → Game → Result → Profile)

### Technical
- ✅ Clean Architecture implementation
- ✅ Riverpod state management
- ✅ GoRouter navigation
- ✅ Null safety everywhere
- ✅ Unit tests for domain entities
- ✅ Production-ready code structure
- ✅ Firebase integration (Auth + Firestore)

### Architecture
- Features-first folder structure
- Separation of concerns (presentation/domain/data)
- Provider-based dependency injection
- Repository pattern for data access

### Testing
- Unit tests for Game entity
- Unit tests for Category entity
- Unit tests for GameResult entity
- Test coverage for scoring logic

## [Unreleased]

### Planned for Sprint 2
- Online leaderboard
- Custom nicknames
- Avatar support
- Enhanced statistics

### Planned for Sprint 3
- Additional categories
- Custom category creation
- Word management

### Planned for Sprint 4
- Multiplayer mode
- Real-time game sessions

### Planned for Sprint 5
- AI word generation
- Smart difficulty adjustment
