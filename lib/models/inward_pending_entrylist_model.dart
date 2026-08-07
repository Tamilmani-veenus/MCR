import 'dart:convert';

List<Inwardentrylist> inwardentrylistFromJson(String str) => List<Inwardentrylist>.from(json.decode(str).map((x) => Inwardentrylist.fromJson(x)));

String inwardentrylistToJson(List<Inwardentrylist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Inwardentrylist {
  Inwardentrylist({
    this.inwardId,
    this.inwardNo,
    this.inwDate,
    this.project,
    this.supplier,
    this.edate,
    this.siteName,
    this.partyDcNo,
    this.manualInwardNo,
    this.purOrdNo,
    this.inwType,
    this.inwtype,
    this.poid,
    this.invoiceno,
    this.invoicedate,
    this.preparedByName,
  });

  int? inwardId;
  String? inwardNo;
  String? inwDate;
  String? project;
  String? supplier;
  String? edate;
  String? siteName;
  String? partyDcNo;
  String? manualInwardNo;
  String? purOrdNo;
  String? inwType;
  String? inwtype;
  int? poid;
  String? invoiceno;
  String? invoicedate;
  String? preparedByName;

  factory Inwardentrylist.fromJson(Map<String, dynamic> json) => Inwardentrylist(
    inwardId: json["Inward_id"],
    inwardNo: json["Inward_No"],
    inwDate: json["InwDate"],
    project: json["Project"],
    supplier: json["supplier"],
    edate:  json["Edate"],
    siteName: json["SiteName"],
    partyDcNo: json["PartyDcNo"],
    manualInwardNo: json["ManualInwardNo"],
    purOrdNo: json["Pur_ord_No"],
    inwType: json["Inw_type"],
    inwtype:json["Inwtype"],
    poid: json["POID"],
    invoiceno: json["invoiceno"],
    invoicedate: json["invoicedate"],
    preparedByName: json["PreparedByName"],
  );

  Map<String, dynamic> toJson() => {
    "Inward_id": inwardId,
    "Inward_No": inwardNo,
    "InwDate": inwDate,
    "Project": project,
    "supplier": supplier,
    "Edate": edate,
    "SiteName": siteName,
    "PartyDcNo": partyDcNo,
    "ManualInwardNo": manualInwardNo,
    "Pur_ord_No": purOrdNo,
    "Inw_type": inwType,
    "Inwtype": inwtype,
    "POID": poid,
    "invoiceno": invoiceno,
    "invoicedate": invoicedate,
    "invoicedate": invoicedate,
    "PreparedByName": preparedByName,
  };
}
