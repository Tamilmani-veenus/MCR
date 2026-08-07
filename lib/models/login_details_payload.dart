import 'dart:convert';

class LoginDetailsPayload {
  String? userId;
  String? userName;
  String? userType;
  String? userActive;
  String? empId;
  String? empName;

  LoginDetailsPayload({
    this.userId,
    this.userName,
    this.userType,
    this.userActive,
    this.empId,
    this.empName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userType': userType,
      'userActive': userActive,
      'empId': empId,
      'empName': empName,
    };
  }

  factory LoginDetailsPayload.fromMap(Map<String, dynamic> map) {
    return LoginDetailsPayload(
      userId: map['userId'],
      userName: map['userName'],
      userType: map['userType'],
      userActive: map['userActive'],
      empId: map['empId'],
      empName: map['empName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginDetailsPayload.fromJson(String source) =>
      LoginDetailsPayload.fromMap(json.decode(source));
}
