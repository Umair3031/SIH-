import 'package:bliss/screens/Loginscreen.dart';
import 'package:bliss/screens/homepage.dart';
import 'package:bliss/screens/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginscreen(),
      routes: {
        "/login":(context) => Loginscreen(),
        "/signup":(context) => Signupscreen(),
        "/home":(context) => HomePage(),

      },
    );
  }
}




    

