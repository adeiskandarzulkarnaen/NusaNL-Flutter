// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class ImageClassificationPage extends StatefulWidget {
  const ImageClassificationPage({super.key});

  @override
  State<ImageClassificationPage> createState() => _ImageClassificationPageState();
}

class _ImageClassificationPageState extends State<ImageClassificationPage> {
  File? gambar;
  String label = 'null';
  double confidence = 0.0;

  Future<String?> _tfliteInit() async {
    String? res = await Tflite.loadModel(
      model: "assets/models/model_daun.tflite",
      labels: "assets/models/labels.txt",
      numThreads: 1,        // defaults to 1
      isAsset: true,        // defaults to true, set to false to load resources outside assets
      useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );
    return res; // success
  }

  Future<List?> _recognizeImage(String imagePath) async {
    List? recognitions = await Tflite.runModelOnImage(
      path: imagePath,  // required
      imageMean: 0.0,   // defaults to 117.0
      imageStd: 255.0,  // defaults to 1.0
      numResults: 2,    // defaults to 5
      threshold: 0.2,   // defaults to 0.1
      asynch: true,     // defaults to true
    );
    return recognitions;
  }

  Future<XFile?> _pickImageFromGalery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImageFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedImageFile == null) return null;
    return pickedImageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Klasifikasi Gambar"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: gambar == null
                ? Image.asset('assets/images/upload.jpg')
                : Image.file(gambar!)
            ),
            Text("lable: $label, confidence: ${confidence.toStringAsFixed(2)}%"),
            ElevatedButton(
              onPressed: () async {
                // todo: do anything
                XFile? pickedImage = await _pickImageFromGalery();
                
                if(pickedImage != null) {
                  print(pickedImage.path);
                  List? recognitionResult = await _recognizeImage(pickedImage.path);

                  setState(() {
                    gambar = File(pickedImage.path);
                    label = recognitionResult![0]['label'];
                    confidence = (recognitionResult[0]['confidence'] * 100);
                  });
                }
              }, 
              child: const Text('submit')
            )
          ],
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _tfliteInit();
  }
  
  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }
}