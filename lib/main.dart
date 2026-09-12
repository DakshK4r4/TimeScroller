import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_Screen_Layout.dart';
import 'package:instagram_clone/responsive/web_Screen_Layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

import 'firebase_options.dart';

import 'responsive/responsive_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBVtvCqSNMr5ztEDaKhhOTtLOl3MyCseZ8',
        appId: '1:516492055753:web:2e516777b26b27f7f86918',
        messagingSenderId: "516492055753",
        projectId: "instagram-clone-f2181",
        storageBucket: "instagram-clone-f2181.firebasestorage.app",
        authDomain: "AIzaSyBVtvCqSNMr5ztEDaKhhOTtLOl3MyCseZ8",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: Scaffold(
      //   body: const ResponsiveLayout(
      //     mobileScreenLayout: MobileScreenLayout(),
      //     webScreenLayout: WebScreenLayout(),
      //   ),
      // ),
      home: SignupScreen(),
    );
  }
}
