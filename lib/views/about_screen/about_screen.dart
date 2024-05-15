import 'package:flutter/material.dart';
import 'package:nusanl/views/about_screen/components/copyright_card.dart';
import 'package:nusanl/views/about_screen/components/developer_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("about app"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double imageCardWidth = constraints.maxWidth * 0.7;

          if (constraints.maxWidth >= 800) {
            imageCardWidth = constraints.maxWidth * 0.3;
          } else if (constraints.maxWidth >= 600) {
            imageCardWidth = constraints.maxWidth * 0.5;
          }

          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DeveloperCard(
                    name: 'Dr. Dede Kurniadi, M.Kom.',
                    role: 'Lecturer',
                    imageAsset: 'assets/images/drdedekurniadi.jpeg',
                    imageWidth: imageCardWidth,
                  ),
                  DeveloperCard(
                    name: 'Ade Iskandar Zulkarnaen',
                    role: 'Software Developer',
                    imageAsset: 'assets/images/adeiskandar.jpg',
                    imageWidth: imageCardWidth,
                  ),
                  const CopyrightCard(appName: 'NusaNL', copyRight: '©2023 itg.ac.id'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

