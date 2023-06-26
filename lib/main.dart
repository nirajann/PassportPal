import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:passportpal/Screens/splashscreen.dart';
import 'package:passportpal/provider/user_provider.dart';
import 'package:passportpal/responsive/mobileScreenLayout.dart';
import 'package:passportpal/responsive/responsivelayoutscreen.dart';
import 'package:passportpal/responsive/webScreenLayout.dart';
import 'package:passportpal/utlis/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCR6FgeeSVWnyAUGotBsLq6ReTUdYG7o5g',
            appId: '1:808875064250:android:74ab720bb10c0669633b83',
            messagingSenderId: '808875064250',
            projectId: 'passportpal-3d3d5',
            storageBucket: 'passportpal-3d3d5.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'instafly',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const SplashScreen();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  color: Colors.amber,
                ),
              );
            }

            return const SplashScreen(); // Splash screen widget
          },
        ),
      ),
    );
  }
}
