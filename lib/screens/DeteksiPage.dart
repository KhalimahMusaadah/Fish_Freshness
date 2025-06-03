import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class DeteksiPage extends StatefulWidget {
  const DeteksiPage({super.key});

  @override
  State<DeteksiPage> createState() => _DeteksiPageState();
}

// Pindahkan class State ke level yang sama (bukan di dalam class DeteksiPage)
class _DeteksiPageState extends State<DeteksiPage> {
  File? _selectedImage;
  bool _isProcessing = false;
  String? _detectionResult;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    
    if (pickedFile != null) {
      await _cropImage(File(pickedFile.path));
    }
  }

  Future<void> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
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
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _selectedImage = File(croppedFile.path);
        _detectionResult = null;
      });
    }
  }

  Future<void> _detectImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isProcessing = true;
      _detectionResult = null;
    });

    // Simulasi proses ML
    await Future.delayed(const Duration(seconds: 2));

    final randomResult = ['Segar', 'Tidak Segar', 'Sangat Segar'][DateTime.now().second % 3];

    setState(() {
      _isProcessing = false;
      _detectionResult = randomResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Kamera'),
                  onPressed: () => _getImage(ImageSource.camera),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Galeri'),
                  onPressed: () => _getImage(ImageSource.gallery), // Perbaiki dari camera ke gallery
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedImage == null
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 50, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Belum ada gambar dipilih'),
                          ],
                        ),
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.file(_selectedImage!, fit: BoxFit.contain),
                          if (_isProcessing)
                            Container(
                              color: Colors.black54,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
            
            if (_detectionResult != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _detectionResult == 'Segar' 
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Hasil: $_detectionResult',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _detectionResult == 'Segar' ? Colors.green : Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: _selectedImage == null || _isProcessing ? null : _detectImage,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
                disabledBackgroundColor: Colors.grey,
              ),
              child: _isProcessing
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Memproses...'),
                      ],
                    )
                  : const Text(
                      'DETEKSI SEKARANG',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}