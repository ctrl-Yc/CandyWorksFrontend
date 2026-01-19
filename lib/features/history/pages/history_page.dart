import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/history_mock_data.dart';
import '../widgets/history_section.dart';
import '../../home/navigation/home_bottom_nav.dart';
import '../../home/widgets/bottom_navigation_bar.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9538),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HeaderRow(),
                const SizedBox(height: 12),
                const _DashedDivider(),
                const SizedBox(height: 16),
                HistorySection(
                  title: '作った料理',
                  onMorePressed: () {},
                  items: HistoryMockData.cookedItems,
                ),
                const SizedBox(height: 24),
                HistorySection(
                  title: 'お気に入り',
                  onMorePressed: () {},
                  items: HistoryMockData.favoriteItems,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedIndex: HomeBottomNav.history,
        onDestinationSelected: (index) {
          if (index == HomeBottomNav.history) {
            return;
          }
          HomeBottomNav.goToIndex(context, index);
        },
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Cook\nUp',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 0.9,
          ),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.restaurant_menu, color: Colors.black87, size: 22),
        const SizedBox(width: 8),
        const Text(
          '料理履歴',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 6.0;
        final dashSpace = 6.0;
        final dashCount =
            (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (index) {
            return const SizedBox(
              width: 6,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black87),
              ),
            );
          }),
        );
      },
    );
  }
}
