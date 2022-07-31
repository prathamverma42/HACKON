class Review {
  final String reviewer;
  final String rating;
  final DateTime dateTime;
  final String text;
  final String imgUrl;

  Review(
      {required this.reviewer,
      required this.rating,
      required this.dateTime,
      required this.text,
      required this.imgUrl});
}
