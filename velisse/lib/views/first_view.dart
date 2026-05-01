import 'package:flutter/material.dart';
import 'home_view.dart'; 

class FirstView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Usamos Stack para que el botón ocupe TODA la pantalla por detrás
      body: Stack(
        children: [
          // 1. EL BOTÓN QUE OCUPA TODO
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeView()),
              );
            },
            child: Container(
              color: Colors.transparent, // Importante para que detecte el tap en lo vacío
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          
          // 2. EL CONTENIDO VISUAL (Logo y texto)
          // Ignora los toques para que pasen al GestureDetector de abajo
          IgnorePointer(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Velisse-Logo.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20), // Espacio entre logo y texto
                  const Text(
                    'Toca para entrar',
                    style: TextStyle(
                      color: Colors.black54, // Cambiado a gris para que se vea en blanco
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
