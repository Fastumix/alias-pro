import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/utils/colors.dart';
import '../../../../shared/widgets/custom_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              
              // App Logo/Title
              const Text(
                'ALIAS',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 8,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 12),
              
              const Text(
                'PRO',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textSecondary,
                  letterSpacing: 4,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 80),
              
              // Play Button
              CustomButton(
                text: 'Грати',
                onPressed: () => context.go('/categories'),
                isExpanded: true,
                icon: Icons.play_arrow_rounded,
              ),
              
              const SizedBox(height: 16),
              
              // Profile Button
              CustomButton(
                text: 'Профіль',
                onPressed: () => context.go('/profile'),
                isExpanded: true,
                icon: Icons.person_outline,
                backgroundColor: AppColors.surface,
                textColor: AppColors.primary,
              ),
              
              const Spacer(),
              
              // Version Info
              const Text(
                'v1.0.0 • MVP Edition',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
