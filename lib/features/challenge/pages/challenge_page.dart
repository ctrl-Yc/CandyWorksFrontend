import 'package:flutter/material.dart';
import '../../home/navigation/home_bottom_nav.dart';
import '../../home/widgets/bottom_navigation_bar.dart';
import '../data/challenge_mock_data.dart';
import '../models/challenge_category.dart';
import '../widgets/challenge_category_tabs.dart';
import '../widgets/challenge_skill_list.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  late final List<ChallengeCategory> _categories;
  late final ScrollController _skillScrollController;
  String? _selectedCategoryId;
  final Map<String, Set<String>> _selectedSkillsByCategory = {};

  @override
  void initState() {
    super.initState();
    _categories = ChallengeMockData.categories;
    _skillScrollController = ScrollController();
    _selectedCategoryId = null;
  }

  @override
  void dispose() {
    _skillScrollController.dispose();
    super.dispose();
  }

  void _handleSelectCategory(ChallengeCategory? category) {
    setState(() {
      _selectedCategoryId = category?.id;
    });
  }

  void _toggleSkill(String categoryId, String skill) {
    setState(() {
      final selected = _selectedSkillsByCategory.putIfAbsent(
        categoryId,
        () => <String>{},
      );
      if (selected.contains(skill)) {
        selected.remove(skill);
      } else {
        selected.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategoryId = _selectedCategoryId;
    final selectedCategory = selectedCategoryId == null
        ? null
        : _categories.firstWhere(
            (category) => category.id == selectedCategoryId,
          );
    final skills = selectedCategory == null
        ? _categories
              .expand(
                (category) => category.skills.map(
                  (skill) =>
                      ChallengeSkillItem(categoryId: category.id, label: skill),
                ),
              )
              .toList()
        : selectedCategory.skills
              .map(
                (skill) => ChallengeSkillItem(
                  categoryId: selectedCategory.id,
                  label: skill,
                ),
              )
              .toList();
    final panelTitle = selectedCategory?.label ?? 'すべて';
    final panelIconPath = selectedCategory?.iconPath;
    return Scaffold(
      backgroundColor: const Color(0xFFFF9538),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HeaderRow(),
              const SizedBox(height: 16),
              ChallengeCategoryTabs(
                categories: _categories,
                selectedId: _selectedCategoryId,
                onSelect: _handleSelectCategory,
              ),
              const SizedBox(height: 12),
              const _DashedDivider(),
              const SizedBox(height: 12),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _SkillPanel(
                        title: panelTitle,
                        iconPath: panelIconPath,
                        skills: skills,
                        selectedSkillsByCategory: _selectedSkillsByCategory,
                        onToggle: _toggleSkill,
                        scrollController: _skillScrollController,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _OkButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedIndex: HomeBottomNav.challenge,
        onDestinationSelected: (index) {
          if (index == HomeBottomNav.challenge) {
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Image.asset(
        'assets/cookup_logo.png',
        height: 40,
        fit: BoxFit.contain,
      ),
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

class _SkillPanel extends StatelessWidget {
  final String title;
  final String? iconPath;
  final List<ChallengeSkillItem> skills;
  final Map<String, Set<String>> selectedSkillsByCategory;
  final void Function(String categoryId, String skill) onToggle;
  final ScrollController scrollController;

  const _SkillPanel({
    required this.title,
    required this.iconPath,
    required this.skills,
    required this.selectedSkillsByCategory,
    required this.onToggle,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black87, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _PanelHeader(title: title, iconPath: iconPath),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFF6B4423), height: 1),
          const SizedBox(height: 8),
          Expanded(
            child: Scrollbar(
              controller: scrollController,
              child: ChallengeSkillList(
                skills: skills,
                selectedSkillsByCategory: selectedSkillsByCategory,
                onToggle: onToggle,
                controller: scrollController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  final String title;
  final String? iconPath;

  const _PanelHeader({required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFB83B2D), width: 1.5),
      ),
      child: Row(
        children: [
          if (iconPath != null) ...[
            Image.asset(iconPath!, height: 28, width: 28),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFB83B2D),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _OkButton extends StatelessWidget {
  const _OkButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D6),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: const Text(
        'OK',
        style: TextStyle(
          color: Color(0xFFB83B2D),
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
