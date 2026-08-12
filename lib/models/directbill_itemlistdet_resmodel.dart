import 'dart:convert';

List<BillDirectWorkOrdDet> billDirectWorkOrdDetFromJson(String str) => List<BillDirectWorkOrdDet>.from(json.decode(str).map((x) => BillDirectWorkOrdDet.fromJson(x)));

String billDirectWorkOrdDetToJson(List<BillDirectWorkOrdDet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillDirectWorkOrdDet {
  int? dworkDet_id;
  String? itemDesc;
  String? unit;
  double? qty;
  double? rate;
  double? amount;

  BillDirectWorkOrdDet({
    this.dworkDet_id,
    this.itemDesc,
    this.unit,
    this.qty,
    this.rate,
    this.amount,
  });

  factory BillDirectWorkOrdDet.fromJson(Map<String, dynamic> json) => BillDirectWorkOrdDet(
    dworkDet_id: json["dworkDet_id"],
    itemDesc: json["itemdesc"],
    unit: json["Unit"],
    qty: json["qty"],
    rate: json["Rate"],
    amount: json["Amt"],
  );

  Map<String, dynamic> toJson() => {
    "dworkDet_id": dworkDet_id,
    "itemdesc": itemDesc,
    "Unit": unit,
    "qty": qty,
    "Rate": rate,
    "Amt": amount,
  };
}