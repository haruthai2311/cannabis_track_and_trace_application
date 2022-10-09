// To parse this JSON data, do
//
//     final getTransfers = getTransfersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetTransfers> getTransfersFromJson(String str) => List<GetTransfers>.from(json.decode(str).map((x) => GetTransfers.fromJson(x)));

String getTransfersToJson(List<GetTransfers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTransfers {
    GetTransfers({
        required this.transferId,
        required this.harvestId,
        required this.transferDate,
        required this.type,
        required this.weight,
        required this.lotNo,
        required this.getByName,
        required this.getByPlace,
        required this.licenseNo,
        required this.licensePlate,
        required this.remark,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
        required this.harvestNo,
    });

    int transferId;
    int harvestId;
    DateTime transferDate;
    int type;
    double weight;
    String lotNo;
    String getByName;
    String getByPlace;
    String licenseNo;
    String licensePlate;
    String remark;
    DateTime createTime;
    String createBy;
    DateTime updateTime;
    String updateBy;
    int harvestNo;

    factory GetTransfers.fromJson(Map<String, dynamic> json) => GetTransfers(
        transferId: json["TransferID"],
        harvestId: json["HarvestID"],
        transferDate: DateTime.parse(json["TransferDate"]),
        type: json["Type"],
        weight: json["Weight"].toDouble(),
        lotNo: json["LotNo"],
        getByName: json["GetByName"],
        getByPlace: json["GetByPlace"],
        licenseNo: json["LicenseNo"],
        licensePlate: json["LicensePlate"],
        remark: json["Remark"],
        createTime: DateTime.parse(json["CreateTime"]),
        createBy: json["CreateBy"],
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy: json["UpdateBy"],
        harvestNo: json["HarvestNo"],
    );

    Map<String, dynamic> toJson() => {
        "TransferID": transferId,
        "HarvestID": harvestId,
        "TransferDate": transferDate.toIso8601String(),
        "Type": type,
        "Weight": weight,
        "LotNo": lotNo,
        "GetByName": getByName,
        "GetByPlace": getByPlace,
        "LicenseNo": licenseNo,
        "LicensePlate": licensePlate,
        "Remark": remark,
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime.toIso8601String(),
        "UpdateBy": updateBy,
        "HarvestNo": harvestNo,
    };
}
