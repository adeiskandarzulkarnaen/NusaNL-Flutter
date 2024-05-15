
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';


Future<File> convertUint8ListToFile({
  required Uint8List bytesData,
  String? fileNameFormat = "image_file.png",
}) async {
  String tempDir = (await getTemporaryDirectory()).path;
  File convertedFiles = File('$tempDir/$fileNameFormat');
  await convertedFiles.writeAsBytes(bytesData);
  return convertedFiles;
}


Uint8List? resizedPngImage({
  required Uint8List imageData,
  required int newWidth,
  required int newHeight
}) {
  // Decode the image from the bytes
  img.Image? originalImage = img.decodeImage(imageData);

  // Resize the image
  if(originalImage == null) return null;
  img.Image resizedImage = img.copyResize(
    originalImage,
    width: newWidth,
    height: newHeight
  );

  // Encode the resized image to PNG
  return Uint8List.fromList(img.encodePng(resizedImage));
}
