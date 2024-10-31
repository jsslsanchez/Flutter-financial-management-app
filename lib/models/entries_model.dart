import 'dart:convert';

EntriesModel FeaturesModelFromJSON(String str) =>
    EntriesModel.fromJson(json.decode(str));

String FeaturesModelToJson(EntriesModel data) => json.encode(data.toJson());

class EntriesModel {
  EntriesModel({
    this.id,
    this.link,
    this.year = 0,
    this.month = 0,
    this.day = 0,
    this.comment = '',
    this.entrie = 0.0,
  });

  int? id;
  int? link;
  int year;
  int month;
  int day;
  String comment;
  double entrie;

  factory EntriesModel.fromJson(Map<String, dynamic> json) => EntriesModel(
        id: json["id"],
        link: json["link"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        comment: json["comment"],
        entrie: json["entrie"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "year": year,
        "month": month,
        "day": day,
        "comment": comment,
        "entrie": entrie,
      };
}
