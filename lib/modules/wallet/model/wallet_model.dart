class WalletModel {
  final String walletBalance;
  final List<Transaction> transactions;

  WalletModel({required this.walletBalance, required this.transactions});

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    walletBalance: json["wallet_balance"],
    transactions: List<Transaction>.from(
      json["transactions"].map((x) => Transaction.fromJson(x)),
    ),
  );
}

class Transaction {
  final String uuid;
  final String type;
  final dynamic amount;
  final dynamic transactionId;
  final dynamic photo;
  final String status;
  final String note;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.uuid,
    required this.type,
    required this.amount,
    required this.transactionId,
    required this.photo,
    required this.status,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    uuid: json["uuid"],
    type: json["type"],
    amount: json["amount"],
    transactionId: json["transaction_id"] ?? '',
    photo: json["photo"] ?? '',
    status: json["status"],
    note: json["note"] ?? '',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
