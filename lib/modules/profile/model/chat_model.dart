class ChatModel {
  final int id;
  final int userId;
  final int adminId;
  final String message;
  final int isAdminReply;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatModel({
    required this.id,
    required this.userId,
    required this.adminId,
    required this.message,
    required this.isAdminReply,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    id: json["id"],
    userId: json["user_id"],
    adminId: json["admin_id"] ?? 0,
    message: json["message"],
    isAdminReply: json["is_admin_reply"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "admin_id": adminId,
    "message": message,
    "is_admin_reply": isAdminReply,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
