class GamesSlotsModel {
  final List<Slot> slots;

  GamesSlotsModel({required this.slots});

  factory GamesSlotsModel.fromJson(Map<String, dynamic> json) =>
      GamesSlotsModel(
        slots:
            json["slots"] == null
                ? []
                : List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
      );
}

class Slot {
  final String time;
  final String status;
  final bool isEligible;

  Slot({required this.isEligible, required this.time, required this.status});

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    time: json["time"],

    status: json["status"],
    isEligible: json["is_eligible"],
  );
}
