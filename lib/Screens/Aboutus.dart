import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passportpal/utlis/colors.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool done = false;
  String description =
      "Welcome to our Visa and University Information app! We understand that planning your education abroad can be a complex and overwhelming process. That's why we've developed this app to provide you with all the essential information you need to make informed decisions.";

  void changeDescription() {
    setState(() {
      done = true;
      description =
          "Our app is designed to be your comprehensive guide to visas and universities around the world. Whether you're a student seeking admission to a foreign university or a traveler in need of visa information, we've got you covered.";
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              color: primaryColor,
                              height: screenWidth * 0.5,
                              width: double.infinity,
                            ),
                            Container(
                              child: SvgPicture.asset(
                                'assets/registerHeader.svg',
                                color: primaryColor,
                                width: screenWidth * 1,
                                height: screenHeight * 0.5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: SizedBox(
                                  width: screenWidth * 1,
                                  height: screenHeight * 0.8,
                                  child: Image.asset('assets/png/pplogo.png')),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 460, 0, 0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      child: Text(
                                        "PassportPal",
                                        style: TextStyle(
                                          fontSize: 35,
                                          color:
                                              primaryColor, // Set the text color to black
                                          fontWeight: FontWeight
                                              .bold, // Set the text to bold
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 300,
                                      width: 400,
                                      child: Text(
                                        description,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 11, 11,
                                              11), // Set the text color to black
                                          fontWeight: FontWeight
                                              .bold, // Set the text to bold
                                        ),
                                      ),
                                    ),
                                    done
                                        ? Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 151, 150, 149),
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                              ),
                                              child: IconButton(
                                                  onPressed: () {
                                                    // Call the changeDescription function of the DescriptionWidget
                                                    final descriptionWidget = context
                                                        .findAncestorStateOfType<
                                                            _AboutUsPageState>();
                                                    descriptionWidget
                                                        ?.changeDescription();
                                                  },
                                                  icon: const Icon(
                                                    Icons.check,
                                                    color: primaryColor,
                                                  )),
                                            ),
                                          )
                                        : Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 151, 150, 149),
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                              ),
                                              child: IconButton(
                                                  onPressed: () {
                                                    // Call the changeDescription function of the DescriptionWidget
                                                    final descriptionWidget = context
                                                        .findAncestorStateOfType<
                                                            _AboutUsPageState>();
                                                    descriptionWidget
                                                        ?.changeDescription();
                                                  },
                                                  icon: const Icon(
                                                    Icons.arrow_forward,
                                                    color: primaryColor,
                                                  )),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
            ),
          ));
        },
      ),
    );
  }
}
