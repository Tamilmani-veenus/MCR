import 'dart:convert';

List<TransferbetItemListApiRes> transferbetItemListApiResFromJson(String str) => List<TransferbetItemListApiRes>.from(json.decode(str).map((x) => TransferbetItemListApiRes.fromJson(x)));

String transferbetItemListApiResToJson(List<TransferbetItemListApiRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferbetItemListApiRes {

  TransferbetItemListApiRes({
    this.materialId,
    this.material,
    this.scale,
    this.stockQty,
    this.qty,
    this.balQty,
    this.reqDetId,
  });

  int? materialId;
  String? material;
  String? scale;
  double? stockQty;
  double? qty;
  double? balQty;
  int? reqDetId;
  bool? check=false;

  factory TransferbetItemListApiRes.fromJson(Map<String, dynamic> json) => TransferbetItemListApiRes(
    materialId: json["MaterialId"],
    material: json["Material"],
    scale: json["Scale"],
    stockQty: json["StockQty"],
    qty: json["trans_Qty"],
    balQty: json["BalQty"],
    reqDetId: json["req_mas_det_id"],
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "Material": material,
    "Scale": scale,
    "StockQty": stockQty,
    "trans_Qty": qty,
    "BalQty": balQty,
    "req_mas_det_id": reqDetId,
  };
}
