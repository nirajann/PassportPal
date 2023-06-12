import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:passportpal/Screens/loginScreen.dart';
import 'package:passportpal/Screens/notiScreen.dart';
import 'package:passportpal/Screens/processScreen.dart';
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

  bool showSearchBar = false;

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

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the authentication state is loading
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data != null) {
          // User is logged in
          return Scaffold(
            backgroundColor: whiteColor,
            body: Column(
              children: [
                showSearchBar
                    ? const SizedBox(height: 60)
                    : const SizedBox(height: 0),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: showSearchBar ? 100 : 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 350,
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon: IconButton(
                              onPressed: () {
                                // Handle the search button click event
                                searchCountries();
                              },
                              icon:
                                  const Icon(Icons.search, color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showSearchBar = false;
                                  isShowUser = false;
                                });
                                searchController.clear();
                              },
                              icon:
                                  const Icon(Icons.clear, color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            filled: true,
                            fillColor: navyBlue,
                          ),
                          style: const TextStyle(color: Colors.white),
                          onSubmitted: (String _) {
                            searchCountries();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                showSearchBar
                    ? const SizedBox(height: 0)
                    : const SizedBox(height: 60),
                SizedBox(
                  height: showSearchBar ? 0 : 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!showSearchBar) ...[
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
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  showSearchBar = !showSearchBar;
                                });
                              },
                              icon: const Icon(Icons.search),
                              color: navyBlue,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                  Icons.notifications_active_outlined),
                              color: navyBlue,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                isShowUser
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                padding:
                                    const EdgeInsets.fromLTRB(20, 30, 0, 0),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                    ? const Text(
                        'Search Result',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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
                                    isGreaterThanOrEqualTo:
                                        searchController.text)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
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
                                        return ItemWidget(
                                            image: photoURL, title: title);
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
        } else {
          // User is not logged in
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text('login'))
                ],
              ),
            ),
          );
        }
      },
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProcessScreen(
                              image: imageUrl,
                              title: title,
                            ),
                          ),
                        );
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
