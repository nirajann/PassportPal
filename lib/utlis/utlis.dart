import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passportpal/utlis/colors.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagepicker = ImagePicker();

  XFile? file = await imagepicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }

  print("no image selecetd");
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: primaryColor,
      content: Center(
        child: Text(
          content,
          style: const TextStyle(
              color: Colors.white, backgroundColor: primaryColor),
        ),
      )));
}
