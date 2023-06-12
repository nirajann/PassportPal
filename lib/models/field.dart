import 'package:cloud_firestore/cloud_firestore.dart';

class RectangleData {
  final String Course;
  final String image;

  const RectangleData({
    required this.Course,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        'Course': Course,
        'image': image,
      };

  static RectangleData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return RectangleData(
      Course: snapshot['Course'],
      image: snapshot['image'],
    );
  }
}
