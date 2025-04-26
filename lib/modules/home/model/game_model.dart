class GamesModel {
  final int id;
  final String name;
  final String minBet;
  final String maxBet;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  GamesModel({
    required this.id,
    required this.name,
    required this.minBet,
    required this.maxBet,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GamesModel.fromJson(Map<String, dynamic> json) => GamesModel(
    id: json["id"],
    name: json["name"],
    minBet: json["min_bet"],
    maxBet: json["max_bet"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
