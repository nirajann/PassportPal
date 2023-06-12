import 'package:flutter/material.dart';

class UniversityDetailPage extends StatelessWidget {
  final String text;
  final String unilocation;
  final String logo;

  const UniversityDetailPage({
    Key? key,
    required this.text,
    required this.unilocation,
    required this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(logo),
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            unilocation,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          // Add more details here
        ],
      ),
    );
  }
}
