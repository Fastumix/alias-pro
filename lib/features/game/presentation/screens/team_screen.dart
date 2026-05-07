import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/teams_provider.dart';

class TeamScreen extends ConsumerWidget {
  final String levelId;
  const TeamScreen({required this.levelId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(teamsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFDFE5F3),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ...List.generate(teams.length, (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildTeamCard(context, ref, teams[i], i),
                    ),),
                    const SizedBox(height: 4),
                    _buildAddTeamButton(context, ref),
                    const SizedBox(height: 20),
                    _buildHints(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            _buildNextButton(context),
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
              'Team',
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

  Widget _buildTeamCard(
      BuildContext context, WidgetRef ref, String name, int index,) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3D8B),
                fontFamily: 'Gilroy',
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _showRenameDialog(context, ref, index, name),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Icon(
                Icons.edit_outlined,
                color: const Color(0xFF2D3D8B).withValues(alpha: 0.6),
                size: 22,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => ref.read(teamsProvider.notifier).removeTeam(index),
            child: const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(Icons.delete_outline,
                  color: Color(0xFFE53935), size: 22,),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTeamButton(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showAddDialog(context, ref),
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: const Color(0xFF2D3D8B),
          borderRadius: 32,
          dashWidth: 6,
          dashSpace: 5,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: const Center(
            child: Text(
              'Add new team',
              style: TextStyle(
                color: Color(0xFF2D3D8B),
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Gilroy',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHints() {
    const style = TextStyle(
      fontSize: 12,
      color: Color(0xFF666666),
      fontFamily: 'Gilroy',
    );
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('*To automatically generate a name, simply click on it.', style: style),
        SizedBox(height: 4),
        Text(
          '*To select the order of commands, press and hold for a couple of seconds and move',
          style: style,
        ),
      ],
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => context.push('/game-settings/$levelId'),
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

  Future<void> _showRenameDialog(
      BuildContext context, WidgetRef ref, int index, String current,) async {
    final controller = TextEditingController(text: current);
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename team',
            style: TextStyle(fontFamily: 'Gilroy'),),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Team name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(teamsProvider.notifier)
                  .renameTeam(index, controller.text);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D3D8B),),
            child: const Text('Save',
                style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
    controller.dispose();
  }

  Future<void> _showAddDialog(
      BuildContext context, WidgetRef ref,) async {
    final controller = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add team',
            style: TextStyle(fontFamily: 'Gilroy'),),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Team name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref
                    .read(teamsProvider.notifier)
                    .addTeam(controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D3D8B),),
            child: const Text('Add',
                style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
    controller.dispose();
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double dashWidth;
  final double dashSpace;

  _DashedBorderPainter({
    required this.color,
    this.borderRadius = 32,
    this.dashWidth = 6,
    this.dashSpace = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2 / 2, 2 / 2,
          size.width - 2, size.height - 2,),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color ||
      old.borderRadius != borderRadius ||
      old.dashWidth != dashWidth ||
      old.dashSpace != dashSpace;
}
