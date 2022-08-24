// To parse this JSON data, do
//
//     final allInventorys = allInventorysFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllInventorys> allInventorysFromJson(String str) => List<AllInventorys>.from(json.decode(str).map((x) => AllInventorys.fromJson(x)));

String allInventorysToJson(List<AllInventorys> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllInventorys {
    AllInventorys({
        required this.inventoryId,
        required this.name,
        required this.commercialName,
        required this.isActive,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
    });

    int inventoryId;
    String name;
    dynamic commercialName;
    String isActive;
    DateTime createTime;
    dynamic createBy;
    DateTime updateTime;
    dynamic updateBy;

    factory AllInventorys.fromJson(Map<String, dynamic> json) => AllInventorys(
        inventoryId: json["InventoryID"],
        name: json["Name"],
        commercialName: json["CommercialName"],
        isActive: json["IsActive"],
        createTime: DateTime.parse(json["CreateTime"]),
        createBy: json["CreateBy"],
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy: json["UpdateBy"],
    );

    Map<String, dynamic> toJson() => {
        "InventoryID": inventoryId,
        "Name": name,
        "CommercialName": commercialName,
        "IsActive": isActive,
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime.toIso8601String(),
        "UpdateBy": updateBy,
    };
}
