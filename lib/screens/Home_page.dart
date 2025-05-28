import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Identifikasi Kesegaran Ikan"),
      ),
      body: const Center(
        child: Text(
          'Selamat datang di aplikasi identifikasi kesegaran ikan!',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
