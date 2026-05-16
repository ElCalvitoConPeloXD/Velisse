import 'package:flutter/material.dart';

class DatesContent extends StatelessWidget {
  const DatesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fechas'),
      ),
      body: Center(
        child: Text('Aquí va el contenido de fechas'),
      ),
    );
  }
}