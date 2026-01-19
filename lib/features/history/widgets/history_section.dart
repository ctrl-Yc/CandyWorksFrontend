import 'package:flutter/material.dart';
import '../models/history_item.dart';
import 'history_card.dart';

class HistorySection extends StatelessWidget {
  final String title;
  final VoidCallback onMorePressed;
  final List<HistoryItem> items;
  final String? selectedId;
  final ValueChanged<HistoryItem> onSelect;

  const HistorySection({
    super.key,
    required this.title,
    required this.onMorePressed,
    required this.items,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: onMorePressed,
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.zero,
              ),
              child: const Row(
                children: [
                  Text('もっと見る'),
                  SizedBox(width: 6),
                  Icon(Icons.chevron_right, size: 18),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isSelected = item.id == selectedId;
              return GestureDetector(
                onTap: () => onSelect(item),
                child: HistoryCard(
                  item: item,
                  isSelected: isSelected,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
