import 'package:flutter/material.dart';
import 'home_view.dart';  // 👈 La vista a donde irá después

class FirstView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Fondo blanco
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🖼️ MOSTRAR EL LOGO
            Image.asset(
              'assets/images/Velisse-Logo.png',  // 👈 Ruta de tu imagen
              width: 200,                 // Ancho del logo
              height: 200,                // Alto del logo
            ),
            
            SizedBox(height: 50),  // Espacio entre logo y botón
            
            // 🔘 BOTÓN PARA ENTRAR
            GestureDetector(
              onTap: () {
                // Navegar a la siguiente pantalla
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}