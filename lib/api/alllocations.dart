// To parse this JSON data, do
//
//     final allLocations = allLocationsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllLocations> allLocationsFromJson(String str) => List<AllLocations>.from(json.decode(str).map((x) => AllLocations.fromJson(x)));

String allLocationsToJson(List<AllLocations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllLocations {
    AllLocations({
        required this.locationId,
        required this.name,
        required this.addrNo,
        required this.moo,
        required this.road,
        required this.subDistrictId,
        required this.districtId,
        required this.provinceId,
        required this.postCode,
        required this.lat,
        required this.long,
        required this.telephone,
        required this.isActive,
        required this.remark,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
    });

    int locationId;
    String name;
    String addrNo;
    int moo;
    dynamic road;
    int subDistrictId;
    int districtId;
    int provinceId;
    String postCode;
    String lat;
    String long;
    dynamic telephone;
    dynamic isActive;
    dynamic remark;
    DateTime createTime;
    dynamic createBy;
    DateTime updateTime;
    dynamic updateBy;

    factory AllLocations.fromJson(Map<String, dynamic> json) => AllLocations(
        locationId: json["LocationID"],
        name: json["Name"],
        addrNo: json["AddrNo"],
        moo: json["Moo"],
        road: json["Road"],
        subDistrictId: json["SubDistrictID"],
        districtId: json["DistrictID"],
        provinceId: json["ProvinceID"],
        postCode: json["PostCode"],
        lat: json["Lat"],
        long: json["Long"],
        telephone: json["Telephone"],
        isActive: json["IsActive"],
        remark:  json["Remark"],
        createTime: DateTime.parse(json["CreateTime"]),
        createBy: json["CreateBy"],
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy:  json["UpdateBy"],
    );

    Map<String, dynamic> toJson() => {
        "LocationID": locationId,
        "Name": name,
        "AddrNo": addrNo,
        "Moo": moo,
        "Road": road,
        "SubDistrictID": subDistrictId,
        "DistrictID": districtId,
        "ProvinceID": provinceId,
        "PostCode": postCode,
        "Lat": lat,
        "Long": long,
        "Telephone":  telephone,
        "IsActive": isActive,
        "Remark":  remark,
        "CreateTime": createTime,
        "CreateBy":  createBy,
        "UpdateTime": updateTime,
        "UpdateBy": updateBy,
    };
}

