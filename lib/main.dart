import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoproject/firebase_options.dart';
import 'package:todoproject/ui/screens/home/home.dart';
import 'package:todoproject/ui/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routes: {
        Home.routeName: (context) => const Home(),
      },
      initialRoute: Home.routeName,
    );
  }
}
