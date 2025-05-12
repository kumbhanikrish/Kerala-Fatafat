class ResultModel {
  final String date;
  final List<Session> session;

  ResultModel({required this.date, required this.session});

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
    date: json["date"],
    session: List<Session>.from(
      json["session"].map((x) => Session.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "session": List<dynamic>.from(session.map((x) => x.toJson())),
  };
}

class Session {
  final String session;
  final dynamic winNumber;
  final dynamic winPattiNumber;
  final int totalWinners;

  Session({
    required this.session,
    required this.winNumber,
    required this.winPattiNumber,
    required this.totalWinners,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    session: json["session"],
    winNumber: json["win_number"],
    winPattiNumber: json["win_patti_number"],
    totalWinners: json["total_winners"],
  );

  Map<String, dynamic> toJson() => {
    "session": session,
    "win_number": winNumber,
    "win_patti_number": winPattiNumber,
    "total_winners": totalWinners,
  };
}
