import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Як грати'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(
            Icons.gamepad,
            size: 80,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 24),
          const Text(
            'Правила гри Alias',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildStep(
            number: '1',
            title: 'Виберіть категорію',
            description: 'На головному екрані натисніть "Грати" та виберіть одну з 5 категорій: Тварини, Фільми, Спорт, Їжа або Історичні постаті.',
            icon: Icons.category,
          ),
          _buildStep(
            number: '2',
            title: 'Пояснюйте слова',
            description: 'На екрані з\'явиться слово. Ваше завдання - пояснити його своїй команді, не називаючи саме слово.',
            icon: Icons.chat_bubble,
          ),
          _buildStep(
            number: '3',
            title: 'Використовуйте синоніми',
            description: 'Використовуйте синоніми, асоціації, опис та будь-які інші підказки. Головне - не називайте саме слово!',
            icon: Icons.lightbulb,
          ),
          _buildStep(
            number: '4',
            title: 'Час обмежений',
            description: 'У вас є 90 секунд на раунд. Постарайтеся пояснити якнайбільше слів за цей час.',
            icon: Icons.timer,
          ),
          _buildStep(
            number: '5',
            title: 'Підрахунок очок',
            description: 'За кожне вгадане слово ви отримуєте +1 очко. Якщо ви пропускаєте слово, ви втрачаєте -1 очко.',
            icon: Icons.calculate,
          ),
          _buildStep(
            number: '6',
            title: 'Результати',
            description: 'Після завершення раунду ви побачите свій результат та статистику гри. Ваші рекорди зберігаються в профілі.',
            icon: Icons.emoji_events,
          ),
          const SizedBox(height: 32),
          Card(
            color: AppTheme.primaryColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(
                    Icons.tips_and_updates,
                    size: 48,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Поради',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildTip('Будьте швидкими - час летить!'),
                  _buildTip('Використовуйте жести та міміку'),
                  _buildTip('Якщо застрягли, пропустіть слово'),
                  _buildTip('Практикуйтесь, щоб побити свій рекорд'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Зрозуміло, почнемо!'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              radius: 20,
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 20, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            size: 16,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
