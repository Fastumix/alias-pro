import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../../../../shared/theme/app_theme.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final currentLanguage = settings.language;

    final languages = [
      _Language(
        code: 'uk',
        name: 'Українська',
        flag: '🇺🇦',
      ),
      _Language(
        code: 'en',
        name: 'English',
        flag: '🇬🇧',
      ),
      _Language(
        code: 'pl',
        name: 'Polski',
        flag: '🇵🇱',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мова'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final isSelected = language.code == currentLanguage;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Text(
                language.flag,
                style: const TextStyle(fontSize: 32),
              ),
              title: Text(
                language.name,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: isSelected
                  ? const Icon(
                      Icons.check_circle,
                      color: AppTheme.primaryColor,
                    )
                  : const Icon(
                      Icons.circle_outlined,
                      color: Colors.grey,
                    ),
              onTap: () async {
                await ref.read(settingsProvider.notifier).updateLanguage(language.code);
                
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Мову змінено на ${language.name}'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class _Language {
  final String code;
  final String name;
  final String flag;

  _Language({
    required this.code,
    required this.name,
    required this.flag,
  });
}
