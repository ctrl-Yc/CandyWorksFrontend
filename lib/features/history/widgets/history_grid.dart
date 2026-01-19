import 'package:flutter/material.dart';
import '../models/history_item.dart';
import '../widgets/history_card.dart';

class HistoryGrid extends StatelessWidget {
  final List<HistoryItem> items;
  final String? selectedId;
  final ValueChanged<HistoryItem> onSelect;

  const HistoryGrid({
    super.key,
    required this.items,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 6,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = item.id == selectedId;
        return Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () => onSelect(item),
            child: HistoryCard(
              item: item,
              width: double.infinity,
              margin: EdgeInsets.zero,
              isSelected: isSelected,
            ),
          ),
        );
      },
    );
  }
}
