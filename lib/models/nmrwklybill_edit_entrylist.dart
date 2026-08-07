import 'dart:convert';

List<NmrEditResponse> nmrEditResponseFromJson(String str) => List<NmrEditResponse>.from(json.decode(str).map((x) => NmrEditResponse.fromJson(x)));

String nmrEditResponseToJson(List<NmrEditResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NmrEditResponse {
  NmrEditResponse({
    this.workId,
    this.workNo,
    this.workDate,
    this.projectId,
    this.siteId,
    this.subContId,
    this.projectName,
    this.siteName,
    this.subContName,
    this.entryType,
    this.fromDate,
    this.toDate,
    this.rndOff,
    this.billAmt,
    this.actAdvAmt,
    this.advAmt,
    this.netPayAmt,
    this.debitAmt,
    this.creditAmt,
    this.debitRemarks,
    this.creditRemarks,
    this.remarks,
    this.preparedby,
    this.preparedbyName,
    this.userId,
    this.entryMode,
    this.nmrBillDet,
  });

  int? workId;
  String? workNo;
  String? workDate;
  int? projectId;
  int? siteId;
  int? subContId;
  String? projectName;
  String? siteName;
  String? subContName;
  String? entryType;
  String? fromDate;
  String? toDate;
  double? rndOff;
  double? billAmt;
  double? actAdvAmt;
  double? advAmt;
  double? netPayAmt;
  double? debitAmt;
  double? creditAmt;
  String? debitRemarks;
  String? creditRemarks;
  String? remarks;
  int? preparedby;
  String? preparedbyName;
  String? userId;
  String? entryMode;
  List<NmrBillDet>? nmrBillDet;

  factory NmrEditResponse.fromJson(Map<String, dynamic> json) => NmrEditResponse(
    workId: json["WorkId"],
    workNo: json["WorkNo"],
    workDate: json["WorkDate"],
    projectId: json["ProjectId"],
    siteId: json["SiteId"],
    subContId: json["SubContId"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    subContName: json["SubContName"],
    entryType: json["EntryType"],
    fromDate: json["FromDate"],
    toDate: json["ToDate"],
    rndOff: json["RndOff"],
    billAmt: json["BillAmt"].toDouble(),
    actAdvAmt: json["ActAdvAmt"],
    advAmt: json["AdvAmt"],
    netPayAmt: json["NetPayAmt"],
    debitAmt: json["DebitAmt"],
    creditAmt: json["CreditAmt"],
    debitRemarks: json["DebitRemarks"],
    creditRemarks: json["CreditRemarks"],
    remarks: json["remarks"],
    preparedby: json["Preparedby"],
    preparedbyName: json["PreparedbyName"],
    userId: json["UserId"],
    entryMode: json["EntryMode"],
    nmrBillDet: List<NmrBillDet>.from(json["NMRBillDet"].map((x) => NmrBillDet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "WorkId": workId,
    "WorkNo": workNo,
    "WorkDate": workDate,
    "ProjectId": projectId,
    "SiteId": siteId,
    "SubContId": subContId,
    "ProjectName": projectName,
    "SiteName": siteName,
    "SubContName": subContName,
    "EntryType": entryType,
    "FromDate": fromDate,
    "ToDate": toDate,
    "RndOff": rndOff,
    "BillAmt": billAmt,
    "ActAdvAmt": actAdvAmt,
    "AdvAmt": advAmt,
    "NetPayAmt": netPayAmt,
    "DebitAmt": debitAmt,
    "CreditAmt": creditAmt,
    "DebitRemarks": debitRemarks,
    "CreditRemarks": creditRemarks,
    "remarks": remarks,
    "Preparedby": preparedby,
    "PreparedbyName": preparedbyName,
    "UserId": userId,
    "EntryMode": entryMode,
    "NMRBillDet": List<dynamic>.from(nmrBillDet!.map((x) => x.toJson())),
  };
}

class NmrBillDet {
  NmrBillDet({
    this.sno,
    this.siteName,
    this.categoryName,
    this.totnos,
    this.totalOtamt,
    this.categoryId,
    this.siteId,
    this.nmrAmt,
  });

  int? sno;
  String? siteName;
  String? categoryName;
  double? totnos;
  double? totalOtamt;
  int? categoryId;
  int? siteId;
  double? nmrAmt;

  factory NmrBillDet.fromJson(Map<String, dynamic> json) => NmrBillDet(
    sno: json["Sno"],
    siteName: json["SiteName"],
    categoryName: json["CategoryName"],
    totnos: json["totnos"],
    totalOtamt: json["total_otamt"],
    categoryId: json["CategoryId"],
    siteId: json["SiteId"],
    nmrAmt: json["NMRAMT"],
  );

  Map<String, dynamic> toJson() => {
    "Sno": sno,
    "SiteName": siteName,
    "CategoryName": categoryName,
    "totnos": totnos,
    "total_otamt": totalOtamt,
    "CategoryId": categoryId,
    "SiteId": siteId,
    "NMRAMT": nmrAmt,
  };
}
