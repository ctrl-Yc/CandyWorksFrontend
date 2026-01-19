import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/history_mock_data.dart';
import '../models/history_item.dart';
import '../widgets/history_feedback_panel.dart';
import '../widgets/history_grid.dart';

class FavoriteHistoryPage extends ConsumerStatefulWidget {
  const FavoriteHistoryPage({super.key});

  @override
  ConsumerState<FavoriteHistoryPage> createState() =>
      _FavoriteHistoryPageState();
}

class _FavoriteHistoryPageState extends ConsumerState<FavoriteHistoryPage> {
  String? _selectedId;

  void _handleSelect(HistoryItem item) {
    setState(() {
      if (_selectedId == item.id) {
        _selectedId = null;
      } else {
        _selectedId = item.id;
      }
    });
  }

  HistoryItem? _findSelectedItem(List<HistoryItem> items) {
    for (final item in items) {
      if (item.id == _selectedId) {
        return item;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final items = HistoryMockData.favoriteItems;
    final selectedItem = _findSelectedItem(items);
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
                Text(
                  'お気に入り',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                HistoryGrid(
                  items: items,
                  selectedId: _selectedId,
                  onSelect: _handleSelect,
                ),
                const SizedBox(height: 18),
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
                  child: selectedItem == null
                      ? const SizedBox.shrink()
                      : HistoryFeedbackPanel(
                          key: ValueKey(selectedItem.id),
                          item: selectedItem,
                        ),
                ),
              ],
            ),
          ),
        ),
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
        IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/history');
            }
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          tooltip: '戻る',
        ),
        const SizedBox(width: 4),
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
          'お気に入り',
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
