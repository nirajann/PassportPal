import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:passportpal/Screens/editprofile.dart';
import 'package:passportpal/auth/loginScreen.dart';
import 'package:passportpal/resources/auth_methods.dart';
import 'package:passportpal/utlis/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User is not logged in, display the login prompt UI
      return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Center(child: Text('Profile')),
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 120, color: primaryColor),
              const SizedBox(height: 16.0),
              const Text(
                'Please log in to view your profile',
                style: TextStyle(fontSize: 18.0, color: primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Log In'),
              ),
            ],
          ),
        ),
      );
    }

    Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
      return FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Center(child: Text('Profile')),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Data is still loading
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Error occurred while fetching data
            return const Center(child: Text('Error occurred'));
          }

          final userData = snapshot.data!.data();
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  height: 150,
                  color: primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(180, 90, 0, 0),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(
                      userData?['photourl'],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(180, 200, 0, 0),
                child: Text(
                  userData?['username'],
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(150, 230, 0, 0),
                child: Text(
                  userData?['email'],
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color.fromARGB(245, 10, 10, 10),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(180, 260, 0, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          username: userData?['username'],
                          email: userData?['email'],
                          photoUrl: userData?['photourl'],
                          phone: userData?['phoneno'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    color: Colors.black,
                    child: const Center(child: Text('Edit Profile')),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () async {
                    // Show logout confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop(); // Close the dialog
                                await AuthMethods().signOut();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const SizedBox(
                    height: 60,
                    width: 60,
                    child: Icon(Icons.logout_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    16, 280, 0, 0), // Adjust the left padding as needed
                child: ListTile(
                  title:
                      const Text('Mini Heading 1.2', textAlign: TextAlign.left),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Align the buttons to the left
                    children: [
                      TextButton(
                        onPressed: () {
                          // Add functionality for Text Button 3
                        },
                        child: const Text(
                          'Trending',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add functionality for Text Button 1
                        },
                        child: const Text(
                          'News',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add functionality for Text Button 2
                        },
                        child: const Text(
                          'Favorite',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
