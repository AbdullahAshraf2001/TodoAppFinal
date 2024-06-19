import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/app_user.dart';
import 'package:todo/ui/screens/home/home_screen.dart';
import 'package:todo/ui/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";

  String password = "";

  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Register"),
      ),
      body: Padding(
        padding: EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              TextFormField(
                onChanged: (text) {
                  username = text;
                },
                decoration: InputDecoration(label: Text("user name")),
              ),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: InputDecoration(label: Text("Email")),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: InputDecoration(label: Text("Password")),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              ElevatedButton(
                  onPressed: () {
                    register();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "create account",
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser newUser = AppUser(
          username: username, id: userCredential.user!.uid, email: email);
      await registerUserInFirebase(newUser);
      AppUser.currentUser = newUser;
      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (error) {
      hideLoading(context);
      showErrorDialog(
          context, error.message ?? "Something went wrong please try again.");
    }
  }

  Future<void> registerUserInFirebase(AppUser user) async {
    CollectionReference<AppUser> userCollection = AppUser.collection();
    await userCollection.doc(user.id).set(user);

    userCollection.add(user);
  }
}
