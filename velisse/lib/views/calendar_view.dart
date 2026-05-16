import 'package:flutter/material.dart';

class CalendarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario'),
      ),
      body: Center(
        child: Text('Aquí va el contenido del calendario'),
      ),
    );
  }
}