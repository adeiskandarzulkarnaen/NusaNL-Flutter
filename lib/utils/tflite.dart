
import 'dart:io';
import 'package:flutter_tflite/flutter_tflite.dart';

Future<List?> recognizeImageOnFile({required File imageFile}) async {
  List? recognitions = await Tflite.runModelOnImage(
    path: imageFile.path,
    imageMean: 0.0,
    imageStd: 255.0,
    numResults: 2,
    threshold: 0.2,
    asynch: true,
  );
  return recognitions;
}
