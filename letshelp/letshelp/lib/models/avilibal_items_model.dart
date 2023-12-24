// To parse this JSON data, do
//
//     final avilbaleItemsModel = avilbaleItemsModelFromMap(jsonString);

import 'dart:convert';

List<AvilbaleItemsModel> avilbaleItemsModelFromMap(String str) => List<AvilbaleItemsModel>.from(json.decode(str).map((x) => AvilbaleItemsModel.fromMap(x)));

String avilbaleItemsModelToMap(List<AvilbaleItemsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class AvilbaleItemsModel {
    AvilbaleItemsModel({
        this.id,
        this.name,
        this.icon,
        this.category,
    });

    int? id;
    String? name;
    String? icon;
    String? category;

    factory AvilbaleItemsModel.fromMap(Map<String, dynamic> json) => AvilbaleItemsModel(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        category: json["category"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "icon": icon,
        "category": category,
    };
}
