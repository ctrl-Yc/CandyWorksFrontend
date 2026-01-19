class HistoryItem {
  final String id;
  final String title;
  final String date;
  final bool isFavorite;
  final String imageUrl;
  final String feedback;
  final String cookTime;
  final String cookCost;

  const HistoryItem({
    required this.id,
    required this.title,
    required this.date,
    required this.isFavorite,
    required this.imageUrl,
    required this.feedback,
    required this.cookTime,
    required this.cookCost,
  });
}
