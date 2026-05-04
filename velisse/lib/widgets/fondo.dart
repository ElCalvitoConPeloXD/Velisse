import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100,Colors.white,Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // O una imagen:
          // image: DecorationImage(
          //   image: AssetImage('assets/bg.png'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: child,
      ),
    );
  }
}