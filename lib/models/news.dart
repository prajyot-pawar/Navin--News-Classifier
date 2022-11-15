final String tableNews = 'news';

class NewsFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, number, title, description, time
  ];

  static final String id = 'id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class News {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const News({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  News copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      News(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static News fromJson(Map<String, Object?> json) => News(
    id: json[NewsFields.id] as int?,
    isImportant: json[NewsFields.isImportant] == 1,
    number: json[NewsFields.number] as int,
    title: json[NewsFields.title] as String,
    description: json[NewsFields.description] as String,
    createdTime: DateTime.parse(json[NewsFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    NewsFields.id: id,
    NewsFields.title: title,
    NewsFields.isImportant: isImportant ? 1 : 0,
    NewsFields.number: number,
    NewsFields.description: description,
    NewsFields.time: createdTime.toIso8601String(),
  };
}
