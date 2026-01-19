import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const HomeBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  static const Color _backgroundColor = Color(0xFFF5F1EB);
  static const Color _accentColor = Color(0xFFFF9538);
  static const Color _iconColor = Color(0xFF6B4423);

  static const TextStyle _labelTextStyle = TextStyle(color: _iconColor);
  static const TextStyle _selectedLabelTextStyle = TextStyle(
    color: _iconColor,
    fontWeight: FontWeight.w500,
  );

  static const List<_NavDestinationData> _destinations = [
    _NavDestinationData(
      icon: Icons.restaurant_menu,
      selectedIcon: Icons.restaurant_menu,
      label: '挑戦',
    ),
    _NavDestinationData(
      icon: Icons.history,
      selectedIcon: Icons.restaurant,
      label: '料理履歴',
    ),
    _NavDestinationData(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'ホーム',
    ),
    _NavDestinationData(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: '設定',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _backgroundColor,
        border: Border(top: BorderSide(color: _accentColor, width: 2)),
      ),
      child: NavigationBarTheme(
        data: const NavigationBarThemeData(
          backgroundColor: _backgroundColor,
          indicatorColor: Colors.transparent,
          iconTheme: WidgetStatePropertyAll(IconThemeData(color: _iconColor)),
          labelTextStyle: WidgetStatePropertyAll(_labelTextStyle),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _selectedLabelTextStyle;
            }
            return _labelTextStyle;
          }),
          destinations: _destinations
              .map(
                (destination) => NavigationDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: destination.label,
                ),
              )
              .toList(growable: false),
        ),
      ),
    );
  }
}

class _NavDestinationData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _NavDestinationData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}
