import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:passportpal/responsive/responsivelayoutscreen.dart';
import 'package:passportpal/utlis/colors.dart';

import '../responsive/mobileScreenLayout.dart';
import '../responsive/webScreenLayout.dart';

class ProcessSixScreen extends StatefulWidget {
  final String image;
  final String title;
  final String documentId; // New property to store the document ID

  const ProcessSixScreen({
    Key? key,
    required this.image,
    required this.title,
    required this.documentId, // Pass the document ID to the screen
  }) : super(key: key);

  @override
  _ProcessSixScreenState createState() => _ProcessSixScreenState();
}

class _ProcessSixScreenState extends State<ProcessSixScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 40, // Set the desired height here
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Countries')
              .doc(widget.documentId)
              .collection('ProcessSix')
              .limit(1) // Limit the query to retrieve only one document
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching data'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }

            final document = snapshot.data!.docs.first;
            final data = document.data();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: navyBlue,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: navyBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '6. ${data['ProcessSixTitle']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            data['ProcessSixDes'],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Image.network(
                            data['ProcessSixImg'],
                            width: 300,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Perform some action when the button is pressed
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Text('Learn More'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 14, 14, 14)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResponsiveLayout(
                                    mobileScreenLayout: MobileScreenLayout(),
                                    webScreenLayout: WebScreenLayout(),
                                  )),
                        );
                      },
                      icon: const Icon(
                        Icons.home_rounded,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
