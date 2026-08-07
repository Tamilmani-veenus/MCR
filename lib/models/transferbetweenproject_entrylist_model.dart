import 'dart:convert';

List<TransferBProjectentrylist> transferBProjectentrylistFromJson(String str) => List<TransferBProjectentrylist>.from(json.decode(str).map((x) => TransferBProjectentrylist.fromJson(x)));

String transferBProjectentrylistToJson(List<TransferBProjectentrylist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferBProjectentrylist {
  TransferBProjectentrylist({
    this.transferId,
    this.transferNo,
    this.ackStatus,
    this.exdate,
    this.edate,
    this.frProject,
    this.fromSite,
    this.toProject,
    this.entryType,
    this.entryTypeName,
    this.preparedByName,
  });

  int? transferId;
  String? transferNo;
  String? exdate;
  String? ackStatus;
  String? edate;
  String? frProject;
  String? fromSite;
  String? toProject;
  String? entryType;
  String? entryTypeName;
  String? preparedByName;

  factory TransferBProjectentrylist.fromJson(Map<String, dynamic> json) => TransferBProjectentrylist(
    transferId: json["Transfer_id"],
    transferNo: json["TransferNo"],
    ackStatus: json["AckStatus"],
    exdate: json["Exdate"],
    edate: json["Edate"],
    frProject: json["FrProject"],
    fromSite: json["FromSite"],
    toProject: json["ToProject"],
    entryType: json["Entry_Type"],
    entryTypeName: json["EntryTypeName"],
    preparedByName: json["PreparedByName"],
  );

  Map<String, dynamic> toJson() => {
    "Transfer_id": transferId,
    "TransferNo": transferNo,
    "AckStatus": ackStatus,
    "Exdate": exdate,
    "Edate": edate,
    "FrProject": frProject,
    "FromSite": fromSite,
    "ToProject": toProject,
    "Entry_Type": entryType,
    "EntryTypeName": entryTypeName,
    "PreparedByName": preparedByName,
  };
}
