import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/models/todo_dm.dart';

class ListProvider extends ChangeNotifier {
  List<TodoDM> todos = [];

  DateTime selectedDate = DateTime.now();

  refreshTodosList() async {
    CollectionReference<TodoDM> todosCollection = FirebaseFirestore.instance
        .collection(TodoDM.collectionName)
        .withConverter<TodoDM>(fromFirestore: (docSnapShot, _) {
      Map json = docSnapShot.data() as Map;
      TodoDM todo = TodoDM.fromJson(json);
      return todo;
    }, toFirestore: (todoDm, _) {
      return todoDm.toJson();
    });
    QuerySnapshot<TodoDM> todoSnapshot = await todosCollection
        .orderBy("date")
        // .where("date", isEqualTo: selectedDate)
        .get();
    List<QueryDocumentSnapshot<TodoDM>> docs = todoSnapshot.docs;
    // for (int i = 0; i < docs.length; i++) {
    //  todos.add(docs[i].data());
    // }
    ///better solution than for loop
    todos = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();

    //////////////////////
    // for (int i = 0; i < todos.length; i++) {
    //   if (todos[i].date.day != selectedDate.day ||
    //       todos[i].date.month != selectedDate.month ||
    //       todos[i].date.year != selectedDate.year) {
    //     todos.removeAt(i);
    // i--;
    //   }
    // }
    ///Better sol than using for loop
    todos = todos.where((todo) {
        if (todo.date.day != selectedDate.day ||
            todo.date.month != selectedDate.month ||
            todo.date.year != selectedDate.year) {
          return false;
        } else {
          return true;
        }
    }).toList();
    notifyListeners();
  }
}
