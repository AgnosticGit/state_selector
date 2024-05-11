class CountryModel {
  const CountryModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
