import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../../../../shared/theme/app_theme.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  late TextEditingController _nameController;
  String? _selectedAvatar;

  final List<String> _avatars = [
    '😀', '😎', '🤓', '😇', '🥳',
    '🤩', '🚀', '⚡', '🔥', '⭐',
    '🎮', '🎯', '🏆', '👑', '💎',
  ];

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);
    _nameController = TextEditingController(text: settings.userName);
    _selectedAvatar = settings.avatarUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ім'я не може бути порожнім")),
      );
      return;
    }

    await ref.read(settingsProvider.notifier).updateUserName(name);
    
    if (_selectedAvatar != null) {
      await ref.read(settingsProvider.notifier).updateAvatarUrl(_selectedAvatar!);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Профіль оновлено!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Редагувати профіль'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
              child: Text(
                _selectedAvatar ?? settings.avatarUrl ?? '😀',
                style: const TextStyle(fontSize: 64),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Виберіть аватар',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: _avatars.length,
            itemBuilder: (context, index) {
              final avatar = _avatars[index];
              final isSelected = avatar == _selectedAvatar;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAvatar = avatar;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? AppTheme.primaryColor.withOpacity(0.2)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(color: AppTheme.primaryColor, width: 3)
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      avatar,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          const Text(
            "Ім'я",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Введіть ім'я",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.person),
            ),
            maxLength: 20,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Зберегти',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
