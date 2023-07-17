import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final User? user = FirebaseAuth.instance.currentUser;

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
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: navyBlue,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  labelStyle: const TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future:
                  FirebaseFirestore.instance.collection('universities').get(),
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

                return GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 3,
                  padding: const EdgeInsets.all(8),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: filteredDocuments.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final QueryDocumentSnapshot<Object?> doc = entry.value;

                    final Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    final String text = data['uniname'] as String;
                    final String unilocation = data['unilocation'] as String;
                    final String logo = data['logo'] as String;
                    final String description = data['unides'] as String;
                    final int fee = int.parse(data['unifee'].toString());
                    final int rate = data['unirate'] as int;
                    final int likes = data['likes'].length;
                    final String unid = data['unid'];

                    final Color color =
                        gridItemColors[index % gridItemColors.length];

                    return GestureDetector(
                      onTap: () {
                        navigateToUniversityDetail(context, text, unilocation,
                            logo, description, fee, rate, likes, unid);
                      },
                      child: RectangleCard(
                        text: text,
                        unilocation: unilocation,
                        color: color,
                        imagePath: logo,
                        description: description,
                        fee: fee,
                        rate: rate,
                        likes: likes,
                        unid: unid,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
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
    int likes,
    int fee,
    String unid,
  ) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UniversityDetailPage(
            unid: unid,
            likes: likes,
            text: text,
            unilocation: unilocation,
            logo: logo,
            description: description,
            rate: unirate,
            fee: fee,
          ),
        ),
      );
    } else {
      // Pass dummy data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UniversityDetailPage(
            unid: unid,
            text: text,
            unilocation: unilocation,
            logo: logo,
            description: 'Dummy description',
            rate: 0,
            fee: 0,
            likes: 0,
          ),
        ),
      );
    }
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
  final int likes;
  final String unid;

  const RectangleCard({
    Key? key,
    required this.text,
    required this.unilocation,
    required this.color,
    required this.imagePath,
    required this.description,
    required this.rate,
    required this.fee,
    required this.likes,
    required this.unid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToUniversityDetail(context, text, unilocation, imagePath,
            description, rate, fee, likes, unid);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 4,
        color: color,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                imagePath,
                width: 120,
                height: 120,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      unilocation,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
      int fee,
      int likes,
      String unid) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UniversityDetailPage(
            unid: unid,
            text: text,
            unilocation: unilocation,
            logo: logo,
            description: description,
            rate: unirate,
            fee: fee,
            likes: likes,
          ),
        ),
      );
    } else {
      // Pass dummy data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UniversityDetailPage(
            unid: "2asdas",
            text: "Passport Pal Universty Guide",
            unilocation: "kAthmandu,Nepal",
            logo:
                "https://th.bing.com/th/id/OIP.YHVG8LxBhqtMxYPa4-enxgAAAA?pid=ImgDet&w=247&h=296&rs=1",
            description:
                'Welcome to our Visa and University Information app! We understand that planning your education abroad can be a complex',
            rate: 0,
            fee: 0,
            likes: 0,
          ),
        ),
      );
    }
  }
}
