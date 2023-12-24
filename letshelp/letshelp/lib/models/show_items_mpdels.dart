// To parse this JSON data, do
//
//     final showItemModel = showItemModelFromMap(jsonString);

import 'dart:convert';

List<ShowItemModel> showItemModelFromMap(String str) => List<ShowItemModel>.from(json.decode(str).map((x) => ShowItemModel.fromMap(x)));

String showItemModelToMap(List<ShowItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ShowItemModel {
    ShowItemModel({
        this.id,
        this.title,
        this.description,
        this.mainImage,
        this.clientName,
        this.clientImage,
        this.cateagory,
        this.images,
    });

    int? id;
    String? title;
    String? description;
    String? mainImage;
    String? clientName;
    String? clientImage;
    String? cateagory;
    List<Image>? images;

    factory ShowItemModel.fromMap(Map<String, dynamic> json) => ShowItemModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        mainImage: json["mainImage"],
        clientName: json["clientName"],
        clientImage: json["clientImage"],
        cateagory: json["cateagory"],
        images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "mainImage": mainImage,
        "clientName": clientName,
        "clientImage": clientImage,
        "cateagory": cateagory,
        "images": List<dynamic>.from(images!.map((x) => x.toMap())),
    };
}

class Image {
    Image({
        this.id,
        this.path,
    });

    int? id;
    String? path;

    factory Image.fromMap(Map<String, dynamic> json) => Image(
        id: json["id"],
        path: json["path"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "path": path,
    };
}
