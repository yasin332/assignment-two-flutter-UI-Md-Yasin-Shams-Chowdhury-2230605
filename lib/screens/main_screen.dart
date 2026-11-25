import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'progress_page.dart';
import 'tasks_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(onSeeAll: () => _goTo(1)),
          const TasksPage(),
          ProfilePage(
            themeMode: widget.themeMode,
            onThemeModeChanged: widget.onThemeModeChanged,
          ),
          const ProgressPage(),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.card,
          border: Border(top: BorderSide(color: colors.line)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _goTo,
          items: [
            _item(Icons.home_outlined, Icons.home_rounded, 'Home'),
            _item(
              Icons.fact_check_outlined,
              Icons.fact_check_rounded,
              'Tasks',
            ),
            _item(Icons.person_outline, Icons.person_rounded, 'Profile'),
            _item(
              Icons.bar_chart_outlined,
              Icons.bar_chart_rounded,
              'Progress',
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _item(
    IconData icon,
    IconData activeIcon,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: _barIcon(icon, active: false),
      activeIcon: _barIcon(activeIcon, active: true),
      label: label,
    );
  }

  Widget _barIcon(IconData icon, {required bool active}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: active ? AppPalette.blue.withValues(alpha: 0.12) : null,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, size: 22),
    );
  }
}
