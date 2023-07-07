import 'package:flutter/material.dart';
import 'package:passportpal/resources/auth_methods.dart';
import 'package:passportpal/responsive/mobileScreenLayout.dart';
import 'package:passportpal/responsive/responsivelayoutscreen.dart';
import 'package:passportpal/responsive/webScreenLayout.dart';
import 'package:passportpal/utlis/colors.dart';
import 'package:passportpal/utlis/utlis.dart';
import 'package:passportpal/widgets/TextField.dart';

import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController(text: 'Nirajan@gmail.com');

  final TextEditingController passwordController =
      TextEditingController(text: 'Nirajan123');
  bool isloading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isloading = true;
    });
    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwordController.text);
    setState(() {
      isloading = false;
    });
    if (res == 'success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ));
    } else {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
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
                              topLeft: Radius.circular(
                                  20.0), // Rounded top left corner
                              topRight: Radius.circular(
                                  20.0), // Rounded top right corner
                              bottomLeft: Radius.circular(
                                  60), // No rounding at the bottom left
                              bottomRight: Radius.circular(
                                  60), // No rounding at the bottom right
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Image.asset('assets/png/loginIcon.png'),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 335, 20, 0),
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 370, 20, 0),
                          child: Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          20, 0, constraints.maxWidth >= 768 ? 320 : 70, 0),
                      child: TextFieldInput(
                        hintText: "Email",
                        textInputType: TextInputType.text,
                        textEditingController: emailController,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          20, 0, constraints.maxWidth >= 768 ? 320 : 70, 0),
                      child: TextFieldInput(
                        hintText: "Password",
                        textInputType: TextInputType.text,
                        textEditingController: passwordController,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            loginUser();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                left: 20,
                                right: constraints.maxWidth >= 768 ? 40 : 0,
                                top: 10),
                            padding: EdgeInsets.only(
                                left: constraints.maxWidth >= 768 ? 50 : 20,
                                right: constraints.maxWidth >= 768 ? 50 : 20),
                            height: 54,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  primaryColor,
                                  primaryColor,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200],
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color(0xffEEEEEE),
                                ),
                              ],
                            ),
                            child: isloading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      backgroundColor: Colors.black,
                                    ),
                                  )
                                : const Text(
                                    'Sign in',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle "Forgot Password" functionality here
                            // TODO: Implement the logic for password recovery or password reset
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80, 50, 20, 0),
                      child: Row(
                        children: [
                          const Text(
                            'Don\'t Have an Account ?',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(
                                255,
                                23,
                                23,
                                23,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 15,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
