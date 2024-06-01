class IndicatorModel {
  final int id;
  final String name;
  int? band;
  int? period;

  IndicatorModel({
    required this.id,
    required this.name,
    this.band,
    this.period,
  });

  factory IndicatorModel.fromJson(Map<String, dynamic> json) {
    return IndicatorModel(
      id: json['id'],
      name: json['name'],
      band: json['band'] ?? 0,
      period: json['period'] ?? 0,
    );
  }
}
