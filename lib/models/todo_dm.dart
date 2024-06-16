import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDM {
  late String id;
  late String title;
  late String description;
  late bool isDone;
  late DateTime date;
  static const String collectionName = "todos";

  TodoDM(this.id, this.title, this.description, this.isDone, this.date);

  TodoDM.fromJson(Map json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    Timestamp time = json["date"];
    date = time.toDate();
    isDone = json["isDone"];
  }

  Map<String , Object?> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone,
    };
  }
}
