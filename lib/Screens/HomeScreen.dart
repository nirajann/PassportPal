import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:passportpal/Process/processScreen.dart';
import 'package:passportpal/Screens/notiScreen.dart';
import 'package:passportpal/utlis/ImageItem.dart';
import 'package:passportpal/utlis/colors.dart';

import '../utlis/gridItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  bool isShowUser = false;
  void searchCountries() {
    setState(() {
      isShowUser = true;
    });
  }

  bool _isSearchBarVisible = true;

  void _toggleSearchBar() {
    setState(() {
      _isSearchBarVisible = false;
    });
  }

  bool showitem = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  List<String> titles = [
    'Usa',
    'Canada',
    'Aus',
    'Title 4',
    'Title 5',
  ];

  final List<Color> gridItemColors = [
    const Color.fromRGBO(247, 141, 16, 1),
    const Color.fromRGBO(124, 17, 245, 1),
    const Color.fromRGBO(81, 240, 67, 1),
    const Color.fromRGBO(240, 103, 67, 1),
  ];

  @override
  Widget build(BuildContext context) {
    // Your existing code...
    // User is logged in
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  "Discover",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: navyBlue,
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _toggleSearchBar();
                    },
                    child: AnimSearchBar(
                      width: 220,
                      searchIconColor: navyBlue,
                      textController: searchController,
                      onSuffixTap: () {
                        setState(() {
                          searchController.clear();
                        });
                      },
                      helpText: "Search Text...",
                      autoFocus: true,
                      onSubmitted: (String searchController) =>
                          searchCountries(),
                      closeSearchOnSuffixTap: false,
                      animationDurationInMilli: 500,
                      rtl: false,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.notifications_active_outlined),
                    color: navyBlue,
                  ),
                ],
              ),
            ],
          ),
          isShowUser
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4C4478), Color(0xFF0C0C69)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Text(
                                  "PassportPal",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Empowering Global Explorers",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Simplifying Visas and Unlocking\nEducation Opportunities",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                "assets/png/pplogo.png",
                                width: 165,
                                height: 165,
                                // Additional image properties as needed
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          isShowUser
              ? Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back),
                      color: navyBlue,
                    ),
                    const Text(
                      'Search Result',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Popular Countries',
                          style: TextStyle(
                            fontSize: 20,
                            color: navyBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance
                          .collection('Countries')
                          .where('title',
                              isGreaterThanOrEqualTo: searchController.text)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('No data found.'),
                          );
                        }

                        var documents = snapshot.data!.docs;

                        return SizedBox(
                          height:
                              90, // Adjust the height according to your needs
                          child: FutureBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            future: FirebaseFirestore.instance
                                .collection('Countries')
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text('Error fetching data'),
                                );
                              }
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(
                                  child: Text('No data available'),
                                );
                              }

                              var documents = snapshot.data!.docs;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  var data = documents[index].data();
                                  var photoURL = data['photoURL'];
                                  var title = data['title'];
                                  var documentId = documents[index]
                                      .id; // Retrieve the document ID
                                  return ItemWidget(
                                    image: photoURL,
                                    title: title,
                                    documentId:
                                        documentId, // Pass the document ID to ItemWidget
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
          Expanded(
            child: isShowUser ? buildSearchResult() : buildTopCountries(),
          ),
        ],
      ),
    );
  }

  Widget buildSearchResult() {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('Countries')
          .where('title', isGreaterThanOrEqualTo: searchController.text)
          .get(),
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

        var documents = snapshot.data!.docs;

        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          children: List.generate(documents.length, (index) {
            var data = documents[index].data();
            var photoURL = data['photoURL'];
            var title = data['title'];
            var color = gridItemColors[index % gridItemColors.length];
            return GridItem(
              color: color,
              image: photoURL,
              title: title,
            );
          }),
        );
      },
    );
  }

  Widget buildTopCountries() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 330,
        viewportFraction: 0.6,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: List.generate(4, (index) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors
                      .grey, // Optional fallback color while loading the image
                ),
                child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future:
                      FirebaseFirestore.instance.collection('Countries').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return const Text('Error fetching data');
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Text('No data available');
                    }

                    var documents = snapshot.data!.docs;
                    if (index >= documents.length) {
                      return const SizedBox();
                    }

                    var imageUrl = documents[index].data()['background'];
                    var title = documents[index].data()['title'];

                    return GestureDetector(
                      onTap: () async {
                        User? user = FirebaseAuth.instance.currentUser;

                        if (user == null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Login Required',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: const Text(
                                  'Please log in to continue.',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.blue[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Close the dialog
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigate to the login screen
                                      Navigator.pushReplacementNamed(
                                          context, '/login');
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProcessScreen(
                                image: imageUrl,
                                title: title,
                                documentId: "",
                              ),
                            ),
                          );
                        }
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 16,
                            left: 16,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
