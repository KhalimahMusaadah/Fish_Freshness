import 'dart:io';

class MLHelper {
  static Future<String> classifyImage(File image) async {
    // buat implementasi ML
    
    // Contoh dummy 
    await Future.delayed(const Duration(seconds: 1));
    return ['Segar', 'Tidak Segar', 'Kurang Segar'][DateTime.now().second % 3];
  }
}