import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoproject/model/app_users.dart';

class TodoDM {
  static const collectionName = "todos";
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;

  TodoDM({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
  });

  static CollectionReference get userTodosCollection =>
      FirebaseFirestore.instance
          .collection(AppUser.collectionName)
          .doc(AppUser.currentUser!.id)
          .collection(TodoDM.collectionName);

  TodoDM.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    int dateAsInt = json["date"];
    date = DateTime.fromMillisecondsSinceEpoch(dateAsInt);
    isDone = json["isDone"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date.millisecondsSinceEpoch,
        "isDone": isDone
      };
}
