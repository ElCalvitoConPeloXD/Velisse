import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          '¡Has entrado a la aplicación!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}