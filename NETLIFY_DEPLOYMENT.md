# 🚀 Netlify Deployment Guide

## Автоматичний деплой через Git

### 1. Підготовка репозиторію

```bash
git init
git add .
git commit -m "Initial commit: Alias Pro Flutter game"
```

### 2. Створення GitHub репозиторію

1. Створіть новий репозиторій на [GitHub](https://github.com/new)
2. Виконайте команди:

```bash
git remote add origin https://github.com/YOUR_USERNAME/alias-pro.git
git branch -M main
git push -u origin main
```

### 3. Налаштування Netlify

1. Перейдіть на [Netlify](https://app.netlify.com/)
2. Натисніть **"Add new site"** → **"Import an existing project"**
3. Виберіть **GitHub** і авторизуйтесь
4. Виберіть репозиторій `alias-pro`
5. Налаштування збірки:
   - **Build command**: `flutter/bin/flutter build web --release --web-renderer canvaskit`
   - **Publish directory**: `build/web`
   - **Base directory**: (залиште порожнім)

### 4. Встановлення Flutter на Netlify Build

Netlify автоматично використає `netlify.toml` конфігурацію з проекту.

**Альтернативний спосіб** (якщо netlify.toml не працює):

Додайте **Build Image** в Netlify UI:
- Site settings → Build & deploy → Build settings
- Build image: `Ubuntu Focal 20.04`

Створіть файл `.nvmrc` в корені проекту:
```
lts/*
```

### 5. Environment Variables (Firebase)

У Netlify Dashboard → Site settings → Build & deploy → Environment variables додайте:

```
FLUTTER_WEB=true
```

**Важливо**: Firebase конфігурація вже включена в `lib/firebase_options.dart`, тому додаткові змінні середовища не потрібні.

### 6. Firebase Authentication налаштування

1. Перейдіть у [Firebase Console](https://console.firebase.google.com/)
2. Виберіть проект `alias-pro-a8ddc`
3. Authentication → Sign-in method → Anonymous → **Enable**
4. Authentication → Settings → Authorized domains
5. Додайте ваш Netlify домен: `your-site-name.netlify.app`

### 7. Deploy

Після push коду в GitHub:

```bash
git add .
git commit -m "Add feature"
git push
```

Netlify автоматично зробить деплой!

---

## Ручний деплой через Netlify CLI

### 1. Встановлення Netlify CLI

```bash
npm install -g netlify-cli
```

### 2. Збірка проекту

```bash
flutter build web --release --web-renderer canvaskit
```

### 3. Login в Netlify

```bash
netlify login
```

### 4. Ініціалізація сайту

```bash
netlify init
```

Виберіть:
- **Create & configure a new site**
- Team: (ваша команда)
- Site name: `alias-pro` (або інше)

### 5. Деплой

**Preview deploy**:
```bash
netlify deploy
```

**Production deploy**:
```bash
netlify deploy --prod
```

---

## Налаштування Custom Domain

1. Netlify Dashboard → Domain settings → Add custom domain
2. Введіть ваш домен (наприклад, `alias-game.com`)
3. Налаштуйте DNS записи:

```
A Record:  @  →  75.2.60.5
CNAME:     www → your-site-name.netlify.app
```

4. Увімкніть **HTTPS/SSL Certificate** (автоматично через Let's Encrypt)

---

## Firebase Security Rules

### Firestore Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### Firebase Hosting (опціонально)

Якщо хочете використати Firebase Hosting замість Netlify:

```bash
firebase init hosting
flutter build web --release
firebase deploy --only hosting
```

---

## Моніторинг та оптимізація

### Lighthouse Score

Перевірте продуктивність на Netlify:
- Deploy → Deploy details → **Lighthouse score**

### Аналітика

Налаштуйте Google Analytics в Firebase:
1. Firebase Console → Analytics → Enable
2. Додайте код у `web/index.html`

---

## Troubleshooting

### Проблема: Build fails

**Рішення**: Перевірте версію Flutter в `netlify.toml`:
```toml
[build.environment]
  FLUTTER_VERSION = "3.41.0-1.0.pre-240"
```

### Проблема: Routes не працюють (404)

**Рішення**: Перевірте файл `web/_redirects`:
```
/*    /index.html   200
```

### Проблема: Firebase Auth не працює

**Рішення**: Додайте домен в Firebase Console:
- Authentication → Settings → Authorized domains → Add domain

---

## Корисні команди

```bash
# Локальна збірка
flutter build web --release

# Preview в локальному браузері
cd build/web && python -m http.server 8000

# Netlify dev server
netlify dev

# Перевірка статусу деплою
netlify status

# Відкрити сайт
netlify open:site
```

---

## Успішний деплой! 🎉

Ваш Alias Pro додаток готовий до продакшн використання на Netlify з автоматичними деплоями, HTTPS, CDN та глобальним розповсюдженням.

**Сайт доступний за адресою**: `https://your-site-name.netlify.app`
