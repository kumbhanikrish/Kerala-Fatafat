class BidHistoryModel {
  final int id;
  final int userId;
  final int gameId;
  final int digit;
  final String amount;
  final String timeSlot;
  final dynamic winStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  BidHistoryModel({
    required this.id,
    required this.userId,
    required this.gameId,
    required this.digit,
    required this.amount,
    required this.timeSlot,
    required this.winStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BidHistoryModel.fromJson(Map<String, dynamic> json) =>
      BidHistoryModel(
        id: json["id"],
        userId: json["user_id"],
        gameId: json["game_id"],
        digit: json["digit"],
        amount: json["amount"],
        timeSlot: json["time_slot"],
        winStatus: json["win_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "game_id": gameId,
    "digit": digit,
    "amount": amount,
    "time_slot": timeSlot,
    "win_status": winStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
