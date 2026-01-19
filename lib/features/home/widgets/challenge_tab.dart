import 'package:flutter/material.dart';
import '../../history/data/history_mock_data.dart';
import '../../history/models/history_item.dart';

class ChallengeTab extends StatefulWidget {
  const ChallengeTab({super.key});

  @override
  State<ChallengeTab> createState() => _ChallengeTabState();
}

class _ChallengeTabState extends State<ChallengeTab> {
  int _currentIndex = 0;

  List<HistoryItem> get _items =>
      HistoryMockData.homeItems.take(3).toList(growable: false);

  void _goToPrevious() {
    setState(() {
      _currentIndex -= 1;
    });
  }

  void _goToNext() {
    setState(() {
      _currentIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    final hasItems = items.isNotEmpty;
    final currentIndex = _currentIndex.clamp(
      0,
      items.isEmpty ? 0 : items.length - 1,
    );
    final canGoPrevious = currentIndex > 0;
    final canGoNext = currentIndex < items.length - 1;
    final currentItem = hasItems ? items[currentIndex] : null;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '今日のオススメ料理☆',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // レシピカード
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: canGoPrevious ? _goToPrevious : null,
                    icon: const Icon(Icons.chevron_left),
                    color: Colors.white,
                    disabledColor: Colors.white54,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 0.9,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.08, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: currentItem == null
                            ? const SizedBox.shrink()
                            : _RecipeCard(
                                key: ValueKey(currentItem.id),
                                item: currentItem,
                              ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: canGoNext ? _goToNext : null,
                    icon: const Icon(Icons.chevron_right),
                    color: Colors.white,
                    disabledColor: Colors.white54,
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(items.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == items.length - 1 ? 0 : 8,
                      ),
                      child: _buildDot(isActive: index == currentIndex),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.black : Colors.grey[300],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final HistoryItem item;

  const _RecipeCard({super.key, required this.item});

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label : ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.restaurant_menu,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInfoRow('料理名', item.title),
                  const SizedBox(height: 6),
                  _buildInfoRow('料理時間', item.cookTime),
                  const SizedBox(height: 6),
                  _buildInfoRow('料理コスト', item.cookCost),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
