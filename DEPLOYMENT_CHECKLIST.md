# 📋 Netlify Deployment Checklist

## Pre-Deploy Чекліст

### 1. Код готовий

- [ ] Всі тести проходять: `flutter test`
- [ ] Немає помилок аналізу: `flutter analyze`
- [ ] Код збирається локально: `flutter build web --release`
- [ ] Перевірено на різних розмірах екрану

### 2. Firebase налаштований

- [ ] Проект створений в Firebase Console
- [ ] Anonymous Auth увімкнений
- [ ] Firestore Database створений
- [ ] `firebase_options.dart` згенерований
- [ ] Web платформа додана: `flutterfire configure --platforms=web`

### 3. Git готовий

- [ ] `.gitignore` налаштований (firebase_options.dart НЕ ігнорується)
- [ ] Код закоммічений: `git add . && git commit -m "Ready for deploy"`
- [ ] Remote репозиторій створений на GitHub
- [ ] Код запушений: `git push origin main`

### 4. Netlify конфігурація

- [ ] `netlify.toml` створений
- [ ] `web/_redirects` файл існує
- [ ] Build script працює: `build.bat` або `build.sh`

---

## Deployment Process

### Варіант A: GitHub + Netlify (Auto-Deploy)

1. [ ] Створити GitHub репозиторій
2. [ ] Push код на GitHub
3. [ ] Створити новий сайт на Netlify
4. [ ] Підключити GitHub репозиторій
5. [ ] Netlify автоматично знайде `netlify.toml`
6. [ ] Перший деплой запускається автоматично
7. [ ] Перевірити деплой на тестовому URL
8. [ ] Додати Netlify домен в Firebase Authorized domains

### Варіант B: Netlify CLI (Manual)

1. [ ] Встановити: `npm install -g netlify-cli`
2. [ ] Login: `netlify login`
3. [ ] Build: `flutter build web --release --web-renderer canvaskit`
4. [ ] Deploy: `netlify deploy --prod`
5. [ ] Додати домен в Firebase Authorized domains

### Варіант C: Drag & Drop (Найшвидший)

1. [ ] Build: `flutter build web --release`
2. [ ] Відкрити: https://app.netlify.com/drop
3. [ ] Перетягнути папку `build/web`
4. [ ] Додати домен в Firebase Authorized domains

---

## Post-Deploy Перевірка

### Функціональність

- [ ] Сайт відкривається: `https://your-site.netlify.app`
- [ ] Головна сторінка завантажується без помилок
- [ ] Всі 5 категорій відображаються
- [ ] Можна вибрати категорію
- [ ] Гра запускається
- [ ] Таймер працює (90 секунд)
- [ ] Слова відображаються українською
- [ ] Кнопки "Вгадав" / "Пропустити" працюють
- [ ] Підрахунок очків коректний (+1 / -1)
- [ ] Екран результатів відображається
- [ ] Статистика зберігається
- [ ] Профіль відображає рекорди

### Firebase Integration

- [ ] Firebase ініціалізується без помилок (перевірити Console)
- [ ] Anonymous Auth працює (користувач автоматично логіниться)
- [ ] Firestore підключення активне
- [ ] Дані зберігаються в Firestore (перевірити Firebase Console)

### Routing

- [ ] Прямі посилання працюють (наприклад, `/categories`)
- [ ] Кнопка "Назад" в браузері працює
- [ ] Deep links працюють
- [ ] 404 сторінка не показується (через `_redirects`)

### Performance

- [ ] Сторінка завантажується < 3 секунд
- [ ] Немає помилок в Console (F12)
- [ ] Assets (fonts, images) завантажуються
- [ ] Немає CORS помилок
- [ ] Firebase підключення стабільне

### Mobile Testing

- [ ] Відкрити на телефоні
- [ ] Responsive дизайн працює
- [ ] Тачі працюють
- [ ] Анімації плавні
- [ ] Немає горизонтального скролу

---

## Firebase Security (Production)

### 1. Authentication Rules

- [ ] Anonymous auth працює
- [ ] Authorized domains включають Netlify домен

### 2. Firestore Security Rules

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

- [ ] Rules оновлені в Firebase Console
- [ ] Тестові read/write працюють
- [ ] Чужі дані недоступні (security)

### 3. Firebase Quota

- [ ] Перевірити Firebase usage
- [ ] Налаштувати alerts на квоти
- [ ] Spark Plan достатній для MVP

---

## Continuous Deployment

### GitHub Actions (Optional)

- [ ] `.github/workflows/deploy.yml` створений
- [ ] `NETLIFY_AUTH_TOKEN` додано в GitHub Secrets
- [ ] `NETLIFY_SITE_ID` додано в GitHub Secrets
- [ ] Тестовий push запускає деплой
- [ ] Деплой успішний

### Auto-Deploy налаштування

- [ ] Netlify підключений до GitHub
- [ ] Auto-deploy увімкнений для `main` branch
- [ ] Build notifications налаштовані (email/Slack)

---

## Monitoring & Analytics

### Netlify Analytics

- [ ] Analytics увімкнений в Netlify Dashboard
- [ ] Bandwidth usage моніториться
- [ ] Deploy status notifications активні

### Error Tracking (Optional)

- [ ] Sentry або Firebase Crashlytics налаштований
- [ ] Error logs доступні

### Performance Monitoring

- [ ] Lighthouse score > 90
- [ ] Core Web Vitals в зеленій зоні
- [ ] Firebase Performance Monitoring активний

---

## Custom Domain (Optional)

- [ ] Домен куплений
- [ ] DNS записи налаштовані:
  - `A Record: @ → 75.2.60.5`
  - `CNAME: www → your-site.netlify.app`
- [ ] HTTPS/SSL сертифікат активний (автоматично)
- [ ] Домен додано в Firebase Authorized domains
- [ ] Редірект з www на non-www (або навпаки)

---

## Documentation

- [ ] `README.md` оновлений з Live Demo URL
- [ ] `NETLIFY_DEPLOYMENT.md` актуальний
- [ ] `QUICK_DEPLOY.md` протестований
- [ ] Badges в README оновлені (Netlify status, Flutter version)

---

## Final Check

- [ ] Додаток працює на production URL
- [ ] Всі фічі MVP реалізовані та працюють
- [ ] Firebase не показує помилок
- [ ] Netlify deploys успішні
- [ ] Код на GitHub актуальний
- [ ] Документація повна

---

## 🎉 Deploy Complete!

✅ Ваш Alias Pro додаток в production!

**Live URL**: `https://your-site-name.netlify.app`

**Next Steps**:
- Поділитись посиланням
- Зібрати feedback від користувачів
- Моніторити Firebase usage
- Планувати Sprint 2

---

**Deployment Date**: _____________

**Deployed by**: _____________

**Production URL**: _____________

**Notes**: _____________
