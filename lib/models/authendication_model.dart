

import 'dart:convert';

List<User> authendicationResponseFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String authendicationResponseToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

//String authendicationResponseToJson(User data) => json.encode(data.toJson());


class User {
  User({
    this.userId,
    this.userName,
    this.userPassword,
    this.userType,
    this.userActive,
    this.userAppActive,
    this.empId,
    this.empName,
  });

  int? userId;
  String? userName;
  String? userPassword;
  String? userType;
  String? userActive;
  int? userAppActive;
  int? empId;
  String? empName;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["UserId"],
    userName: json["UserName"],
    userPassword: json["UserPassword"],
    userType: json["UserType"],
    userActive: json["UserActive"],
    userAppActive: json["UserAppActive"],
    empId: json["EmpId"],
    empName: json["EmpName"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "UserName": userName,
    "UserPassword": userPassword,
    "UserType": userType,
    "UserActive": userActive,
    "UserAppActive": userAppActive,
    "EmpId": empId,
    "EmpName": empName,
  };
}
