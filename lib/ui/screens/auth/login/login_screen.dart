// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:todoproject/model/app_users.dart';
import 'package:todoproject/ui/screens/auth/register/register_screen.dart';
import 'package:todoproject/ui/screens/home/home.dart';
import 'package:todoproject/ui/utils/dialog_utils.dart';
import 'package:todoproject/ui/utils/extension_date.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Login"),
        toolbarHeight: MediaQuery.of(context).size.height * .1,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .25,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Welcome back !",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
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
                  validator: (text) {
                    if (text == null || text.isEmpty == true) {
                      return "emails can not be empty";
                    }
                    if (!text.isValidEmail) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  onChanged: (text) {
                    password = text;
                  },
                  obscureText: true,
                  validator: (password) {
                    if (password == null || password.isEmpty == true) {
                      return "empty passwords are not allowed";
                    }
                    if (password.length < 6) {
                      return "passwords can not be less than 6 charcters";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text(
                      "Password",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      child: Row(
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 18,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: const Text(
                    "Create account",
                    style: TextStyle(fontSize: 18, color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (!formKey.currentState!.validate()) return;
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser.currentUser =
          await getUserFromFireStore(userCredential.user!.uid);
      hideDialog(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (authError) {
      print("FirebaseAuthException = ${authError.code}");
      hideDialog(context);

      ///Hide loading
      String message = "";
      if (authError.code == 'channel-error') {
        message = "Wrong email or password Pleas double your creds.";
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

      ///Hide loading
      print("Error = $error");
      showMessage(context,
          title: "Error!", body: "Something went wrong please later");
    }
  }

  Future<AppUser> getUserFromFireStore(String id) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(AppUser.collectionName);
    DocumentReference userDoc = usersCollection.doc(id);
    DocumentSnapshot snapshot = await userDoc.get();
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    return AppUser.fromJson(json);
  }
}
