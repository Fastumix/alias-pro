import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../coins/presentation/providers/coins_provider.dart';

enum CategoryTab { level, category, ownLists }

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  CategoryTab _selectedTab = CategoryTab.level;
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final coins = ref.watch(coinsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFDFE5F3),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(coins.balance),
            
            const SizedBox(height: 16),
            
            // AI Create Category Card
            _buildAICard(),
            
            const SizedBox(height: 16),
            
            // White background for tabs and list
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // Tabs
                    _buildTabs(),
                    
                    const SizedBox(height: 16),
                    
                    // Category List
                    Expanded(
                      child: _selectedTab == CategoryTab.category 
                        ? _buildCategoryView()
                        : _buildCategoryList(),
                    ),
                    
                    // Bottom Navigation
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: _buildBottomNav(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int coins) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Builder(builder: (context) {
            final double proVerticalPadding = ((Theme.of(context).textTheme.displayMedium?.fontSize ?? 32) * 0.09).clamp(3.0, 8.0) as double;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/logo.svg',
                  width: 110,
                  height: 39,
                ),
                const SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: proVerticalPadding),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA3AFF3),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    'pro',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1C2659),
                    ),
                  ),
                ),
              ],
            );
          }),
          
          // Coins
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  coins.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFB800),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/valute-icon.svg',
                    width: 16,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAICard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 145,
      decoration: BoxDecoration(color: const Color(0xFF2D3D8B), borderRadius: BorderRadius.circular(24)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFE5F3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/ai-star.svg',
                            width: 14,
                            height: 14,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'AI',
                            style: TextStyle(
                              color: Color(0xFF2D3D8B),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/lock.svg',
                            width: 14,
                            height: 14,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Close',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Create your own category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 180,
                  child: Text(
                    'Make new challenges together with AI',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 8,
            bottom: -5,
            child: SizedBox(
              width: 120,
              height: 145,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(24),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    'assets/header-monster.svg',
                    fit: BoxFit.contain,
                    width: 120,
                    height: 145,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF2D3D8B),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              'LEVEL',
              CategoryTab.level,
              iconPath: 'assets/flash-icon.svg',
            ),
          ),
          Expanded(
            child: _buildTab(
              'CATEGORY',
              CategoryTab.category,
              iconPath: 'assets/category.svg',
            ),
          ),
          Expanded(
            child: _buildTab(
              'OWN LISTS',
              CategoryTab.ownLists,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, CategoryTab tab, {IconData? icon, String? iconPath}) {
    final isSelected = _selectedTab == tab;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = tab),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2D3D8B) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null && isSelected) ...[
              SvgPicture.asset(
                iconPath,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(width: 4),
            ] else if (icon != null && isSelected) ...[
              Icon(
                icon,
                size: 18,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        // Category Card
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF7941E),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            children: [
              // Word count badge
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.description_outlined, size: 16, color: Color(0xFF2D3D8B)),
                          SizedBox(width: 4),
                          Text(
                            '1325',
                            style: TextStyle(
                              color: Color(0xFF2D3D8B),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Placeholder for image
              Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3D8B).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Image placeholder',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Word chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildWordChip('Cat'),
                    _buildWordChip('Giraffe'),
                    _buildWordChip('Mink'),
                    _buildWordChip('Cow'),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Play button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x990D0D0D),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Animal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.play_arrow, color: Colors.white, size: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Menu button
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              elevation: 2,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.grid_view, color: Color(0xFF2D3D8B), size: 24),
                SizedBox(width: 12),
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Color(0xFF2D3D8B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildWordChip(String word) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        word,
        style: const TextStyle(
          color: Color(0xFF2D3D8B),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildCategoryCard(
          'Beginner',
          'This is a fast-paced game for the whole family.',
          1325,
          const Color(0xFFB8F4C6),
          const Color(0xFF2E7D32),
          isUnlocked: true,
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          'Player',
          'This is a fast-paced game for the whole family.',
          643,
          const Color(0xFFFFF9C4),
          const Color(0xFFF57F17),
          isUnlocked: true,
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          'Pro',
          'This is a fast-paced game for the whole family.',
          1354,
          const Color(0xFFBBDEFB),
          const Color(0xFF1976D2),
          isDemo: true,
          isUnlocked: true,
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          'Master',
          'This is a fast-paced game for the whole family.',
          0,
          const Color(0xFFE1BEE7),
          const Color(0xFF7B1FA2),
          isLocked: true,
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          'GOD Alias',
          'This is a fast-paced game for the whole family.',
          0,
          const Color(0xFFFFCCBC),
          const Color(0xFFD84315),
          isLocked: true,
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildCategoryCard(
    String level,
    String description,
    int wordCount,
    Color bgColor,
    Color textColor, {
    bool isLocked = false,
    bool isDemo = false,
    bool isUnlocked = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  level,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isDemo) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: textColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/time-icon.svg',
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Demo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (isLocked) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/lock.svg',
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Close',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(4),
                child: ImageFiltered(
                  imageFilter: isLocked 
                      ? ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5) 
                      : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/docs-icon.svg',
                        width: 16,
                        height: 16,
                        color: textColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        wordCount.toString(),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(2),
            child: ImageFiltered(
              imageFilter: isLocked 
                  ? ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5) 
                  : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Text(
                description,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
            GestureDetector(
            onTap: () => setState(() => _selectedNavIndex = 0),
            child: Builder(builder: (context) {
              final isSelected = _selectedNavIndex == 0;
              return Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF2D3D8B) : Colors.transparent,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Row(
                children: [
                SvgPicture.asset(
                  'assets/main-icon.svg',
                  width: 24,
                  height: 24,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                if ('Game'.isNotEmpty && isSelected) ...[
                  const SizedBox(width: 8),
                  const Text(
                  'Game',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ],
                ],
              ),
              );
            }),
            ),
            GestureDetector(
            onTap: () => setState(() => _selectedNavIndex = 1),
            child: Builder(builder: (context) {
              final isSelected = _selectedNavIndex == 1;
              return Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF2D3D8B) : Colors.transparent,
                borderRadius: BorderRadius.circular(99),
              ),
              child: SvgPicture.asset(
                'assets/achivment-icon.svg',
                width: 24,
                height: 24,
                color: isSelected ? Colors.white : Colors.black,
              ),
              );
            }),
            ),
            GestureDetector(
            onTap: () => setState(() => _selectedNavIndex = 2),
            child: Builder(builder: (context) {
              final isSelected = _selectedNavIndex == 2;
              return Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF2D3D8B) : Colors.transparent,
                borderRadius: BorderRadius.circular(99),
              ),
              child: SvgPicture.asset(
                'assets/store-icon.svg',
                width: 24,
                height: 24,
                color: isSelected ? Colors.white : Colors.black,
              ),
              );
            }),
            ),
          _buildNavItem(Icons.settings_outlined, '', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedNavIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() => _selectedNavIndex = index);
        
        if (index == 2) {
          // Home already
        } else if (index == 3) {
          context.push('/settings');
        } else if (index == 1) {
          // Ideas/Tips
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF2D3D8B) : Colors.transparent,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 24,
            ),
            if (label.isNotEmpty && isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
