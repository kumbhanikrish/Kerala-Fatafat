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
  final bool isEligibleSingle;
  final bool isEligiblePatti;

  Slot({
    required this.isEligibleSingle,
    required this.time,
    required this.status,
    required this.isEligiblePatti,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    time: json["time"],

    status: json["status"],
    isEligibleSingle: json["is_eligible_single"],
    isEligiblePatti: json["is_eligible_patti"],
  );
}
