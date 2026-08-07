// To parse this JSON data, do
//
//     final supplierDropdownResponse = supplierDropdownResponseFromJson(jsonString);

import 'dart:convert';

List<SupplierDropdownResponse> supplierDropdownResponseFromJson(String str) => List<SupplierDropdownResponse>.from(json.decode(str).map((x) => SupplierDropdownResponse.fromJson(x)));

String supplierDropdownResponseToJson(List<SupplierDropdownResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupplierDropdownResponse {
  SupplierDropdownResponse({
    this.supplierId,
    this.supplierName,
  });

  int? supplierId;
  String? supplierName;

  factory SupplierDropdownResponse.fromJson(Map<String, dynamic> json) => SupplierDropdownResponse(
    supplierId: json["SupplierId"],
    supplierName: json["SupplierName"],
  );

  Map<String, dynamic> toJson() => {
    "SupplierId": supplierId,
    "SupplierName": supplierName,
  };
}
