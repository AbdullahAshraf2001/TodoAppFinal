import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/app_user.dart';
import 'package:todo/ui/screens/auth/register/register_screen.dart';
import 'package:todo/ui/screens/home/home_screen.dart';
import 'package:todo/ui/utils/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";

  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Login"),
        toolbarHeight: MediaQuery.of(context).size.height * .1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .25,
              ),
              const Padding(padding: EdgeInsets.all(8),
              child: Text("Welcome back!",
                textAlign :TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ),
              TextFormField(
                onChanged: (text){
                  email = text;
                },
                decoration: const InputDecoration(
                  label:Text("Email"),
                ),
              ),
              SizedBox(height: 8,),
              TextFormField(
                onChanged: (text){
                  password = text;
                },
                decoration: const InputDecoration(
                  label:Text("Password"),
                ),
              ),
              SizedBox(height: 26,),
              ElevatedButton(onPressed: (){
                login();
              }, child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Row(
                  children: [
                    Text("Login", style: TextStyle(fontSize: 18),),
                    Spacer(),
                    Icon(Icons.arrow_forward)
                  ],
                ),
              )),
              SizedBox(height: 18,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: Text(
                  "Create account",
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      AppUser currentUser = await getUserFromFirestore(userCredential.user!.uid);
      AppUser.currentUser = currentUser;
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

  Future<AppUser> getUserFromFirestore(String id) async {
    CollectionReference<AppUser> userCollection = AppUser.collection();
    DocumentSnapshot<AppUser> documentSnapshot = await userCollection.doc(id).get();
    return documentSnapshot.data()!;
  }
}
