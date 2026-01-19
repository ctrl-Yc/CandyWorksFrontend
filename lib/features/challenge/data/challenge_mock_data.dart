import '../models/challenge_category.dart';

class ChallengeMockData {
  static const List<ChallengeCategory> categories = [
    ChallengeCategory(
      id: 'cut_meat',
      label: '切り方(肉)',
      iconPath: 'assets/Kawaii Steak.png',
      skills: [
        'そぎ切り',
        '一口カット切り',
        '角切り',
        '薄切り',
        '細切り',
        '観音開き',
      ],
    ),
    ChallengeCategory(
      id: 'cut_veg',
      label: '切り方(野菜)',
      iconPath: 'assets/Broccoli.png',
      skills: [
        '千切り',
        'みじん切り',
        '乱切り',
        'いちょう切り',
        '短冊切り',
        '輪切り',
      ],
    ),
    ChallengeCategory(
      id: 'heat',
      label: '加熱',
      iconPath: 'assets/Local fire department.png',
      skills: [
        '弱火',
        '中火',
        '強火',
        '炒める',
        '煮る',
        '蒸す',
      ],
    ),
  ];
}
