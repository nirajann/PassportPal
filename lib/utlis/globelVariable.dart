import 'package:flutter/material.dart';
import 'package:passportpal/Screens/Aboutus.dart';
import 'package:passportpal/Screens/UniScreen.dart';
import 'package:passportpal/Screens/feedScreen.dart';
import 'package:passportpal/Screens/profileScreen.dart';

import '../Screens/HomeScreen.dart';

const webScreenSize = 600;

List<Widget> homescreenItems = [
  const AboutUsPage(),
  const FeedScreen(),
  const HomeScreen(),
  const UniScreen(),
  const ProfileScreen(),
];
