import 'package:flutter/material.dart';
import 'views/first_view.dart';  // 👈 Importar primera vista

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Quitar banner de debug
      home: FirstView(),  // 👈 Primera vista al iniciar
    );
  }
}