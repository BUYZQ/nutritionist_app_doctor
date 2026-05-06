class FoodDetails {
  final String title;
  final String? subtitle;
  final String desc;
  final DateTime dateTime;
  final List<String> foodDetails;

  FoodDetails({
    required this.title,
    this.subtitle,
    required this.desc,
    required this.dateTime,
    required this.foodDetails,
  });
}
