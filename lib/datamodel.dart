class BMiMODEL {
  final int? id;
  final int height;
  final int weight;
  final String bmi;

  BMiMODEL(
      {this.id,
      required this.height,
      required this.weight,
      required this.bmi,});

  BMiMODEL.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        height = res["height"],
        weight = res["weight"],
        bmi = res["bmi"];

  Map<String, Object> toMap() {
  if (id != null) {
    return {
      "id": id!,
      "height": height,
      "weight": weight,
      "bmi": bmi,
    };
  } else {
    return {
      "height": height,
      "weight": weight,
      "bmi": bmi,
    };
  }
}
}
