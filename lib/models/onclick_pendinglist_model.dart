import 'dart:convert';

List<OnclickPendingListResponse> onclickPendingListResponseFromJson(String str) => List<OnclickPendingListResponse>.from(json.decode(str).map((x) => OnclickPendingListResponse.fromJson(x)));

String onclickPendingListResponseToJson(List<OnclickPendingListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class   OnclickPendingListResponse {
  OnclickPendingListResponse({
    this.id,
    this.appId,
    this.no,
    this.date,
    this.dueDate,
    this.projectName,
    this.siteName,
    this.accName,
    this.accType,
    this.supplierName,
    this.preparedBy,
    this.netAmt,
    this.frProjectName,
    this.toProjectId,
    this.toProjectName,
    this.type,
    this.potype,
    this.DprType,
    this.appNo,
    this.subContractorName,
    this.totNos,
    this.Payfor,
    this.ProjectId,
    this.SiteId,
    this.VerifiedBy,
    this.PreapprovedBy,
    this.req_remarks,
    this.app_remarks,
    this.delaydays,
    this.fromDate,
    this.toDate,
    this.billno,
    this.purchaseType,
    this.approvedby,
  });

  int? id;
  int? appId;
  String? no;
  String? date;
  String? dueDate;
  String? projectName;
  String? siteName;
  String? accName;
  String? accType;
  String? supplierName;
  String? preparedBy;
  double? netAmt;
  String? frProjectName;
  int? toProjectId;
  String? toProjectName;
  String? type;
  String? potype;
  int? DprType;
  String? appNo;
  String? subContractorName;
  double? totNos;
  String? Payfor;
  int? ProjectId;
  int? SiteId;
  String? VerifiedBy;
  String? PreapprovedBy;
  String? req_remarks;
  String? app_remarks;
  int? delaydays;
  String? fromDate;
  String? toDate;
  String? billno;
  String? purchaseType;
  String? approvedby;




  factory OnclickPendingListResponse.fromJson(Map<String, dynamic> json) => OnclickPendingListResponse(
    id: json["Id"],
    appId: json["AppId"],
    no: json["No"],
    date: json["Date"],
    dueDate: json["DueDate"],
    projectName: json["ProjectName"],
    siteName: json["SiteName"],
    accName: json["Acc_name"],
    accType: json["Acc_type"],
    supplierName: json["SupplierName"],
    preparedBy: json["PreparedBy"],
    netAmt: json["NetAmt"],
    frProjectName: json["FrProjectName"],
    toProjectId: json["ToProjectId"],
    toProjectName: json["ToProjectName"],
    type: json["Type"],
    DprType: json["DPRType"],
    appNo: json["AppNo"],
    subContractorName: json["SubContractorName"],
    totNos: json["TotNos"],
    Payfor: json["Payfor"],
    ProjectId: json["ProjectId"],
    SiteId: json["SiteId"],
    VerifiedBy: json["VerifiedBy"],
    PreapprovedBy: json["PreapprovedBy"],
    potype: json["PoType"],
    req_remarks: json["RequestRemarks"],
    app_remarks: json["AppRemarks"],
    delaydays: json["DelayDays"],
    fromDate: json["FromDate"],
    toDate: json["ToDate"],
    billno: json["Billno"],
    purchaseType: json["PurchaseType"],
    approvedby: json["approvedby"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "AppId": appId,
    "No": no,
    "Date": date,
    "DueDate": dueDate,
    "ProjectName": projectName,
    "SiteName": siteName,
    "Acc_name": accName,
    "Acc_type": accType,
    "SupplierName": supplierName,
    "PreparedBy": preparedBy,
    "NetAmt": netAmt,
    "FrProjectName": frProjectName,
    "ToProjectId": toProjectId,
    "ToProjectName": toProjectName,
    "Type": type,
    "DPRType": DprType,
    "AppNo": appNo,
    "SubContractorName": subContractorName,
    "TotNos": totNos,
    "Payfor": Payfor,
    "ProjectId": ProjectId,
    "SiteId": SiteId,
    "VerifiedBy": VerifiedBy,
    "PoType": potype,
    "RequestRemarks": req_remarks,
    "AppRemarks": app_remarks,
    "DelayDays": delaydays,
    "FromDate": fromDate,
    "ToDate": toDate,
    "Billno": billno,
    "approvedby": approvedby,
  };
}
