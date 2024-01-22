import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:instagram_firebase/firebase_options.dart';
import 'package:instagram_firebase/screens/home_screen.dart';
import 'package:instagram_firebase/screens/login_screen.dart';
import 'package:instagram_firebase/screens/signup_screen.dart';
import 'package:instagram_firebase/utiils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'INSTAGRAM FIREBASE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return LoginScreen();
            } else if (snapshot.hasError){
              return Center(
                child: Text("${snapshot.hasError}"),
              );
            }
          }

          if( snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return LoginScreen();
        },
      ),
    );
  }
}
