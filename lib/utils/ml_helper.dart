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
    _imageProcessor = ImageProcessorBuilder().add(ResizeOp(224, 224, ResizeMethod.BILINEAR)).add(NormalizeOp(127.5, 127.5)).build(); //menyesuaikan input gambar dan normalisasi (kayaknya normalisasi di 0-1 deh, check lagi!!)
    _isInitialized = true;
  }

  static Future<String> classifyImage(File image) async {
    if (!_isInitialized) await initialize();

    //konversi gambar ke tensor
    TensorImage tensorImage = TensorImage.fromFile(image);
    tensorImage = _imageProcessor.process(tensorImage);

    //menyiapkan output buffer (gw ga pahammmmmmmmmmmmm. PELAJARIN INI!!)
    TensorBuffer outputBuffer = TensorBuffer.createFixedSize(
      _interpreter.getOutputTensor(0).shape,
      _interpreter.getOutputTensor(0).type,
    );

    //menjalankan inference
    _interpreter.run(tensorImage.buffer, outputBuffer.buffer);

    //proses hasilnya
    List<String> labels = ['Sangat Segar', 'Segar', 'Tidak Segar'];

    int predictedIndex = argMax(outputBuffer.getDoubleList());
    double confidence = outputBuffer.getDoubleList()[predictedIndex];

    return '${labels[predictedIndex]} (${(confidence * 100).toStringAsFixed(1)}%)';
  }

  static int argMax(List<double> probabilities){
    int maxIndex = 0;
    double maxProb = probabilities[0];

    for (int i = 1; i < probabilities.length; i++){
      if (probabilities[i] > maxProb) {
        maxIndex = i;
        maxProb = probabilities[i];
      }
    }
    return maxIndex;
  }
}