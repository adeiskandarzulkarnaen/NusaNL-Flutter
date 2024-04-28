import 'package:flutter/material.dart';
import 'package:nusanl/screen/canvas_drawing_page.dart';

void main() {
  runApp(const NusaNL());
}

class NusaNL extends StatelessWidget {
  const NusaNL({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NusaNL",
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CanvasDrawingPage(),
    );
  }
}
