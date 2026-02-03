import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Налаштування'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsSection(
            title: 'Профіль',
            icon: Icons.person,
            children: [
              _SettingsTile(
                title: "Ім'я та Аватар",
                subtitle: 'Редагувати профіль',
                icon: Icons.badge,
                onTap: () => context.push('/settings/profile'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: 'Додаток',
            icon: Icons.settings,
            children: [
              _SettingsTile(
                title: 'Мова',
                subtitle: 'Українська',
                icon: Icons.language,
                onTap: () => context.push('/settings/language'),
              ),
              _SettingsTile(
                title: 'Як грати',
                subtitle: 'Правила та інструкції',
                icon: Icons.help_outline,
                onTap: () => context.push('/settings/how-to-play'),
              ),
              _SettingsTile(
                title: 'Промо відео',
                subtitle: 'Подивитись туторіал',
                icon: Icons.play_circle_outline,
                onTap: () => context.push('/settings/promo-video'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: 'Магазин',
            icon: Icons.shopping_bag,
            children: [
              _SettingsTile(
                title: 'Купити монети',
                subtitle: 'Отримати більше можливостей',
                icon: Icons.monetization_on,
                onTap: () => context.push('/settings/buy-coins'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: 'Інше',
            icon: Icons.more_horiz,
            children: [
              _SettingsTile(
                title: 'Про додаток',
                subtitle: 'Версія 1.0.0',
                icon: Icons.info_outline,
                onTap: () => _showAboutDialog(context),
              ),
              _SettingsTile(
                title: 'Політика конфіденційності',
                subtitle: 'Прочитати',
                icon: Icons.privacy_tip_outlined,
                onTap: () => context.push('/settings/privacy'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              'Alias Pro v1.0.0 MVP',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Alias Pro',
      applicationVersion: '1.0.0 MVP',
      applicationIcon: const Icon(
        Icons.gamepad,
        size: 48,
        color: AppTheme.primaryColor,
      ),
      children: [
        const Text(
          'Гра в слова для веселої компанії!\n\n'
          'Пояснюй слова своїй команді та вигравай.\n\n'
          'Developed with ❤️ by Alias Pro Team',
        ),
      ],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppTheme.primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
        child: Icon(icon, color: AppTheme.primaryColor, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
