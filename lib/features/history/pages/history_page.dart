import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/history_mock_data.dart';
import '../models/history_item.dart';
import '../widgets/history_feedback_panel.dart';
import '../widgets/history_section.dart';
import '../../home/navigation/home_bottom_nav.dart';
import '../../home/widgets/bottom_navigation_bar.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  String? _selectedCookedId;
  String? _selectedFavoriteId;

  void _handleCookedSelect(HistoryItem item) {
    setState(() {
      if (_selectedCookedId == item.id) {
        _selectedCookedId = null;
      } else {
        _selectedCookedId = item.id;
      }
    });
  }

  void _handleFavoriteSelect(HistoryItem item) {
    setState(() {
      if (_selectedFavoriteId == item.id) {
        _selectedFavoriteId = null;
      } else {
        _selectedFavoriteId = item.id;
      }
    });
  }

  HistoryItem? _findSelectedItem(List<HistoryItem> items, String? selectedId) {
    for (final item in items) {
      if (item.id == selectedId) {
        return item;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cookedItems = HistoryMockData.cookedItems
        .take(3)
        .toList(growable: false);
    final favoriteItems = HistoryMockData.favoriteItems;
    final selectedCooked = _findSelectedItem(cookedItems, _selectedCookedId);
    final selectedFavorite = _findSelectedItem(
      favoriteItems,
      _selectedFavoriteId,
    );
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
                  onMorePressed: () {
                    context.go('/history/cooked');
                  },
                  items: cookedItems,
                  selectedId: _selectedCookedId,
                  onSelect: _handleCookedSelect,
                ),
                const SizedBox(height: 12),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.08),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: selectedCooked == null
                      ? const SizedBox.shrink()
                      : HistoryFeedbackPanel(
                          key: ValueKey(selectedCooked.id),
                          item: selectedCooked,
                        ),
                ),
                const SizedBox(height: 24),
                HistorySection(
                  title: 'お気に入り',
                  onMorePressed: () {
                    context.go('/history/favorite');
                  },
                  items: favoriteItems,
                  selectedId: _selectedFavoriteId,
                  onSelect: _handleFavoriteSelect,
                ),
                const SizedBox(height: 12),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.08),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: selectedFavorite == null
                      ? const SizedBox.shrink()
                      : HistoryFeedbackPanel(
                          key: ValueKey(selectedFavorite.id),
                          item: selectedFavorite,
                        ),
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
        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace))
            .floor();
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
