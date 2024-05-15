// import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:signature/signature.dart';

import 'package:nusanl/utils/image.dart';
import 'package:nusanl/utils/tflite.dart';
import 'package:nusanl/configs/tflite_config.dart';
import 'package:nusanl/views/about_screen/about_screen.dart';


class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  String? label;
  double? confidence;

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3.0,
    penColor: Colors.black,
    exportBackgroundColor: Colors.black,
    exportPenColor: Colors.white,
    // onDrawEnd: ()  => log("do anything"),
  );

  @override
  void initState() {
    super.initState();

    Tflite.close();
    Tflite.loadModel(
      model: TfLiteConfig.tfliteAssetModel,
      labels: TfLiteConfig.tfliteAssetLabels,
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    ); // .then((value) => log(value!)); // todo: remove this debug

    _signatureController.onDrawEnd = () {
      recognizeCanvasImage();
      // log("merecognize gambar"); // todo: remove this debug
    };
  }

  @override
  void dispose() {
    _signatureController.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text("NusaNL"),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right: 24.0,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AboutScreen();
                }));
              },
              icon: const Icon(Icons.info_outline)
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (label != null && confidence != null)
              Text("lable: $label, confidence: ${confidence?.toStringAsFixed(2)}%"),
            Signature(
              controller: _signatureController,
              width: 300,  // width canvas 
              height: 300, // height canvas
              backgroundColor: Colors.lightBlue[100]!,
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _signatureController.clear();
                });
              },
              child: const Text("clear")
            ),
          ],
        ),
      ),
    );
  }

  Future<void> recognizeCanvasImage() async {
    // Export the canvas image to PNG bytes
    Uint8List? exportedCanvasImage = await _signatureController.toPngBytes(
      width: 300, // todo: samakan dengan Signature() widget
      height: 300, // todo: samakan dengan Signature() widget
    );

    if (exportedCanvasImage == null) return;

    // Resize the exported image
    Uint8List? resizedImage = resizedPngImage(
      imageData: exportedCanvasImage,
      newWidth: TfLiteConfig.tfliteInputWidth,
      newHeight: TfLiteConfig.tfliteInputHeight,
    );

    if(resizedImage == null) return;

    // Convert the resized image to a file
    File resizedImageFile = await convertUint8ListToFile(bytesData: resizedImage);

    // Recognize the image from the file
    List? recognitionResult = await recognizeImageOnFile(imageFile: resizedImageFile);

    if (recognitionResult != null && recognitionResult.isNotEmpty) {
      setState(() {
        label = recognitionResult[0]['label'];
        confidence = (recognitionResult[0]['confidence'] * 100);
      });
    }
  }

}
