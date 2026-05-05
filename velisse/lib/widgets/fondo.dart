import 'package:flutter/material.dart';

class AppBackgroundfirst extends StatelessWidget {
  final Widget child;
  const AppBackgroundfirst({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          //gradient: LinearGradient(
            //colors: [Colors.purple.shade100,Colors.white,Colors.purple.shade100],
            //begin: Alignment.topLeft,
            //end: Alignment.bottomRight,
          //),
          // O una imagen:
          image: DecorationImage(
             image: AssetImage('assets/images/firstbg.png'),
             fit: BoxFit.cover,
           ),
        ),
        child: child,
      ),
    );
  }
}
class AppBackgroundGeneral extends StatelessWidget {
  final Widget child;
  const AppBackgroundGeneral({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          //gradient: LinearGradient(
            //colors: [Colors.purple.shade100,Colors.white,Colors.purple.shade100],
            //begin: Alignment.topLeft,
            //end: Alignment.bottomRight,
          //),
          // O una imagen:
          image: DecorationImage(
             image: AssetImage('assets/images/generalbg.png'),
             fit: BoxFit.cover,
           ),
        ),
        child: child,
      ),
    );
  }
}