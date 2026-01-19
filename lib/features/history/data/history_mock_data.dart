import '../models/history_item.dart';

class HistoryMockData {
  static const List<HistoryItem> cookedItems = [
    HistoryItem(
      id: 'cooked-1',
      title: 'しょうが焼き',
      date: 'YYYY/MM/DD',
      isFavorite: false,
      imageUrl:
          'https://images.unsplash.com/photo-1604909052743-94e838986d24',
    ),
    HistoryItem(
      id: 'cooked-2',
      title: 'ハンバーグ',
      date: 'YYYY/MM/DD',
      isFavorite: true,
      imageUrl:
          'https://images.unsplash.com/photo-1604908177522-2a74b3dcb59d',
    ),
  ];

  static const List<HistoryItem> favoriteItems = [
    HistoryItem(
      id: 'favorite-1',
      title: 'ハンバーグ',
      date: 'YYYY/MM/DD',
      isFavorite: true,
      imageUrl:
          'https://images.unsplash.com/photo-1604908177522-2a74b3dcb59d',
    ),
  ];
}
