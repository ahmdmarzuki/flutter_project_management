class TimelineModel {
  final String title;
  final String description;

  TimelineModel({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
