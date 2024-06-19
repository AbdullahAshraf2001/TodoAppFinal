import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  static const collectionName = "users";
  static AppUser? currentUser;
  late String id;
  late String email;
  late String username;

  AppUser({required this.username, required this.id, required this.email});

  AppUser.fromJson(Map json) {
    id = json["id"];
    email = json["email"];
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "username": username,
    };
  }

  static CollectionReference<AppUser> collection(){ return
    FirebaseFirestore.instance
        .collection(AppUser.collectionName).withConverter<AppUser>(
        fromFirestore: (snapshot, _) {
          return AppUser.fromJson(snapshot.data()!);
        }, toFirestore: (user, _) {
      return user.toJson();
    });
  }
}
