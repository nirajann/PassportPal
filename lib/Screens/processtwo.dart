// class ProcessScreen extends StatefulWidget {
//   final String image;
//   final String title;
//   final String documentId; // New property to store the document ID

//   const ProcessScreen({
//     Key? key,
//     required this.image,
//     required this.title,
//     required this.documentId, // Pass the document ID to the screen
//   }) : super(key: key);

//   @override
//   _ProcessScreenState createState() => _ProcessScreenState();
// }

// class _ProcessScreenState extends State<ProcessScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // Fetch data from the subcollection based on the document ID
//     final subcollectionRef = FirebaseFirestore.instance
//         .collection('Countries')
//         .doc(widget.documentId)
//         .collection('process');

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: navyBlue,
//         title: const Text('Process Screen'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 15),
//               child: Text(
//                 widget.title,
//                 style: const TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   color: navyBlue,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: navyBlue,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Book your Interview",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       "description",
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Image.network(
//                       widget.image,
//                       width: 250,
//                       height: 250,
//                       fit: BoxFit.fill,
//                     ),
//                     const SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 40,
//                         vertical: 15,
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Perform some action when the button is pressed
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.all(8),
//                           backgroundColor: navyBlue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           textStyle: const TextStyle(fontSize: 20),
//                         ),
//                         child: const Text('Book Now'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 15),
//               child: IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.arrow_forward_rounded,
//                   color: navyBlue,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
