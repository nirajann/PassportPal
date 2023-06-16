import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passportpal/Screens/uniDetailpage.dart';
import 'package:passportpal/utlis/colors.dart';

class UniScreen extends StatefulWidget {
  const UniScreen({Key? key}) : super(key: key);

  @override
  State<UniScreen> createState() => _UniScreenState();
}

class _UniScreenState extends State<UniScreen> {
  final List<Color> gridItemColors = [
    const Color.fromRGBO(247, 141, 16, 1),
    const Color.fromRGBO(124, 17, 245, 1),
    const Color.fromRGBO(81, 240, 67, 1),
    const Color.fromRGBO(240, 103, 67, 1),
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            "SELECT FIELD",
            style: TextStyle(
              fontSize: 35,
              color: navyBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 350,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: navyBlue,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('universities').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No data found.'),
                );
              }

              final documents = snapshot.data!.docs;

              final filteredDocuments = documents.where((doc) {
                final String uniname = doc['uniname'] as String;
                return uniname
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase());
              }).toList();

              return Column(
                children: filteredDocuments.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final QueryDocumentSnapshot<Object?> doc = entry.value;

                  final Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  final String text = data['uniname'] as String;
                  final String unilocation = data['unilocation'] as String;
                  final String logo = data['logo'] as String;
                  final String description = data['unides'] as String;
                  final int fee = data['unifee'];
                  final int rate = data['unirate'];

                  final Color color =
                      gridItemColors[index % gridItemColors.length];

                  return GestureDetector(
                    onTap: () {
                      navigateToUniversityDetail(context, text, unilocation,
                          logo, description, fee, rate);
                    },
                    child: RectangleCard(
                      text: text,
                      unilocation: unilocation,
                      color: color,
                      imagePath: logo,
                      description: description,
                      fee: fee,
                      rate: rate,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  void navigateToUniversityDetail(
      BuildContext context,
      String text,
      String unilocation,
      String logo,
      String description,
      int unirate,
      int fee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UniversityDetailPage(
          text: text,
          unilocation: unilocation,
          logo: logo,
          description: description,
          rate: unirate,
          fee: fee,
        ),
      ),
    );
  }
}

class RectangleCard extends StatelessWidget {
  final String text;
  final String unilocation;
  final Color color;
  final String imagePath;
  final String description;
  final int rate;
  final int fee;

  const RectangleCard({
    Key? key,
    required this.text,
    required this.unilocation,
    required this.color,
    required this.imagePath,
    required this.description,
    required this.rate,
    required this.fee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          navigateToUniversityDetail(
              context, text, unilocation, imagePath, description, rate, fee);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 332,
            height: 135,
            decoration: BoxDecoration(
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  image: NetworkImage(imagePath),
                  width: 100,
                  height: 100,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 45, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Center(
                          child: Text(
                            unilocation,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToUniversityDetail(
      BuildContext context,
      String text,
      String unilocation,
      String logo,
      String description,
      int unirate,
      int fee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UniversityDetailPage(
          text: text,
          unilocation: unilocation,
          logo: logo,
          description: description,
          rate: unirate,
          fee: fee,
        ),
      ),
    );
  }
}

// void navigateToUniversityDetail(
//     BuildContext context, String text, String unilocation, String logo) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => UniversityDetailPage(
//         text: text,
//         unilocation: unilocation,
//         logo: logo,
//       ),
//     ),
//   );
// }
