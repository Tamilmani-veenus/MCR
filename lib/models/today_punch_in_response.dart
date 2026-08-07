// import 'dart:convert';
//
// TodayPunchInResponse todayPunchInResponseFromJson(String str) => TodayPunchInResponse.fromJson(json.decode(str));
// String todayPunchInResponseToJson(TodayPunchInResponse data) => json.encode(data.toJson());
// class TodayPunchInResponse {
//   TodayPunchInResponse({
//       List<EmployeeTimingTodaywise>? employeeTimingTodaywise,}){
//     _employeeTimingTodaywise = employeeTimingTodaywise;
// }
//
//   TodayPunchInResponse.fromJson(dynamic json) {
//     if (json['EmployeeTimingTodaywise'] != null) {
//       _employeeTimingTodaywise = [];
//       json['EmployeeTimingTodaywise'].forEach((v) {
//         _employeeTimingTodaywise?.add(EmployeeTimingTodaywise.fromJson(v));
//       });
//     }
//   }
//   List<EmployeeTimingTodaywise>? _employeeTimingTodaywise;
// TodayPunchInResponse copyWith({  List<EmployeeTimingTodaywise>? employeeTimingTodaywise,
// }) => TodayPunchInResponse(  employeeTimingTodaywise: employeeTimingTodaywise ?? _employeeTimingTodaywise,
// );
//   List<EmployeeTimingTodaywise>? get employeeTimingTodaywise => _employeeTimingTodaywise;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_employeeTimingTodaywise != null) {
//       map['EmployeeTimingTodaywise'] = _employeeTimingTodaywise?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// EmployeeTimingTodaywise employeeTimingTodaywiseFromJson(String str) => EmployeeTimingTodaywise.fromJson(json.decode(str));
// String employeeTimingTodaywiseToJson(EmployeeTimingTodaywise data) => json.encode(data.toJson());
// class EmployeeTimingTodaywise {
//   EmployeeTimingTodaywise({
//       String? staffName,
//       List<PunchDetails>? punchDetails,}){
//     _staffName = staffName;
//     _punchDetails = punchDetails;
// }
//
//   EmployeeTimingTodaywise.fromJson(dynamic json) {
//     _staffName = json['StaffName'];
//     if (json['PunchDetails'] != null) {
//       _punchDetails = [];
//       json['PunchDetails'].forEach((v) {
//         _punchDetails?.add(PunchDetails.fromJson(v));
//       });
//     }
//   }
//   String? _staffName;
//   List<PunchDetails>? _punchDetails;
// EmployeeTimingTodaywise copyWith({  String? staffName,
//   List<PunchDetails>? punchDetails,
// }) => EmployeeTimingTodaywise(  staffName: staffName ?? _staffName,
//   punchDetails: punchDetails ?? _punchDetails,
// );
//   String? get staffName => _staffName;
//   List<PunchDetails>? get punchDetails => _punchDetails;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['StaffName'] = _staffName;
//     if (_punchDetails != null) {
//       map['PunchDetails'] = _punchDetails?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// PunchDetails punchDetailsFromJson(String str) => PunchDetails.fromJson(json.decode(str));
// String punchDetailsToJson(PunchDetails data) => json.encode(data.toJson());
// class PunchDetails {
//   PunchDetails({
//       String? timeOut,
//       String? timeIn,
//       String? date,
//       String? siteName,}){
//     _timeOut = timeOut;
//     _timeIn = timeIn;
//     _date = date;
//     _siteName = siteName;
// }
//
//   PunchDetails.fromJson(dynamic json) {
//     _timeOut = json['Time_Out'];
//     _timeIn = json['Time_In'];
//     _date = json['Date'];
//     _siteName = json['SiteName'];
//   }
//   String? _timeOut;
//   String? _timeIn;
//   String? _date;
//   String? _siteName;
// PunchDetails copyWith({  String? timeOut,
//   String? timeIn,
//   String? date,
//   String? siteName,
// }) => PunchDetails(  timeOut: timeOut ?? _timeOut,
//   timeIn: timeIn ?? _timeIn,
//   date: date ?? _date,
//   siteName: siteName ?? _siteName,
// );
//   String? get timeOut => _timeOut;
//   String? get timeIn => _timeIn;
//   String? get date => _date;
//   String? get siteName => _siteName;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['Time_Out'] = _timeOut;
//     map['Time_In'] = _timeIn;
//     map['Date'] = _date;
//     map['SiteName'] = _siteName;
//     return map;
//   }
//
// }

