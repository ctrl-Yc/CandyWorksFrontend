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
      feedback: 'タレの濃さが良く、ご飯が進みました。',
      cookTime: '20分~25分',
      cookCost: '230~250円',
    ),
    HistoryItem(
      id: 'cooked-2',
      title: 'ハンバーグ',
      date: 'YYYY/MM/DD',
      isFavorite: true,
      imageUrl:
          'https://images.unsplash.com/photo-1604908177522-2a74b3dcb59d',
      feedback: '焼き加減がちょうどよく、肉汁がジューシーでした。',
      cookTime: '25分~30分',
      cookCost: '300~350円',
    ),
    HistoryItem(
      id: 'cooked-3',
      title: '親子丼',
      date: 'YYYY/MM/DD',
      isFavorite: false,
      imageUrl:
          'https://images.unsplash.com/photo-1604908812857-6a104bfe0f1a',
      feedback: '卵がふわっとしていて食べやすかったです。',
      cookTime: '15分~20分',
      cookCost: '200~230円',
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
      feedback: 'ソースが絶品でまた作りたいです。',
      cookTime: '25分~30分',
      cookCost: '300~350円',
    ),
  ];

  static List<HistoryItem> get homeItems => cookedItems;
}
