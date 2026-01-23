# ⚡ Quick Deploy to Netlify

## Варіант 1: Через Git (Автоматичний) - RECOMMENDED

### Крок 1: Ініціалізуйте Git

```bash
git init
git add .
git commit -m "Initial commit"
```

### Крок 2: Створіть GitHub репозиторій

1. Перейдіть на https://github.com/new
2. Створіть репозиторій `alias-pro`
3. Виконайте:

```bash
git remote add origin https://github.com/YOUR_USERNAME/alias-pro.git
git branch -M main
git push -u origin main
```

### Крок 3: Підключіть Netlify

1. Перейдіть на https://app.netlify.com/
2. **Add new site** → **Import an existing project**
3. Виберіть GitHub → Авторизуйтесь
4. Виберіть репозиторій `alias-pro`
5. Netlify автоматично знайде `netlify.toml` конфігурацію
6. Натисніть **Deploy site**

✅ Готово! Кожен `git push` автоматично деплоїть нову версію.

---

## Варіант 2: Через Drag & Drop (Найшвидший)

### Крок 1: Збудуйте проект

```bash
# Windows
build.bat

# Linux/Mac
chmod +x build.sh
./build.sh
```

### Крок 2: Перейдіть на Netlify

1. Відкрийте https://app.netlify.com/drop
2. Перетягніть папку `build/web` на сторінку
3. Готово! Сайт опублікований

⚠️ **Недолік**: Деплой потрібно робити вручну при кожній зміні.

---

## Варіант 3: Через Netlify CLI (Для розробників)

### Крок 1: Встановіть Netlify CLI

```bash
npm install -g netlify-cli
```

### Крок 2: Login

```bash
netlify login
```

### Крок 3: Ініціалізація

```bash
netlify init
```

Виберіть:
- **Create & configure a new site**
- Site name: `alias-pro` (або інше)

### Крок 4: Збудуйте і деплойте

```bash
# Build
flutter build web --release --web-renderer canvaskit

# Deploy на production
netlify deploy --prod
```

---

## 🔥 Firebase налаштування

### 1. Authentication

1. Перейдіть у [Firebase Console](https://console.firebase.google.com/)
2. Виберіть проект `alias-pro-a8ddc`
3. **Authentication** → **Sign-in method**
4. Увімкніть **Anonymous**
5. **Settings** → **Authorized domains**
6. Додайте ваш Netlify домен: `your-site-name.netlify.app`

### 2. Firestore Database

1. **Build** → **Firestore Database**
2. **Create database**
3. **Start in test mode** (для розробки)
4. Виберіть регіон: `europe-west1`
5. **Enable**

### 3. Security Rules (Виробництво)

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

---

## 🎯 Перевірка деплою

1. Відкрийте ваш сайт: `https://your-site-name.netlify.app`
2. Перевірте:
   - ✅ Головна сторінка завантажується
   - ✅ Категорії відображаються
   - ✅ Гра запускається
   - ✅ Таймер працює
   - ✅ Результати зберігаються

---

## 🐛 Troubleshooting

### Проблема: Routes показують 404

**Рішення**: Файл `web/_redirects` має бути в build:

```
/*    /index.html   200
```

Перезапустіть build: `flutter build web --release`

### Проблема: Firebase Auth не працює

**Рішення**: Додайте домен в Firebase Console:

1. Authentication → Settings → Authorized domains
2. Add domain: `your-site-name.netlify.app`

### Проблема: Build fails на Netlify

**Рішення**: Перевірте `netlify.toml` версію Flutter:

```toml
[build.environment]
  FLUTTER_VERSION = "3.41.0-1.0.pre-240"
```

---

## ⚙️ Додаткові налаштування

### Custom Domain

1. Netlify Dashboard → **Domain settings**
2. **Add custom domain** → Введіть домен
3. Налаштуйте DNS:

```
A Record:  @  →  75.2.60.5
CNAME:     www → your-site-name.netlify.app
```

4. HTTPS автоматично активується

### GitHub Actions

Workflow вже створений: `.github/workflows/deploy.yml`

Додайте Secrets в GitHub:
1. Settings → Secrets and variables → Actions
2. Додайте:
   - `NETLIFY_AUTH_TOKEN` - отримайте з https://app.netlify.com/user/applications
   - `NETLIFY_SITE_ID` - знайдіть в Site settings → General → Site details

---

## 🚀 Готово!

Ваш Alias Pro додаток тепер в production на Netlify з:

- ✅ CDN по всьому світу
- ✅ Автоматичний HTTPS
- ✅ Continuous Deployment
- ✅ Firebase Auth + Firestore
- ✅ Оптимізовані assets

**Час деплою**: ~2-3 хвилини ⚡

**Live URL**: `https://your-site-name.netlify.app`
