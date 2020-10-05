// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String title;
  double prize;
  bool avaliable;
  String urlPhoto;
  ProductModel({
    this.id,
    this.title = '',
    this.prize = 0.0,
    this.avaliable = true,
    this.urlPhoto,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        prize: json["prize"].toDouble(),
        avaliable: json["avaliable"],
        urlPhoto: json["url_photo"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "prize": prize,
        "avaliable": avaliable,
        "url_photo": urlPhoto,
      };
}
