
import 'package:flutter/material.dart';

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

