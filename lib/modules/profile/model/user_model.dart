class UserModel {
  final String token;
  final User user;
  final System system;

  UserModel({required this.token, required this.user, required this.system});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    token: json["token"],
    user: User.fromJson(json["user"]),
    system: System.fromJson(json["system"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
    "system": system.toJson(),
  };
}

class System {
  final String phoneNumber;
  final String wpPhoneNumber;

  System({required this.phoneNumber, required this.wpPhoneNumber});

  factory System.fromJson(Map<String, dynamic> json) => System(
    phoneNumber: json["phone_number"] ?? '',
    wpPhoneNumber: json["wp_phone_number"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "wp_phone_number": wpPhoneNumber,
  };
}

class User {
  final int id;
  final String name;
  final String phone;
  final String email;
  final dynamic emailVerifiedAt;
  final String fcmToken;
  final String referralCode;
  final int isActive;
  final BankDetails bankDetails;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.emailVerifiedAt,
    required this.fcmToken,
    required this.isActive,
    required this.bankDetails,
    required this.referralCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    fcmToken: json["fcm_token"],
    isActive: json["is_active"],
    referralCode: json["referal_code"] ?? '',
    bankDetails:
        json["bank_details"] == null
            ? BankDetails(
              bankName: '',
              accountNumber: '',
              ifscCode: '',
              accountHolderName: '',
              upiId: '',
            )
            : BankDetails.fromJson(json["bank_details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "fcm_token": fcmToken,
    "is_active": isActive,
    "referal_code": referralCode,
    "bank_details": bankDetails,
  };
}

class BankDetails {
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String accountHolderName;
  final String upiId;

  BankDetails({
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.accountHolderName,
    required this.upiId,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
    bankName: json["bank_name"] ?? '',
    accountNumber: json["account_number"] ?? '',
    ifscCode: json["ifsc_code"] ?? '',
    accountHolderName: json["account_holder_name"] ?? '',
    upiId: json["upi"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "bank_name": bankName,
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
    "account_holder_name": accountHolderName,
    "upi": upiId,
  };
}
