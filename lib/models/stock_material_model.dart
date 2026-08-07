// To parse this JSON data, do
//
//     final stockmaterial = stockmaterialFromJson(jsonString);

import 'dart:convert';

List<Stockmaterial> stockmaterialFromJson(String str) => List<Stockmaterial>.from(json.decode(str).map((x) => Stockmaterial.fromJson(x)));

String stockmaterialToJson(List<Stockmaterial> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stockmaterial {
  Stockmaterial({
    this.materialId,
    this.material,
    this.scale,
    this.stockQty,
  });

  int? materialId;
  String? material;
  String? scale;
  double? stockQty;
  bool? check=false;

  factory Stockmaterial.fromJson(Map<String, dynamic> json) => Stockmaterial(
    materialId: json["MaterialId"],
    material: json["Material"],
    scale: json["Scale"],
    stockQty: json["StockQty"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "Material": material,
    "Scale": scale,
    "StockQty": stockQty,
  };
}