import 'package:flutter/material.dart';

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

class DeveloperCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageAsset;
  final double imageWidth;

  const DeveloperCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageAsset,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: imageWidth,
          // padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(top: 24, bottom: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.red,
              width: 4,
            ),
          ),
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                imageAsset,
              ),
            ),
          ),
        ),
        Text(name, style: const TextStyle(fontSize: 24)),
        Text(role, style: const TextStyle(fontSize: 14)),
      ]
    );
  }
}

class CopyrightCard extends StatelessWidget {
  final String appName;
  final String copyRight;
  
  const CopyrightCard({
    super.key, 
    required this.appName,
    required this.copyRight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            appName,
            style: const TextStyle(
              // color: Colors.grey,
              fontSize: 16.0,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            copyRight,
            style: const TextStyle(
              // color: Colors.grey,
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
