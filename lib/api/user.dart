// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UserData> userDataFromJson(String str) => List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
    UserData({
        required this.userId,
        required this.username,
        required this.password,
        required this.email,
        required this.fNameT,
        required this.lNameT,
        required this.fNameE,
        required this.lNameE,
        required this.isDisabled,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
    });

    int userId;
    String username;
    String password;
    String email;
    String fNameT;
    String lNameT;
    String fNameE;
    String lNameE;
    String isDisabled;
    DateTime createTime;
    String createBy;
    DateTime updateTime;
    String updateBy;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["UserID"],
        username: json["Username"],
        password: json["Password"],
        email: json["Email"],
        fNameT: json["FNameT"],
        lNameT: json["LNameT"],
        fNameE: json["FNameE"],
        lNameE: json["LNameE"],
        isDisabled: json["IsDisabled"],
        createTime: DateTime.parse(json["CreateTime"]),
        createBy: json["CreateBy"],
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy: json["UpdateBy"],
    );

    Map<String, dynamic> toJson() => {
        "UserID": userId,
        "Username": username,
        "Password": password,
        "Email": email,
        "FNameT": fNameT,
        "LNameT": lNameT,
        "FNameE": fNameE,
        "LNameE": lNameE,
        "IsDisabled": isDisabled,
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime.toIso8601String(),
        "UpdateBy": updateBy,
    };
}
