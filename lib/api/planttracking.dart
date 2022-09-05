// To parse this JSON data, do
//
//     final plantracking = plantrackingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Plantracking> plantrackingFromJson(String str) => List<Plantracking>.from(json.decode(str).map((x) => Plantracking.fromJson(x)));

String plantrackingToJson(List<Plantracking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Plantracking {
    Plantracking({
        required this.plantTrackingId,
        required this.checkDate,
        required this.plantStatus,
        required this.soilMoisture,
        required this.soilRemark,
        required this.remark,
        required this.imageId,
        required this.fileName,
        required this.diseaseLogId,
        required this.disease,
        required this.fixDisease,
        required this.insectLogId,
        required this.insect,
        required this.fixInsect,
        required this.trashLogId,
        required this.weight,
        required this.logTime,
        required this.trashRemark,
        required this.potId,
        required this.potsName,
        required this.greenHouseId,
        required this.ghName,
        required this.cultivationId,
        required this.no,
        required this.barcode,
        required this.isTestPot,
    });

    int plantTrackingId;
    DateTime checkDate;
    int plantStatus;
    int soilMoisture;
    String soilRemark;
    String remark;
    int imageId;
    String fileName;
    int diseaseLogId;
    String disease;
    String fixDisease;
    int insectLogId;
    String insect;
    String fixInsect;
    int trashLogId;
    double weight;
    DateTime logTime;
    String trashRemark;
    int potId;
    String potsName;
    int greenHouseId;
    String ghName;
    int cultivationId;
    int no;
    String barcode;
    String isTestPot;

    factory Plantracking.fromJson(Map<String, dynamic> json) => Plantracking(
        plantTrackingId: json["PlantTrackingID"],
        checkDate: DateTime.parse(json["CheckDate"]),
        plantStatus: json["PlantStatus"],
        soilMoisture: json["SoilMoisture"],
        soilRemark: json["SoilRemark"],
        remark: json["Remark"],
        imageId: json["ImageID"],
        fileName: json["FileName"],
        diseaseLogId: json["DiseaseLogID"],
        disease: json["Disease"],
        fixDisease: json["FixDisease"],
        insectLogId: json["InsectLogID"],
        insect: json["Insect"],
        fixInsect: json["FixInsect"],
        trashLogId: json["TrashLogID"],
        weight: json["Weight"].toDouble(),
        logTime: DateTime.parse(json["LogTime"]),
        trashRemark: json["TrashRemark"],
        potId: json["PotID"],
        potsName: json["potsName"],
        greenHouseId: json["GreenHouseID"],
        ghName: json["GHName"],
        cultivationId: json["CultivationID"],
        no: json["No"],
        barcode: json["Barcode"],
        isTestPot: json["IsTestPot"],
    );

    Map<String, dynamic> toJson() => {
        "PlantTrackingID": plantTrackingId,
        "CheckDate": checkDate.toIso8601String(),
        "PlantStatus": plantStatus,
        "SoilMoisture": soilMoisture,
        "SoilRemark": soilRemark,
        "Remark": remark,
        "ImageID": imageId,
        "FileName": fileName,
        "DiseaseLogID": diseaseLogId,
        "Disease": disease,
        "FixDisease": fixDisease,
        "InsectLogID": insectLogId,
        "Insect": insect,
        "FixInsect": fixInsect,
        "TrashLogID": trashLogId,
        "Weight": weight,
        "LogTime": logTime.toIso8601String(),
        "TrashRemark": trashRemark,
        "PotID": potId,
        "potsName": potsName,
        "GreenHouseID": greenHouseId,
        "GHName": ghName,
        "CultivationID": cultivationId,
        "No": no,
        "Barcode": barcode,
        "IsTestPot": isTestPot,
    };
}
