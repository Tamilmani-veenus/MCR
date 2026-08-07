import 'dart:convert';

List<TransferBetSiteEntrylistResapi> transferBetSiteEntrylistResapiFromJson(String str) => List<TransferBetSiteEntrylistResapi>.from(json.decode(str).map((x) => TransferBetSiteEntrylistResapi.fromJson(x)));

String transferBetSiteEntrylistResapiToJson(List<TransferBetSiteEntrylistResapi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferBetSiteEntrylistResapi {
  TransferBetSiteEntrylistResapi({
    this.transferId,
    this.transferNo,
    this.exdate,
    this.edate,
    this.frProject,
    this.fromSite,
    this.toSite,
  });

  int? transferId;
  String? transferNo;
  String? exdate;
  String? edate;
  String? frProject;
  String? fromSite;
  String? toSite;

  factory TransferBetSiteEntrylistResapi.fromJson(Map<String, dynamic> json) => TransferBetSiteEntrylistResapi(
    transferId: json["Transfer_id"],
    transferNo: json["TransferNo"],
    exdate: json["Exdate"],
    edate: json["Edate"],
    frProject: json["FrProject"],
    fromSite: json["FromSite"],
    toSite: json["ToSite"],
  );

  Map<String, dynamic> toJson() => {
    "Transfer_id": transferId,
    "TransferNo": transferNo,
    "Exdate": exdate,
    "Edate": edate,
    "FrProject": frProject,
    "FromSite": fromSite,
    "ToSite": toSite,
  };
}
