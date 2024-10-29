import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mecha_app/signup_login/login.dart';
import 'package:mecha_app/signup_login/signup.dart';
import 'package:mecha_app/user_engineer/engineer.dart';
import 'package:mecha_app/user_engineer/register_mechanic.dart';
import 'Ai directory/AI.dart';
import 'fetch/fetcher_mechanic.dart';
import 'fetch/map.dart';
import 'firebase_options.dart';
import 'homecreen/about_screen.dart';
import 'homecreen/homescreen.dart';
import 'homecreen/role_as_user_or_mechanic.dart';
import 'homecreen/welcome_screen.dart';
import 'infor/editMechanicProfile.dart';
import 'infor/engineers_details.dart';
import 'infor/list_of_engineers.dart';
import 'infor/my_engineer.dart';
 // Import the new Role Selection Screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyB5n1eGqZNyaWCaamWCp7MklfX-unR8Ckg",
        authDomain: "mecha-application.firebaseapp.com",
        projectId: "mecha-application",
        storageBucket: "mecha-application.appspot.com",
        messagingSenderId: "700065310863",
        appId: "1:700065310863:web:81a271f9d027cdc1a128fa",
      ),
    );
  } else {
    await Firebase.initializeApp();
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
      home: WelcomeScreen(), // Set the Role Selection Screen as home
      routes: {
        '/register': (context) => RegisterMechanicScreen(),
        '/LoginScreen': (context) => LoginScreen(),
        '/mechanic': (context) => NearbyMechanicsScreen(),
        '/SignUpScreen': (context) => SignUpScreen(),
        '/about': (context) => AboutPage(),
        '/role': (context) => RoleSelectionScreen(),
        '/home': (context) => HomeScreen(),
        '/findEngineer': (context) => MechanicsListScreen(),
        '/details': (context) => EngineerProfileUploadScreen(),
        '/my map': (context) => MapScreen(),
        '/Ai': (context) => AIProblemDetectionScreen(),
      },
    );
  }
}
