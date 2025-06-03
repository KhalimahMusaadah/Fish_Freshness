import 'dart:ffi';
import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class MLHelper {
  static late Interpreter _interpreter;
  static late ImageProcessor _imageProcessor;
  static bool _isInitialized = false;

  //menginisialisasi model
  static Future<void> initialize() async{
    if (_isInitialized) return;

    //load modelnya
    _interpreter = await Interpreter.fromAsset('assets/models/model.tflite');

    //Setup image processor
  }

  static Future<String> classifyImage(File image) async {
    if (_isInitialized) return;
    
    // Contoh dummy 
    await Future.delayed(const Duration(seconds: 1));
    return ['Segar', 'Tidak Segar', 'Kurang Segar'][DateTime.now().second % 3];
  }
}