// To parse this JSON data, do
//
//     final todayPunchInResponse = todayPunchInResponseFromJson(jsonString);

import 'dart:convert';

TodayPunchInResponse todayPunchInResponseFromJson(String str) => TodayPunchInResponse.fromJson(json.decode(str));

String todayPunchInResponseToJson(TodayPunchInResponse data) => json.encode(data.toJson());

class TodayPunchInResponse {
  List<EmployeeTimingTodaywise> employeeTimingTodaywise;

  TodayPunchInResponse({
    required this.employeeTimingTodaywise,
  });

  factory TodayPunchInResponse.fromJson(Map<String, dynamic> json) => TodayPunchInResponse(
    employeeTimingTodaywise: List<EmployeeTimingTodaywise>.from(json["EmployeeTimingTodaywise"].map((x) => EmployeeTimingTodaywise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "EmployeeTimingTodaywise": List<dynamic>.from(employeeTimingTodaywise.map((x) => x.toJson())),
  };
}

class EmployeeTimingTodaywise {
  String staffName;
  List<PunchDetail> punchDetails;

  EmployeeTimingTodaywise({
    required this.staffName,
    required this.punchDetails,
  });

  factory EmployeeTimingTodaywise.fromJson(Map<String, dynamic> json) => EmployeeTimingTodaywise(
    staffName: json["StaffName"],
    punchDetails: List<PunchDetail>.from(json["PunchDetails"].map((x) => PunchDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "StaffName": staffName,
    "PunchDetails": List<dynamic>.from(punchDetails.map((x) => x.toJson())),
  };
}

class PunchDetail {
  DateTime punchInDate;
  String punchOutDate;
  String punchInProjectName;
  String punchOutProjectName;
  String punchInTime;
  String punchOutTime;
  String punchInOnDutyStatus;
  String punchOutOnDutyStatus;
  String punchInOnDutyAddress;
  String punchOutOnDutyAddress;

  PunchDetail({
    required this.punchInDate,
    required this.punchOutDate,
    required this.punchInProjectName,
    required this.punchOutProjectName,
    required this.punchInTime,
    required this.punchOutTime,
    required this.punchInOnDutyStatus,
    required this.punchOutOnDutyStatus,
    required this.punchInOnDutyAddress,
    required this.punchOutOnDutyAddress,
  });

  factory PunchDetail.fromJson(Map<String, dynamic> json) => PunchDetail(
    punchInDate: DateTime.parse(json["PunchInDate"]),
    punchOutDate: json["PunchOutDate"],
    punchInProjectName: json["PunchInProjectName"],
    punchOutProjectName: json["PunchOutProjectName"],
    punchInTime: json["PunchInTime"],
    punchOutTime: json["PunchOutTime"],
    punchInOnDutyStatus: json["PunchInOnDutyStatus"],
    punchOutOnDutyStatus: json["PunchOutOnDutyStatus"],
    punchInOnDutyAddress: json["PunchInOnDutyAddress"],
    punchOutOnDutyAddress: json["PunchOutOnDutyAddress"],
  );

  Map<String, dynamic> toJson() => {
    "PunchInDate": "${punchInDate.year.toString().padLeft(4, '0')}-${punchInDate.month.toString().padLeft(2, '0')}-${punchInDate.day.toString().padLeft(2, '0')}",
    "PunchOutDate": punchOutDate,
    "PunchInProjectName": punchInProjectName,
    "PunchOutProjectName": punchOutProjectName,
    "PunchInTime": punchInTime,
    "PunchOutTime": punchOutTime,
    "PunchInOnDutyStatus": punchInOnDutyStatus,
    "PunchOutOnDutyStatus": punchOutOnDutyStatus,
    "PunchInOnDutyAddress": punchInOnDutyAddress,
    "PunchOutOnDutyAddress": punchOutOnDutyAddress,
  };
}
