// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todoproject/model/app_users.dart';
import 'package:todoproject/ui/screens/home/home.dart';
import 'package:todoproject/ui/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  const RegisterScreen({super.key});

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
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
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
                decoration: const InputDecoration(
                  label: Text(
                    "user name",
                  ),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Email",
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Password",
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              ElevatedButton(
                  onPressed: () {
                    createAccount();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "Create account",
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void createAccount() async {
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser newUser = AppUser(
          id: userCredential.user!.uid, email: email, username: username);
      await addUserToFireStore(newUser);
      AppUser.currentUser = newUser;
      hideDialog(context);
      Navigator.pushNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (authError) {
      hideDialog(context);

      ///Hide loading
      String message = "";
      if (authError.code == 'weak-password') {
        message = "The password provided is too weak";
      } else if (authError.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      } else {
        message =
            authError.message ?? "Something went wrong please try again later";
      }
      if (context.mounted) {
        showMessage(context,
            title: "Error", body: message, posButtonTitle: "ok");
      }
    } catch (error) {
      hideDialog(context);

      print("Error = $error");
      showMessage(context,
          title: "Error!", body: "Something went wrong please later");
    }
  }

  Future addUserToFireStore(AppUser user) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(AppUser.collectionName);
    DocumentReference userDoc = usersCollection.doc(user.id);
    await userDoc.set(user.toJson());
  }
}
