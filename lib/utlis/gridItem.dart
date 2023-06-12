import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final Color color;
  final String image;
  final String title;

  const GridItem({
    super.key,
    required this.color,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: 200,
        width: 180,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
              10), // Give a radius value to specify the amount of rounding
        ),
        child: Column(
          children: [
            Image(
              image: NetworkImage(image),
              width: 100,
              height: 100,
            ),
            Container(
              child: SizedBox(
                height: 20,
                width: 130,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // Give a radius value to specify the amount of rounding
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement the view more button action
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: color,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  color: color.withBlue(115),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: InkResponse(
                  onTap: () {
                    // Handle button tap
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: const Text(
                      'View More',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
