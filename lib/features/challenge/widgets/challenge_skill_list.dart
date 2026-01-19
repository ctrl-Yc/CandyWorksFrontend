import 'package:flutter/material.dart';

class ChallengeSkillItem {
  final String categoryId;
  final String label;

  const ChallengeSkillItem({required this.categoryId, required this.label});
}

class ChallengeSkillList extends StatelessWidget {
  final List<ChallengeSkillItem> skills;
  final Map<String, Set<String>> selectedSkillsByCategory;
  final void Function(String categoryId, String skill) onToggle;
  final ScrollController controller;

  const ChallengeSkillList({
    super.key,
    required this.skills,
    required this.selectedSkillsByCategory,
    required this.onToggle,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      primary: false,
      padding: EdgeInsets.zero,
      itemCount: skills.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: Color(0xFF6B4423)),
      itemBuilder: (context, index) {
        final skill = skills[index];
        final isSelected =
            selectedSkillsByCategory[skill.categoryId]?.contains(skill.label) ??
            false;
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onToggle(skill.categoryId, skill.label),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      skill.label,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87, width: 1),
                      color: isSelected
                          ? const Color(0xFFB83B2D)
                          : Colors.white,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
