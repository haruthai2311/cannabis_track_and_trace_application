// To parse this JSON data, do
//
//     final allGreenhouses = allGreenhousesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllGreenhouses> allGreenhousesFromJson(String str) => List<AllGreenhouses>.from(json.decode(str).map((x) => AllGreenhouses.fromJson(x)));

String allGreenhousesToJson(List<AllGreenhouses> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllGreenhouses {
    AllGreenhouses({
        required this.greenHouseId,
        required this.locationId,
        required this.name,
        required this.isActive,
        required this.remark,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
    });

    int greenHouseId;
    int locationId;
    String name;
    String isActive;
    dynamic remark;
    DateTime createTime;
    dynamic createBy;
    DateTime updateTime;
    dynamic updateBy;

    factory AllGreenhouses.fromJson(Map<String, dynamic> json) => AllGreenhouses(
        greenHouseId: json["GreenHouseID"],
        locationId: json["LocationID"],
        name: json["Name"],
        isActive: json["IsActive"],
        remark: json["Remark"],
        createTime: DateTime.parse(json["CreateTime"]),
        createBy: json["CreateBy"],
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy: json["UpdateBy"],
    );

    Map<String, dynamic> toJson() => {
        "GreenHouseID": greenHouseId,
        "LocationID": locationId,
        "Name": name,
        "IsActive": isActive,
        "Remark": remark,
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime.toIso8601String(),
        "UpdateBy": updateBy,
    };
}
