import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const HomeBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F1EB),
        border: Border(top: BorderSide(color: Color(0xFFFF9538), width: 2)),
      ),
      child: Theme(
        data: Theme.of(
          context,
        ).copyWith(iconTheme: const IconThemeData(color: Color(0xFF6B4423))),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          backgroundColor: const Color(0xFFF5F1EB),
          indicatorColor: Colors.transparent,
          onDestinationSelected: onDestinationSelected,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: Color(0xFF6B4423),
                fontWeight: FontWeight.w500,
              );
            }
            return const TextStyle(color: Color(0xFF6B4423));
          }),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.restaurant_menu, color: Color(0xFF6B4423)),
              selectedIcon: Icon(
                Icons.restaurant_menu,
                color: Color(0xFF6B4423),
              ),
              label: '挑戦',
            ),
            NavigationDestination(
              icon: Icon(Icons.history, color: Color(0xFF6B4423)),
              selectedIcon: Icon(Icons.restaurant, color: Color(0xFF6B4423)),
              label: '料理履歴',
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Color(0xFF6B4423)),
              selectedIcon: Icon(Icons.home, color: Color(0xFF6B4423)),
              label: 'ホーム',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined, color: Color(0xFF6B4423)),
              selectedIcon: Icon(Icons.settings, color: Color(0xFF6B4423)),
              label: '設定',
            ),
          ],
        ),
      ),
    );
  }
}
