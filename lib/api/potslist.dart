// To parse this JSON data, do
//
//     final potslist = potslistFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Potslist> potslistFromJson(String str) => List<Potslist>.from(json.decode(str).map((x) => Potslist.fromJson(x)));

String potslistToJson(List<Potslist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Potslist {
    Potslist({
        required this.potId,
        required this.greenHouseId,
        required this.ghName,
        required this.name,
        required this.barcode,
        required this.cultivationId,
    });

    int potId;
    int greenHouseId;
    String ghName;
    String name;
    String barcode;
    int cultivationId;

    factory Potslist.fromJson(Map<String, dynamic> json) => Potslist(
        potId: json["PotID"],
        greenHouseId: json["GreenHouseID"],
        ghName: json["GHName"],
        name: json["Name"],
        barcode: json["Barcode"],
        cultivationId: json["CultivationID"],
    );

    Map<String, dynamic> toJson() => {
        "PotID": potId,
        "GreenHouseID": greenHouseId,
        "GHName": ghName,
        "Name": name,
        "Barcode": barcode,
        "CultivationID": cultivationId,
    };
}
