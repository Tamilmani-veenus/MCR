import 'dart:convert';

class PunchInSaveModel {
  String? empId;
  String? userId;
  String? dateIn;
  String? entryMode;
  String? locId;
  String? deviceName;
  String? punchTimeIn;
  String? IsDuty;
  String? OnLon;
  String? OnLat;
  String? Onaddres;
  // String? TimeIn;
  String? remarks;

  PunchInSaveModel({
    this.empId,
    this.userId,
    this.dateIn,
    this.entryMode,
    this.locId,
    this.deviceName,
    this.punchTimeIn,
    this.IsDuty,
    this.OnLon,
    this.OnLat,
    this.Onaddres,
    // this.TimeIn,
    this.remarks,
  });

  Map<String, dynamic> toJson() => {
    "Emp_Id": empId.toString(),
    "UserId": userId.toString(),
    "Date": dateIn.toString(),
    "EntryMode": entryMode.toString(),
    "Locid": locId.toString(),
    "DeviceName": deviceName.toString(),
    "punch_time_in": punchTimeIn.toString(),
    "OnDutyStatus": IsDuty.toString(),
    "OnPunin_Longitude": OnLon.toString(),
    "OnPinin_Latitude": OnLat.toString(),
    "OnPunin_Address": Onaddres.toString(),
    // "PunchIn_Time": TimeIn.toString(),
    "Remarks": remarks.toString(),
  };
}



PunchInSaveRes punchInSaveResFromJson(String str) => PunchInSaveRes.fromJson(json.decode(str));

String punchInSaveResToJson(PunchInSaveRes data) => json.encode(data.toJson());

class PunchInSaveRes {
  int? punchInId;
  String? status;
  String? onDutyModelStatus;
  String? appStatus;
  String? punchNo;
  String? punchInDate;
  String? todayTask;
  String? tommorrowTask;

  PunchInSaveRes({
    this.punchInId,
    this.punchNo,
    this.status,
    this.onDutyModelStatus,
    this.appStatus,
    this.punchInDate,
    this.todayTask,
    this.tommorrowTask,
  });

  factory PunchInSaveRes.fromJson(Map<String, dynamic> json) => PunchInSaveRes(
    punchInId: json["PunchInId"],
    punchNo: json["PunchNo"],
    status: json["Status"],
    onDutyModelStatus: json["OnDutyStatus"],
    appStatus: json["AppStatus"],
    punchInDate: json["PunchInDate"],
    todayTask: json["TodayTask"],
    tommorrowTask: json["TommorrowTask"],
  );

  Map<String, dynamic> toJson() => {
    "PunchInId": punchInId,
    "Status": status,
    "OnDutyStatus": onDutyModelStatus,
    "AppStatus": appStatus,
    "PunchInDate": punchInDate,
    "TodayTask": todayTask,
    "TommorrowTask": tommorrowTask,
  };
}

class PunchOutSaveRes {
  String retString;

  PunchOutSaveRes({
    required this.retString,
  });

  factory PunchOutSaveRes.fromJson(Map<String, dynamic> json) => PunchOutSaveRes(
    retString: json["RetString"],
  );

  Map<String, dynamic> toJson() => {
    "RetString": retString,
  };
}

class PunchOutUpdate {
  String? empId;
  String? date;
  String? timeOut;
  String? Time_Out;
  String? punchOutAddress;
  String? entryMode;
  String? userId;
  String? deviceName;
  String? locId;
  String? punchInID;
  String? outLatitude;
  String? outLongitude;
  String? OnDuty;
  String? appStatus;
  String? punchInDate;
  String? todayTask;
  String? tomrrowTask;
  String? punchNo;

  PunchOutUpdate({
    this.empId,
    this.date,
    this.timeOut,
    this.Time_Out,
    this.punchOutAddress,
    this.entryMode,
    this.userId,
    this.deviceName,
    this.locId,
    this.punchInID,
    this.outLatitude,
    this.outLongitude,
    this.OnDuty,
    this.appStatus,
    this.punchInDate,
    this.todayTask,
    this.tomrrowTask,
    this.punchNo,
  });

  Map<String, dynamic> toJson() => {
    "Emp_Id": empId,
    "PunchOutDate": date,
    "punch_time_Out": timeOut,
    "Time_Out": Time_Out,
    "OutPunin_Address": punchOutAddress,
    "EntryMode": entryMode,
    "UserId": userId,
    "DeviceName": deviceName,
    "PunchOut_Locid" : locId,
    "PunchinId" : punchInID,
    "OutPinin_Latitude" : outLatitude,
    "OutPunin_Longitude" : outLongitude,
    "TodayTask" : todayTask,
    "TomrrowTask" : tomrrowTask,
    "OnDutyStatus" : OnDuty,
    "AppStatus" : appStatus,
    "PunchInDate" : punchInDate,
    "PunchNo" : punchNo,
  };
}

