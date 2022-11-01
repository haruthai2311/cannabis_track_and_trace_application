// To parse this JSON data, do
//
//     final harvestbyGh = harvestbyGhFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<HarvestbyGh> harvestbyGhFromJson(String str) => List<HarvestbyGh>.from(json.decode(str).map((x) => HarvestbyGh.fromJson(x)));

String harvestbyGhToJson(List<HarvestbyGh> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HarvestbyGh {
    HarvestbyGh({
        required this.harvestId,
        required this.harvestDate,
        required this.harvestNo,
        required this.greenHouseId,
        required this.type,
        required this.weight,
        required this.lotNo,
        required this.remark,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
        required this.transferId,
        required this.transferDate,
        required this.getByName,
        required this.getByPlace,
        required this.licenseNo,
        required this.licensePlate,
    });

    int harvestId;
    DateTime harvestDate;
    int harvestNo;
    int greenHouseId;
    int type;
    double weight;
    String lotNo;
    String remark;
    DateTime createTime;
    String createBy;
    DateTime updateTime;
    String updateBy;
    int transferId;
    DateTime transferDate;
    String getByName;
    String getByPlace;
    String licenseNo;
    String licensePlate;

    factory HarvestbyGh.fromJson(Map<String, dynamic> json) => HarvestbyGh(
        harvestId: json["HarvestID"],
        harvestDate: DateTime.parse(json["HarvestDate"]),
        harvestNo: json["HarvestNo"],
        greenHouseId: json["GreenHouseID"],
        type: json["Type"],
        weight: json["Weight"].toDouble(),
        lotNo: json["LotNo"],
        remark: json["Remark"],
        createTime: DateTime.parse(json["CreateTime"]),
        createBy: json["CreateBy"],
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy: json["UpdateBy"],
        transferId: json["TransferID"],
        transferDate: DateTime.parse(json["TransferDate"]),
        getByName: json["GetByName"],
        getByPlace: json["GetByPlace"],
        licenseNo: json["LicenseNo"],
        licensePlate: json["LicensePlate"],
    );

    Map<String, dynamic> toJson() => {
        "HarvestID": harvestId,
        "HarvestDate": harvestDate,
        "HarvestNo": harvestNo,
        "GreenHouseID": greenHouseId,
        "Type": type,
        "Weight": weight,
        "LotNo": lotNo,
        "Remark": remark,
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime.toIso8601String(),
        "UpdateBy": updateBy,
        "TransferID": transferId,
        "TransferDate": transferDate.toIso8601String(),
        "GetByName": getByName,
        "GetByPlace": getByPlace,
        "LicenseNo": licenseNo,
        "LicensePlate": licensePlate,
    };
}
