import 'package:flutter/material.dart';
import '../models/challenge_category.dart';

class ChallengeCategoryTabs extends StatelessWidget {
  final List<ChallengeCategory> categories;
  final String? selectedId;
  final ValueChanged<ChallengeCategory?> onSelect;

  const ChallengeCategoryTabs({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((category) {
        final isSelected = category.id == selectedId;
        final backgroundColor = isSelected
            ? const Color(0xFFB83B2D)
            : const Color(0xFFFFF1D6);
        final textColor = isSelected ? Colors.white : const Color(0xFF6B4423);
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => onSelect(isSelected ? null : category),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFB83B2D)
                          : const Color(0xFFE0C28A),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        category.iconPath,
                        height: 40,
                        width: 40,
                        color: isSelected ? Colors.white : null,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        category.label,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
