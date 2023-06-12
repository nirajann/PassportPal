import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  final String? email;
  final String? photoUrl;

  const EditProfileScreen({
    Key? key,
    this.username,
    this.email,
    this.photoUrl,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.username ?? '';
    _emailController.text = widget.email ?? '';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    final username = _usernameController.text;
    final email = _emailController.text;

    if (user != null) {
      try {
        // Update profile data in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'username': username,
          'email': email,
        });

        // Update profile photo if an image was selected
        if (_image != null) {
          final photoUrl = await _uploadImageToStorage(user.uid);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'photourl': photoUrl,
          });
        }

        // Profile update successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        // Error occurred during profile update
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  Future<String> _uploadImageToStorage(String userId) async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profilepics')
          .child('$userId.png');

      final UploadTask uploadTask = storageRef.putFile(_image!);
      final TaskSnapshot uploadSnapshot = await uploadTask;

      final String downloadUrl = await uploadSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Failed to upload image: $error');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 155, 0, 0),
              child: Container(
                child: _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: FileImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage: widget.photoUrl != null
                            ? NetworkImage(widget.photoUrl!)
                            : const NetworkImage(
                                'https://www.pngkey.com/png/detail/115-1150152_default-profile-picture-avatar-png-green.png',
                              ),
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 120,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Choose an option'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              GestureDetector(
                                child: const Text('Gallery'),
                                onTap: () {
                                  selectImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                              ),
                              const Padding(padding: EdgeInsets.all(8.0)),
                              GestureDetector(
                                child: const Text('Camera'),
                                onTap: () {
                                  selectImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add_a_photo, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: updateProfile,
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
