import 'package:flutter/material.dart';
import 'screens/SplashScreen.dart';
import 'screens/HomePage.dart';
import 'screens/DeteksiPage.dart';
import 'screens/PanduanPage.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', //
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/deteksi': (context) => DeteksiPage(),
        '/panduan': (context) => PanduanPage(),
      },
    );
  }
}