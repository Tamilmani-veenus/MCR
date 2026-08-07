// To parse this JSON data, do
//
//     final mrnReqTrackerListModel = mrnReqTrackerListModelFromJson(jsonString);

import 'dart:convert';

MrnReqTrackerListModel mrnReqTrackerListModelFromJson(String str) => MrnReqTrackerListModel.fromJson(json.decode(str));

String mrnReqTrackerListModelToJson(MrnReqTrackerListModel data) => json.encode(data.toJson());

class MrnReqTrackerListModel {
  bool? success;
  String? message;
  List<ReqTrackResult>? result;

  MrnReqTrackerListModel({
    this.success,
    this.message,
    this.result,
  });

  factory MrnReqTrackerListModel.fromJson(Map<String, dynamic> json) => MrnReqTrackerListModel(
    success: json["Success"],
    message: json["message"],
    result: json["Result"]==null?[]:List<ReqTrackResult>.from(json["Result"].map((x) => ReqTrackResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "message": message,
    "Result": result==null?[]:List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class ReqTrackResult {
  int? sno;
  int? projectId;
  String? projectName;
  int? siteId;
  String? siteName;
  int? reqOrdMasid;
  String? reqOrdNo;
  String? reqOrdDate;
  String? reqdueDate;
  int? reqDetId;
  int? materialid;
  String? materialName;
  String? scaleName;
  double? mrnReqQty;
  double? mrnAppQty;
  int? mrnCreatedBy;
  String? mrnCreatedByName;
  String? mrnCreatedTime;
  int? mrnVerifyBy;
  String? mrnVerifyByName;
  String? verifyStatus;
  String? mrNverifyDate;
  String? mrNverifyTime;
  int? mrnPreApproveBy;
  String? mrnPreApprovedByName;
  String? mrnPreApproveDate;
  String? mrnPreApproveTime;
  String? preApproveStatus;
  int? mrngmApproveBy;
  String? mrngmApprovedByName;
  String? mrngmApproveDate;
  String? mrngmApproveTime;
  String? mrngmApproveStatus;
  int? mrnApprovedBy;
  String? mrnApprovedByName;
  String? mrnApprovedDate;
  String? mrnApprovedTime;
  String? approveStatus;
  int? materialReqOrdMasId;
  int? materialReqOrdDetId;
  int? materialPurOrdMasId;
  String? purchaseOrdNo;
  String? purchaseOrdDate;
  int? materialPurOrdDetId;
  double? poQty;
  int? poCreatedBy;
  String? poCreatedByName;
  int? poVerifyBy;
  String? poVerifyByName;
  String? poVerifyDate;
  String? poVerifyStatus;
  int? poApprovedBy;
  String? poApprovedByName;
  String? poApprovedDate;
  String? poApproveStatus;
  int? inwardMasId;
  String? inwardNo;
  String? grNdate;
  int? purOrdMasId;
  String? invoiceNo;
  String? invoiceDate;
  int? inwardDetId;
  int? purOrdDetId;
  double? grnQty;
  int? grnCreatedBy;
  String? grnCreatedByName;

  ReqTrackResult({
    this.sno,
    this.projectId,
    this.projectName,
    this.siteId,
    this.siteName,
    this.reqOrdMasid,
    this.reqOrdNo,
    this.reqOrdDate,
    this.reqdueDate,
    this.reqDetId,
    this.materialid,
    this.materialName,
    this.scaleName,
    this.mrnReqQty,
    this.mrnAppQty,
    this.mrnCreatedBy,
    this.mrnCreatedByName,
    this.mrnCreatedTime,
    this.mrnVerifyBy,
    this.mrnVerifyByName,
    this.verifyStatus,
    this.mrNverifyDate,
    this.mrNverifyTime,
    this.mrnPreApproveBy,
    this.mrnPreApprovedByName,
    this.mrnPreApproveDate,
    this.mrnPreApproveTime,
    this.preApproveStatus,
    this.mrngmApproveBy,
    this.mrngmApprovedByName,
    this.mrngmApproveDate,
    this.mrngmApproveTime,
    this.mrngmApproveStatus,
    this.mrnApprovedBy,
    this.mrnApprovedByName,
    this.mrnApprovedDate,
    this.mrnApprovedTime,
    this.approveStatus,
    this.materialReqOrdMasId,
    this.materialReqOrdDetId,
    this.materialPurOrdMasId,
    this.purchaseOrdNo,
    this.purchaseOrdDate,
    this.materialPurOrdDetId,
    this.poQty,
    this.poCreatedBy,
    this.poCreatedByName,
    this.poVerifyBy,
    this.poVerifyByName,
    this.poVerifyDate,
    this.poVerifyStatus,
    this.poApprovedBy,
    this.poApprovedByName,
    this.poApprovedDate,
    this.poApproveStatus,
    this.inwardMasId,
    this.inwardNo,
    this.grNdate,
    this.purOrdMasId,
    this.invoiceNo,
    this.invoiceDate,
    this.inwardDetId,
    this.purOrdDetId,
    this.grnQty,
    this.grnCreatedBy,
    this.grnCreatedByName,
  });

  factory ReqTrackResult.fromJson(Map<String, dynamic> json) => ReqTrackResult(
    sno: json["SNO"],
    projectId: json["ProjectId"],
    projectName: json["ProjectName"],
    siteId: json["SiteId"],
    siteName: json["SiteName"],
    reqOrdMasid: json["ReqOrdMasid"],
    reqOrdNo: json["ReqOrdNo"],
    reqOrdDate: json["ReqOrdDate"],
    reqdueDate: json["ReqdueDate"],
    reqDetId: json["ReqDetId"],
    materialid: json["Materialid"],
    materialName: json["MaterialName"],
    scaleName: json["ScaleName"],
    mrnReqQty: json["MRNReqQty"],
    mrnAppQty: json["MRNAppQty"],
    mrnCreatedBy: json["MRNCreatedBy"],
    mrnCreatedByName: json["MRNCreatedByName"],
    mrnCreatedTime: json["MRNCreatedTime"],
    mrnVerifyBy: json["MRNVerifyBy"],
    mrnVerifyByName: json["MRNVerifyByName"],
    verifyStatus: json["VerifyStatus"],
    mrNverifyDate: json["MRNverifyDate"],
    mrNverifyTime: json["MRNverifyTime"],
    mrnPreApproveBy: json["MRNPreApproveBy"],
    mrnPreApprovedByName: json["MRNPreApprovedByName"],
    mrnPreApproveDate: json["MRNPreApproveDate"],
    mrnPreApproveTime: json["MRNPreApproveTime"],
    preApproveStatus: json["PreApproveStatus"],
    mrngmApproveBy: json["MRNGMApproveBy"],
    mrngmApprovedByName: json["MRNGMApprovedByName"],
    mrngmApproveDate: json["MRNGMApproveDate"],
    mrngmApproveTime: json["MRNGMApproveTime"],
    mrngmApproveStatus: json["MRNGMApproveStatus"],
    mrnApprovedBy: json["MRNApprovedBy"],
    mrnApprovedByName: json["MRNApprovedByName"],
    mrnApprovedDate: json["MRNApprovedDate"],
    mrnApprovedTime: json["MRNApprovedTime"],
    approveStatus: json["ApproveStatus"],
    materialReqOrdMasId: json["MaterialReqOrdMasId"],
    materialReqOrdDetId: json["MaterialReqOrdDetId"],
    materialPurOrdMasId: json["MaterialPurOrdMasId"],
    purchaseOrdNo: json["PurchaseOrdNo"],
    purchaseOrdDate: json["PurchaseOrdDate"],
    materialPurOrdDetId: json["MaterialPurOrdDetId"],
    poQty: json["POQty"],
    poCreatedBy: json["POCreatedBy"],
    poCreatedByName: json["POCreatedByName"],
    poVerifyBy: json["POVerifyBy"],
    poVerifyByName: json["POVerifyByName"],
    poVerifyDate: json["POVerifyDate"],
    poVerifyStatus: json["POVerifyStatus"],
    poApprovedBy: json["POApprovedBy"],
    poApprovedByName: json["POApprovedByName"],
    poApprovedDate: json["POApprovedDate"],
    poApproveStatus: json["PoApproveStatus"],
    inwardMasId: json["InwardMasID"],
    inwardNo: json["InwardNo"],
    grNdate: json["GRNdate"],
    purOrdMasId: json["PurOrdMasId"],
    invoiceNo: json["InvoiceNo"],
    invoiceDate: json["InvoiceDate"],
    inwardDetId: json["InwardDetID"],
    purOrdDetId: json["PurOrdDetId"],
    grnQty: json["GRNQty"],
    grnCreatedBy: json["GRNCreatedBy"],
    grnCreatedByName: json["GRNCreatedByName"],
  );

  Map<String, dynamic> toJson() => {
    "SNO": sno,
    "ProjectId": projectId,
    "ProjectName": projectName,
    "SiteId": siteId,
    "SiteName": siteName,
    "ReqOrdMasid": reqOrdMasid,
    "ReqOrdNo": reqOrdNo,
    "ReqOrdDate": reqOrdDate,
    "ReqdueDate": reqdueDate,
    "ReqDetId": reqDetId,
    "Materialid": materialid,
    "MaterialName": materialName,
    "ScaleName": scaleName,
    "MRNReqQty": mrnReqQty,
    "MRNAppQty": mrnAppQty,
    "MRNCreatedBy": mrnCreatedBy,
    "MRNCreatedByName": mrnCreatedByName,
    "MRNCreatedTime": mrnCreatedTime,
    "MRNVerifyBy": mrnVerifyBy,
    "MRNVerifyByName": mrnVerifyByName,
    "VerifyStatus": verifyStatus,
    "MRNverifyDate": mrNverifyDate,
    "MRNverifyTime": mrNverifyTime,
    "MRNPreApproveBy": mrnPreApproveBy,
    "MRNPreApprovedByName": mrnPreApprovedByName,
    "MRNPreApproveDate": mrnPreApproveDate,
    "MRNPreApproveTime": mrnPreApproveTime,
    "PreApproveStatus": preApproveStatus,
    "MRNGMApproveBy": mrngmApproveBy,
    "MRNGMApprovedByName": mrngmApprovedByName,
    "MRNGMApproveDate": mrngmApproveDate,
    "MRNGMApproveTime": mrngmApproveTime,
    "MRNGMApproveStatus": mrngmApproveStatus,
    "MRNApprovedBy": mrnApprovedBy,
    "MRNApprovedByName": mrnApprovedByName,
    "MRNApprovedDate": mrnApprovedDate,
    "MRNApprovedTime": mrnApprovedTime,
    "ApproveStatus": approveStatus,
    "MaterialReqOrdMasId": materialReqOrdMasId,
    "MaterialReqOrdDetId": materialReqOrdDetId,
    "MaterialPurOrdMasId": materialPurOrdMasId,
    "PurchaseOrdNo": purchaseOrdNo,
    "PurchaseOrdDate": purchaseOrdDate,
    "MaterialPurOrdDetId": materialPurOrdDetId,
    "POQty": poQty,
    "POCreatedBy": poCreatedBy,
    "POCreatedByName": poCreatedByName,
    "POVerifyBy": poVerifyBy,
    "POVerifyByName": poVerifyByName,
    "POVerifyDate": poVerifyDate,
    "POVerifyStatus": poVerifyStatus,
    "POApprovedBy": poApprovedBy,
    "POApprovedByName": poApprovedByName,
    "POApprovedDate": poApprovedDate,
    "PoApproveStatus": poApproveStatus,
    "InwardMasID": inwardMasId,
    "InwardNo": inwardNo,
    "GRNdate": grNdate,
    "PurOrdMasId": purOrdMasId,
    "InvoiceNo": invoiceNo,
    "InvoiceDate": invoiceDate,
    "InwardDetID": inwardDetId,
    "PurOrdDetId": purOrdDetId,
    "GRNQty": grnQty,
    "GRNCreatedBy": grnCreatedBy,
    "GRNCreatedByName": grnCreatedByName,
  };
}
