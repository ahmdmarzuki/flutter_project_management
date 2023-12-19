class ProjectModel {
  final String title;
  final String description;
  final DateTime createdAt;
  final Map<String, dynamic> timeline;

  ProjectModel(
      {required this.title,
      required this.description,
      required this.createdAt,
      required this.timeline});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'timeline': timeline
    };
  }
}
