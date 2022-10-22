// To parse this JSON data, do
//
//     final count = countFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Count> countFromJson(String str) => List<Count>.from(json.decode(str).map((x) => Count.fromJson(x)));

String countToJson(List<Count> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Count {
    Count({
        required this.cultivationId,
        required this.count,
    });

    dynamic cultivationId;
    dynamic count;

    factory Count.fromJson(Map<String, dynamic> json) => Count(
        cultivationId: json["CultivationID"],
        count: json["Count"],
    );

    Map<String, dynamic> toJson() => {
        "CultivationID": cultivationId,
        "Count": count,
    };
}
