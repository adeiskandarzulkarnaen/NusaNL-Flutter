import 'package:flutter/material.dart';
import 'package:nusanl/home_page.dart';

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
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
