// To parse this JSON data, do
//
//     final consumptionentrylist = consumptionentrylistFromJson(jsonString);

import 'dart:convert';

List<Consumptionentrylist> consumptionentrylistFromJson(String str) => List<Consumptionentrylist>.from(json.decode(str).map((x) => Consumptionentrylist.fromJson(x)));

String consumptionentrylistToJson(List<Consumptionentrylist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Consumptionentrylist {
  Consumptionentrylist({
    this.expenseId,
    this.expenseNo,
    this.project,
    this.site,
    this.exdate,
    this.entryType,
    this.preparedByName,
  });

  int? expenseId;
  String? expenseNo;
  String? project;
  String? site;
  String? exdate;
  String? entryType;
  String? preparedByName;

  factory Consumptionentrylist.fromJson(Map<String, dynamic> json) => Consumptionentrylist(
    expenseId: json["Expense_id"],
    expenseNo: json["Expense_No"],
    project: json["Project"],
    site: json["Site"],
    exdate: json["Exdate"],
    entryType: json["EntryType"],
    preparedByName: json["PreparedByName"],
  );

  Map<String, dynamic> toJson() => {
    "Expense_id": expenseId,
    "Expense_No": expenseNo,
    "Project": project,
    "Site": site,
    "Exdate": exdate,
    "EntryType": entryType,
    "PreparedByName": preparedByName,
  };
}
