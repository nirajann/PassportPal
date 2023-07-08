import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:passportpal/utlis/colors.dart';
import 'package:passportpal/utlis/globelVariable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 2;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTap(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: homescreenItems,
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(
        currentIndex: _page,
        onTap: navigationTap,
      ),
    );
  }
}

class CurvedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CurvedBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: CustomPaint(
        painter: CurvedPainter(),
        child: SizedBox(
          height: 55,
          child: CupertinoTabBar(
            backgroundColor: const Color.fromARGB(255, 241, 238, 238),
            items: [
              buildNavItem(Icons.info_outline, 0),
              buildNavItem(Icons.people, 1),
              buildNavItem(Icons.home_outlined, 2),
              buildNavItem(Icons.school_outlined, 3),
              buildNavItem(Icons.person_2_outlined, 4),
            ],
            onTap: onTap,
            currentIndex: currentIndex,
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem buildNavItem(IconData icon, int index) {
    final isSelected = index == currentIndex;

    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? navyBlue : Colors.transparent,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : navyBlue,
            size: 30,
          ),
        ),
      ),
      label: '',
      backgroundColor: navyBlue,
    );
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, 20)
      ..quadraticBezierTo(
        size.width / 2,
        0,
        size.width,
        20,
      )
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
