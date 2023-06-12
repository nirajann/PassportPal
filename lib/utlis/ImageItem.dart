import 'package:flutter/material.dart';
import 'package:passportpal/Screens/processScreen.dart';

class ItemWidget extends StatelessWidget {
  final String image;
  final String title;

  const ItemWidget({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProcessScreen(
                    image: image,
                    title: title,
                  )), // Replace 'ProcessScreen' with your actual screen widget
        );
      },
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              image,
              width: 60,
              height: 30,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 90,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
