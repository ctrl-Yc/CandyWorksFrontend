import 'package:flutter/material.dart';
import '../models/history_item.dart';
import '../widgets/history_card.dart';

class HistoryGrid extends StatelessWidget {
  final List<HistoryItem> items;

  const HistoryGrid({super.key, required this.items});

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
        return Align(
          alignment: Alignment.topLeft,
          child: HistoryCard(
            item: items[index],
            width: double.infinity,
            margin: EdgeInsets.zero,
          ),
        );
      },
    );
  }
}
