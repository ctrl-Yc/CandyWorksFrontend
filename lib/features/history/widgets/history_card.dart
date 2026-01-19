import 'package:flutter/material.dart';
import '../models/history_item.dart';

class HistoryCard extends StatelessWidget {
  final HistoryItem item;
  final double? width;
  final EdgeInsetsGeometry margin;
  final bool isSelected;

  const HistoryCard({
    super.key,
    required this.item,
    this.width = 140,
    this.margin = const EdgeInsets.only(right: 12),
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? Colors.black87 : const Color(0xFF6B4423);
    final borderWidth = isSelected ? 2.0 : 1.0;
    final backgroundColor = isSelected ? const Color(0xFFFFF3E0) : Colors.white;
    final boxShadow = isSelected
        ? const [
            BoxShadow(
              color: Color(0x4D000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ]
        : const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _ImageFrame(imageUrl: item.imageUrl),
            const SizedBox(height: 8),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.date,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                Icon(
                  item.isFavorite ? Icons.star : Icons.star_border,
                  size: 16,
                  color: item.isFavorite
                      ? const Color(0xFFF7B500)
                      : Colors.black54,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageFrame extends StatelessWidget {
  final String imageUrl;

  const _ImageFrame({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFF3F3F3),
              child: const Center(
                child: Icon(Icons.restaurant, color: Colors.black38),
              ),
            );
          },
        ),
      ),
    );
  }
}
