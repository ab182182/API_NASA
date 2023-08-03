// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

Model? modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model? data) => json.encode(data!.toJson());

class Model {


  var length;

  Model({
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
  });

  DateTime? date;
  String? explanation;
  String? hdurl;
  String? mediaType;
  String? serviceVersion;
  String? title;
  String? url;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    date: DateTime.parse(json["date"]),
    explanation: json["explanation"],
    hdurl: json["hdurl"],
    mediaType: json["media_type"],
    serviceVersion: json["service_version"],
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "explanation": explanation,
    "hdurl": hdurl,
    "media_type": mediaType,
    "service_version": serviceVersion,
    "title": title,
    "url": url,
  };

}
