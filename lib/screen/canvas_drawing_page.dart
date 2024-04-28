
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:signature/signature.dart';

class CanvasDrawingPage extends StatefulWidget {
  const CanvasDrawingPage({super.key});

  @override
  State<CanvasDrawingPage> createState() => _CanvasDrawingPageState();
}

class _CanvasDrawingPageState extends State<CanvasDrawingPage> {

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3.0,
    penColor: Colors.black,
    exportBackgroundColor: Colors.black,
    exportPenColor: Colors.white,
    onDrawEnd: () => log("gambar lepas"),
  );

  Future<String?> _tfliteInit() async {
    String? res = await Tflite.loadModel(
      model: "assets/models/num_cnn.tflite",
      labels: "assets/models/num_cnnlabels.txt",
      numThreads: 1,        // defaults to 1
      isAsset: true,        // defaults to true, set to false to load resources outside assets
      useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );
    return res; // success
  }

  Future<List?> recognizeByteImage(Uint8List imageByte) async {
    List? recognitions = await Tflite.runModelOnBinary(
      binary: imageByte,// required
      numResults: 6,    // defaults to 5
      threshold: 0.05,  // defaults to 0.1
      asynch: true      // defaults to true
    );
    return recognitions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menggambar di Canvas"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Signature(
              controller: _signatureController,
              width: 244,
              height: 244,
              backgroundColor: Colors.lightBlue[100]!,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    log("submit ditekan");
                    Uint8List? exportedImage = await _signatureController.toPngBytes(width: 244, height: 244);

                    if(exportedImage != null) {
                      List? result = await recognizeByteImage(exportedImage);
                      if(result != null) log(result.toString());
                    }
                  }, 
                  child: const Text("submit")
                ),
                
                const SizedBox(width: 20,),
                
                ElevatedButton(
                  onPressed: () {
                    setState(() => _signatureController.clear());
                  }, 
                  child: const Text("clear")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tfliteInit();

    log("Load Model berhasil!!!");
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
    _signatureController.dispose();
  }
}