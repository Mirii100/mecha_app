import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mecha_app/signup_login/login.dart';
import 'package:mecha_app/signup_login/signup.dart';
import 'firebase_options.dart';

import 'homecreen/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with FirebaseOptions
 // await Firebase.initializeApp(
   // options: FirebaseOptions(
     // apiKey: "AIzaSyC-9eHomnu9bryiKTOf6azMR7ZC7wgEnTU",
      //appId: "1:935332776626:web:b9fd64ac2d5c889ce317ab",
      //messagingSenderId: "935332776626",
      //projectId: "flutterproject-48bf4",
      //storageBucket: "flutterproject-48bf4.appspot.com",
    //),
 // );
if(kIsWeb){
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey:"AIzaSyC-9eHomnu9bryiKTOf6azMR7ZC7wgEnTU",
        appId: "1:935332776626:web:b9fd64ac2d5c889ce317ab",
        messagingSenderId: "935332776626",
        projectId: "mechaapp-5a0bf"
    )
);}else{
 await  Firebase.initializeApp();
}




  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Tracker App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      routes: {
        '/LoginScreen': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/SignUpScreen': (context) => SignUpScreen(), // Register the SignUpScreen route
      },
    );
  }
}
