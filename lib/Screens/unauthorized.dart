import 'package:flutter/material.dart';

class UnAuthorized extends StatelessWidget {
  const UnAuthorized({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://th.bing.com/th/id/OIP.afR1e_TSR16DSTTsakOMAAHaFC?pid=ImgDet&rs=1',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'How To Apply For Canada',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              "You need to log in to view the content of blogs",
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                // Handle log in button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child:
                  const Text('Log In', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
