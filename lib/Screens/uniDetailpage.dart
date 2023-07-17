import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:passportpal/resources/FirestoreMethod.dart';
import 'package:passportpal/utlis/colors.dart';
import 'package:passportpal/widgets/unicommentcard.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversityDetailPage extends StatelessWidget {
  final String unid;
  final String text;
  final String unilocation;
  final String logo;
  final String description;
  final int fee;
  final int rate;
  final int likes;

  const UniversityDetailPage({
    Key? key,
    required this.unid,
    required this.text,
    required this.unilocation,
    required this.logo,
    required this.description,
    required this.fee,
    required this.rate,
    required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User not logged in, display simplified version
      return SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double screenHeight = constraints.maxHeight;
                final double screenWidth = constraints.maxWidth;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.3,
                        child: Image(
                          image: NetworkImage(logo),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        color: navyBlue,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    text,
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        unilocation,
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.02,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.favorite_border,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            likes.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          const Icon(
                                            Icons.insert_comment_outlined,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            '50',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                description,
                                style: TextStyle(
                                  fontSize: screenHeight * 0.025,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'TUTION AND FEES',
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.025,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            fee.toString(),
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.02,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'ACCEPTANCE RATE',
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.025,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            rate.toString(),
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.02,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: const [
                                          Text(
                                            'OverView',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'LEARN MORE',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: const [
                                          Text(
                                            'SAT RANGE',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '1200-1400',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Column(
                                children: [
                                  RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: screenHeight * 0.04,
                                    unratedColor: Colors.white,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      // TODO: Implement rating update logic
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Visit College to Learn More',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    height: 40,
                                    width: screenWidth * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // TODO: Implement button functionality
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'Read More',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      // User logged in, display original UniversityDetailPage
      return SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double screenHeight = constraints.maxHeight;
                final double screenWidth = constraints.maxWidth;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.3,
                        child: Image(
                          image: NetworkImage(logo),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('universities')
                            .doc(unid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (!snapshot.hasData) {
                            return Container();
                          }

                          final universityData =
                              snapshot.data!.data() as Map<String, dynamic>?;

                          if (universityData == null) {
                            return Container();
                          }

                          return Column(
                            children: [
                              Container(
                                color: navyBlue,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            universityData['uniname'],
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.035,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                universityData['unilocation'],
                                                style: TextStyle(
                                                  fontSize: screenHeight * 0.02,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      await FirestoreMethods()
                                                          .likeUniPost(
                                                        unid,
                                                        user.uid,
                                                        (universityData['likes']
                                                                as List<
                                                                    dynamic>)
                                                            .cast<String>(),
                                                      );
                                                    },
                                                    icon: universityData[
                                                                'likes']
                                                            .contains(user.uid)
                                                        ? const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors.black,
                                                          ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    universityData['likes']
                                                        .length
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              UniCommentCard(
                                                            uid: unid,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .insert_comment_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Text(
                                                    '50',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        universityData['unides'],
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.025,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'TUTION AND FEES',
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenHeight * 0.025,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    universityData['unifee']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenHeight * 0.02,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'ACCEPTANCE RATE',
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenHeight * 0.025,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    universityData['unirate']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenHeight * 0.02,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: const [
                                                  Text(
                                                    'OverView',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'LEARN MORE',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: const [
                                                  Text(
                                                    'SAT RANGE',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '1200-1400',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: screenHeight * 0.04,
                                            unratedColor: Colors.white,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              // TODO: Implement rating update logic
                                            },
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            'Visit College to Learn More',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Container(
                                            height: 40,
                                            width: screenWidth * 0.6,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                var url =
                                                    universityData['uniLink'];
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: const Text(
                                                'Read More',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
