
import 'package:flutter/material.dart';

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
