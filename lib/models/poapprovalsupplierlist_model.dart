// To parse this JSON data, do
//
//     final poapprovalSupplierbuilldlListModel = poapprovalSupplierbuilldlListModelFromJson(jsonString);

import 'dart:convert';

List<PoapprovalSupplierbuilldlListModel> poapprovalSupplierbuilldlListModelFromJson(String str) => List<PoapprovalSupplierbuilldlListModel>.from(json.decode(str).map((x) => PoapprovalSupplierbuilldlListModel.fromJson(x)));

String poapprovalSupplierbuilldlListModelToJson(List<PoapprovalSupplierbuilldlListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoapprovalSupplierbuilldlListModel {
  int supplierid;
  String supplier;
  double rate;
  String billdate;

  PoapprovalSupplierbuilldlListModel({
    required this.supplierid,
    required this.supplier,
    required this.rate,
    required this.billdate,
  });

  factory PoapprovalSupplierbuilldlListModel.fromJson(Map<String, dynamic> json) => PoapprovalSupplierbuilldlListModel(
    supplierid: json["supplierid"],
    supplier: json["supplier"],
    rate: json["rate"]?.toDouble(),
    billdate: json["billdate"],
  );

  Map<String, dynamic> toJson() => {
    "supplierid": supplierid,
    "supplier": supplier,
    "rate": rate,
    "billdate": billdate,
  };
}
