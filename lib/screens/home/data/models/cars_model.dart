class Cars {
  Cars({required this.model, required this.brand});

  Cars.fromJson(Map<String, Object?> json)
      : this(
          brand: json['brand']! as String,
          model: json['model']! as String,
        );

  String? model;
  String? brand;

  Map<String, Object?> toJson() {
    return {
      'model': model,
      'brand': brand,
    };
  }
}
