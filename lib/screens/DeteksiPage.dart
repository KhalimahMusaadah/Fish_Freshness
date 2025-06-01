import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import '../widgets/MyAppBar.dart';

class DeteksiPage extends StatefulWidget{
 const DeteksiPage({super.key});

 @override
 _DeteksiPageState createState() => _DeteksiPageState();

 class _DeteksiPageState extends State<DeteksiPage>{
  File? _selectedImage;
  bool _isProcessing = false;
  String? _detectionResult;
  final ImagePicker _picker = ImagePicker();

  Future<void>_cropImage(File imageFile) async{
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      AspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blueAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    if(croppedFile != null){
      setState((){
        _selectedImage = File(croppedFile.path);
        _detectionResult = null;
      });
    }
  }

  Future<void> _detectImage() async{
    if (_selectedImage == null) return;

    setState((){
      _isProcessing = true;
      _detectionResult = null;
    });

    //ini buat nanti proses MLnya
    await Future.delayed(const Duration(seconds: 2));

    //buat hasil deteksi
    final randomResult = ['Segar', 'Tidak Segar', 'Sangat Segar'][DateTime.now().second % 3];

    setState((){
      _isProcessing = false;
      _detectionResult = randomResult;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: MyAppBar(
        title: 'Deteksi',
        showBackButton: true,
      ),
    )
  }
 }
}