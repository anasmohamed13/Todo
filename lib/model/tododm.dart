import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoDM {
  static const String collectionName = "todo";
  late String id;
  late String title;
  late DateTime date;
  late String description;
  late bool isDone;

  ToDoDM(
      {required this.id,
      required this.title,
      required this.date,
      required this.description,
      required this.isDone});

  ToDoDM.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"] ?? "";
    Timestamp timestamp = json["date"];
    date = timestamp.toDate();
    isDone = json["isDone"];
  }

  Map<String, dynamic> tojson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "isDone": isDone,
      };
}
