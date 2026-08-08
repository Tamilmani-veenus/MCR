// To parse this JSON data, do
//
//     final billDirectDetCalculations = billDirectDetCalculationsFromJson(jsonString);

import 'dart:convert';

List<BillDirectDetCalculations> billDirectDetCalculationsFromJson(String str) => List<BillDirectDetCalculations>.from(json.decode(str).map((x) => BillDirectDetCalculations.fromJson(x)));

String billDirectDetCalculationsToJson(List<BillDirectDetCalculations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillDirectDetCalculations {
  int? id;
  String? addLessName;
  String? addLessType;
  double? per;
  double? amount;

  BillDirectDetCalculations({
    this.id,
    this.addLessName,
    this.addLessType,
    this.per,
    this.amount,
  });

  factory BillDirectDetCalculations.fromJson(Map<String, dynamic> json) => BillDirectDetCalculations(
    id: json["add_less_id"],
    addLessName: json["particular"],
    addLessType: json["add_less"],
    per: json["per"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "add_less_id": id,
    "particular": addLessName,
    "add_less": addLessType,
    "per": per,
    "amount": amount,
  };
}
