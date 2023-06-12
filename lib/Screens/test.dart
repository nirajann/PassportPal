// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:passportpal/Screens/loginScreen.dart';
// import 'package:passportpal/Screens/notiScreen.dart';
// import 'package:passportpal/Screens/processScreen.dart'; // Import the ProcessScreen
// import 'package:passportpal/utlis/ImageItem.dart';
// import 'package:passportpal/utlis/colors.dart';

// import '../utlis/gridItem.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // Existing code...

//   Widget buildTopCountries() {
//     return CarouselSlider(
//       options: CarouselOptions(
//         // Existing options...
//       ),
//       items: List.generate(4, (index) {
//         return Builder(
//           builder: (BuildContext context) {
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(30),
//               child: Container(
//                 // Existing container properties...
//                 child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                   future:
//                       FirebaseFirestore.instance.collection('Countries').get(),
//                   builder: (context, snapshot) {
//                     // Existing builder logic...

//                     if (index >= documents.length) {
//                       return const SizedBox();
//                     }

//                     var imageUrl = documents[index].data()['background'];
//                     var title = documents[index].data()['title'];

//                     return GestureDetector( // Wrap with GestureDetector
//                       onTap: () {
//                         // Handle navigation to ProcessScreen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProcessScreen(
//                               imageUrl: imageUrl,
//                               title: title,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Stack(
//                         // Existing stack properties...
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }

//   // Existing code...
// }
