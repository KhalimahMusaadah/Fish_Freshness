import 'package:fish_freshness/utils/ml_helper.dart';
import 'package:flutter/material.dart';
import 'screens/SplashScreen.dart';
import 'screens/HomePage.dart';
import 'screens/DeteksiPage.dart';
import 'screens/PanduanPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MLHelper.initialize();  // Load model sebelum runApp
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