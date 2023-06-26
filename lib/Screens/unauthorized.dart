import 'package:flutter/material.dart';

class unAuthorized extends StatelessWidget {
  const unAuthorized({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        "not logged in",
        style: TextStyle(color: Colors.amber),
      ),
    );
  }
}
