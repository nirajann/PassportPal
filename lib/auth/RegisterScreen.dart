import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passportpal/responsive/responsivelayoutscreen.dart';
import 'package:passportpal/utlis/colors.dart';
import 'package:passportpal/utlis/utlis.dart';
import 'package:passportpal/widgets/TextField.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobileScreenLayout.dart';
import '../responsive/webScreenLayout.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController =
      TextEditingController(text: 'Nirajan Gautam');

  final TextEditingController usernameController =
      TextEditingController(text: 'Nirajan');

  final TextEditingController emailController =
      TextEditingController(text: 'Nirajan@gmail.com');

  final TextEditingController phoneController =
      TextEditingController(text: '982352125');

  final TextEditingController passwordController =
      TextEditingController(text: 'Nirajan123');

  Uint8List? _image;

  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signupuser() async {
    setState(() {
      _isLoading = true;
    });

    String fullName = fullNameController.text.trim();
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text;

    if (_image == null) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar("Please select an image.", context);
      return;
    }
    if (fullName.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar("Please fill in all the fields.", context);
      return;
    }

    if (!EmailValidator.validate(email)) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar("Please enter a valid email address.", context);
      return;
    }

    if (password.length < 8) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar("Password should be at least 8 characters long.", context);
      return;
    }

    if (phone.length < 10) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar("Phone number should be at least 10 digits long.", context);
      return;
    }

    String res = await AuthMethods().signUpUser(
        fullname: fullNameController.text,
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text,
        phoneno: phoneController.text,
        file: _image!,
        bio: 'Bio');

    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0), // Rounded top left corner
                      topRight:
                          Radius.circular(20.0), // Rounded top right corner
                      bottomLeft:
                          Radius.circular(60), // No rounding at the bottom left
                      bottomRight: Radius.circular(
                          60), // No rounding at the bottom right
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white, // Set the text color to black
                        fontWeight: FontWeight.bold, // Set the text to bold
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 155, 0, 0),
                    child: Container(
                      child: _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://www.pngkey.com/png/detail/115-1150152_default-profile-picture-avatar-png-green.png'),
                            ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 120,
                    child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon:
                            const Icon(Icons.add_a_photo, color: Colors.black)))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFieldInput(
                hintText: "Enter Your Full Name",
                textInputType: TextInputType.text,
                textEditingController: fullNameController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFieldInput(
                hintText: "Enter Your Username",
                textInputType: TextInputType.text,
                textEditingController: usernameController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFieldInput(
                hintText: "Enter Your Email",
                textInputType: TextInputType.text,
                textEditingController: emailController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFieldInput(
                hintText: "Enter Your Phone Number",
                textInputType: TextInputType.text,
                textEditingController: phoneController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFieldInput(
                hintText: "Enter Your password",
                textInputType: TextInputType.visiblePassword,
                textEditingController: passwordController,
                isPass: true,
              ),
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: signupuser,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 110, right: 110, top: 10),
                padding: const EdgeInsets.only(left: 50, right: 50),
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [primaryColor, primaryColor],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)),
                  ],
                ),
                child: const Text(
                  "REGISTER",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
