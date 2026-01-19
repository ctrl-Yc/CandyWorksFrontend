class HistoryItem {
  final String id;
  final String title;
  final String date;
  final bool isFavorite;
  final String imageUrl;

  const HistoryItem({
    required this.id,
    required this.title,
    required this.date,
    required this.isFavorite,
    required this.imageUrl,
  });
}
