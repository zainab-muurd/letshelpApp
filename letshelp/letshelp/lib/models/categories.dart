class Categories {
  Categories({
    required this.id,
    required this.name,
    required this.icon,
  });

  int? id;
  String? name;
  String? icon;

  factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "icon": icon,
      };
}
