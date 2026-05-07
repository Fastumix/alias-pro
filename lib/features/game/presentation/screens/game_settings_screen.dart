import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../providers/game_settings_provider.dart';
import '../providers/teams_provider.dart';

class GameSettingsScreen extends ConsumerWidget {
  final String levelId;
  const GameSettingsScreen({required this.levelId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(gameSettingsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFDFE5F3),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildTimeRound(ref, settings),
                    const SizedBox(height: 12),
                    _buildPointsForWin(ref, settings),
                    const SizedBox(height: 12),
                    _buildToggleRow(
                      title: 'Penalty for missing',
                      subtitle: '±1 point for missing',
                      value: settings.penaltyForMissing,
                      onChanged: (_) => ref
                          .read(gameSettingsProvider.notifier)
                          .togglePenaltyForMissing(),
                    ),
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      title: 'General final word',
                      subtitle: 'All teams can guess this word.',
                      value: settings.generalFinalWord,
                      onChanged: (_) => ref
                          .read(gameSettingsProvider.notifier)
                          .toggleGeneralFinalWord(),
                    ),
                    const SizedBox(height: 8),
                    _buildSoundSection(context, ref, settings),
                    const SizedBox(height: 8),
                    _buildAiHelperRow(ref, settings),
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      title: 'Special round',
                      subtitle:
                          'Special rounds will be triggered after a full round of play.',
                      value: settings.specialRound,
                      onChanged: (_) => ref
                          .read(gameSettingsProvider.notifier)
                          .toggleSpecialRound(),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            _buildNextButton(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF2D3D8B),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18,),
            ),
          ),
          const Expanded(
            child: Text(
              'Settings Game',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C2659),
                fontFamily: 'Gilroy',
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF2D3D8B), width: 1.5),
            ),
            child: const Icon(Icons.info_outline,
                color: Color(0xFF2D3D8B), size: 20,),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget _buildTimeRound(WidgetRef ref, GameSettings settings) {
    return _card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Time round',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C2659),
                  fontFamily: 'Gilroy',
                ),
              ),
              Text(
                '${settings.timeRound} sec',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3D8B),
                  fontFamily: 'Gilroy',
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: const Color(0xFF2D3D8B),
              inactiveTrackColor: const Color(0xFFDFE5F3),
              thumbColor: const Color(0xFF2D3D8B),
              trackHeight: 4,
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              value: settings.timeRound.toDouble(),
              min: 15,
              max: 120,
              divisions: 21,
              onChanged: (v) => ref
                  .read(gameSettingsProvider.notifier)
                  .setTimeRound(v.round()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsForWin(WidgetRef ref, GameSettings settings) {
    const options = [60, 80, 100, 120];
    return _card(
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Point for win',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C2659),
                fontFamily: 'Gilroy',
              ),
            ),
          ),
          Text(
            '${settings.pointsForWin}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3D8B),
              fontFamily: 'Gilroy',
            ),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              ...options.map((v) {
                final isSelected = settings.pointsForWin == v;
                return GestureDetector(
                  onTap: () => ref
                      .read(gameSettingsProvider.notifier)
                      .setPointsForWin(v),
                  child: Container(
                    margin: const EdgeInsets.only(left: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2D3D8B)
                          : const Color(0xFFDFE5F3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$v',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? Colors.white : const Color(0xFF1C2659),
                        fontFamily: 'Gilroy',
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(width: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFE5F3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.grid_view_rounded,
                    size: 16, color: Color(0xFF1C2659),),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return _card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1C2659),
                    fontFamily: 'Gilroy',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                    fontFamily: 'Gilroy',
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF2D3D8B),
          ),
        ],
      ),
    );
  }

  Widget _buildSoundSection(
      BuildContext context, WidgetRef ref, GameSettings settings,) {
    const sounds = ['Bambino', 'Trambon', 'Hey Bro', 'Beep', 'Ding'];
    return _card(
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Sound',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1C2659),
                    fontFamily: 'Gilroy',
                  ),
                ),
              ),
              Switch(
                value: settings.soundEnabled,
                onChanged: (_) =>
                    ref.read(gameSettingsProvider.notifier).toggleSound(),
                activeThumbColor: const Color(0xFF2D3D8B),
              ),
            ],
          ),
          if (settings.soundEnabled) ...[
            const Divider(height: 16),
            _buildSoundRow(
              context: context,
              label: 'Guessed',
              current: settings.soundGuessed,
              sounds: sounds,
              onChanged: (v) =>
                  ref.read(gameSettingsProvider.notifier).setSoundGuessed(v),
            ),
            const SizedBox(height: 8),
            _buildSoundRow(
              context: context,
              label: 'Pass',
              current: settings.soundPass,
              sounds: sounds,
              onChanged: (v) =>
                  ref.read(gameSettingsProvider.notifier).setSoundPass(v),
            ),
            const SizedBox(height: 8),
            _buildSoundRow(
              context: context,
              label: 'The last word',
              current: settings.soundLastWord,
              sounds: sounds,
              onChanged: (v) =>
                  ref.read(gameSettingsProvider.notifier).setSoundLastWord(v),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSoundRow({
    required BuildContext context,
    required String label,
    required String current,
    required List<String> sounds,
    required ValueChanged<String> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
              fontFamily: 'Gilroy',
            ),
          ),
        ),
        Expanded(
          child: Text(
            current,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1C2659),
              fontFamily: 'Gilroy',
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            final result = await showModalBottomSheet<String>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) =>
                  _SoundPicker(sounds: sounds, current: current),
            );
            if (result != null) onChanged(result);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFDFE5F3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.swap_vert,
                size: 18, color: Color(0xFF2D3D8B),),
          ),
        ),
      ],
    );
  }

  Widget _buildAiHelperRow(WidgetRef ref, GameSettings settings) {
    return _card(
      child: Row(
        children: [
          SvgPicture.asset('assets/ai-star.svg', width: 16, height: 16),
          const SizedBox(width: 6),
          const Expanded(
            child: Text(
              'AI helper',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3D8B),
                fontFamily: 'Gilroy',
              ),
            ),
          ),
          Switch(
            value: settings.aiHelper,
            onChanged: (_) =>
                ref.read(gameSettingsProvider.notifier).toggleAiHelper(),
            activeThumbColor: const Color(0xFF2D3D8B),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, WidgetRef ref) {
    final teams = ref.read(teamsProvider);
    final firstTeam = teams.isNotEmpty ? teams.first : 'Team';
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => context.push(
            '/game-start/$levelId/${Uri.encodeComponent(firstTeam)}/1/0',
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2D3D8B),
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy',
            ),
          ),
        ),
      ),
    );
  }
}

class _SoundPicker extends StatelessWidget {
  final List<String> sounds;
  final String current;
  const _SoundPicker({required this.sounds, required this.current});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          ...sounds.map(
            (s) => ListTile(
              title: Text(s, style: const TextStyle(fontFamily: 'Gilroy')),
              trailing: s == current
                  ? const Icon(Icons.check, color: Color(0xFF2D3D8B))
                  : null,
              onTap: () => Navigator.pop(context, s),
            ),
          ),
        ],
      ),
    );
  }
}
