import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mecha_app/signup_login/login.dart';
import 'package:mecha_app/signup_login/signup.dart';
import 'fetch/fetcher_mechanic.dart';
import 'fetch/map.dart';
import 'firebase_options.dart';

import 'homecreen/about_screen.dart';
import 'homecreen/homescreen.dart';
import 'homecreen/welcome_screen.dart';
import 'infor/list_of_engineers.dart';

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
      home: WelcomeScreen(),
      routes: {
        '/LoginScreen': (context) => LoginScreen(),
        '/mechanic': (context) => NearbyMechanicsScreen(),
        '/SignUpScreen': (context) => SignUpScreen(),
        '/about': (context) => AboutPage(),
        '/home': (context) => HomeScreen(),
        '/details': (context) => MechanicsListScreen(),
        '/my map': (context) => MapScreen(),// Register the SignUpScreen route
      },
    );
  }
}
