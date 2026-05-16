import 'package:flutter/material.dart';
import 'views/first_view.dart';  // 👈 Importar primera vista
import 'views/configuracion_negocio_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      debugShowCheckedModeBanner: false,  // Quitar banner de debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: FirstView(),  // 👈 Primera vista al iniciar
      home: const ConfiguracionNegocioView(),
    );
  }
}