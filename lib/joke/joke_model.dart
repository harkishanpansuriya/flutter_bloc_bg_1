class JokeModel {
  final String category;
  final String type;
  final String setup;
  final String delivery;

  JokeModel({
    required this.category,
    required this.type,
    required this.setup,
    required this.delivery,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) {
    return JokeModel(
      category: json['category'],
      type: json['type'],
      setup: json['setup'],
      delivery: json['delivery'],
    );
  }
}

JokeModel jokeModelFromJson(Map<String, dynamic> json) {
  return JokeModel(
    category: json['category'] ?? '',
    type: json['type'] ?? '',
    setup: json['setup'] ?? '',
    delivery: json['delivery'] ?? "",
  );
}
