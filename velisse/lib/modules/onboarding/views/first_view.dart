/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
library;

/// Material Design Flutter
///
/// Gracias a esto podemos usar:
/// - Scaffold
/// - Stack
/// - Center
/// - Text
/// - Navigator
/// - etc
import 'package:flutter/material.dart';


/// ===============================================================
/// IMPORTAR HOME VIEW
/// ===============================================================

/// Pantalla principal Home
///
/// El usuario será enviado aquí
/// cuando toque la pantalla
import 'package:velisse/modules/home/views/home_view.dart';


/// ===============================================================
/// IMPORTAR FONDO
/// ===============================================================

/// Widget reutilizable GradientBackground
///
/// Contiene el fondo degradado app
import '../../../widgets/fondo.dart';



/// ===============================================================
/// FIRST VIEW
/// ===============================================================

/// StatelessWidget:
///
/// Se usa porque esta pantalla
/// NO cambia dinámicamente
class FirstView extends StatelessWidget {

  /// Constructor
  const FirstView({super.key});



  /// =============================================================
  /// BUILD
  /// =============================================================

  /// build():
  /// construye toda la interfaz visual
  @override
  Widget build(BuildContext context) {

    /// Scaffold:
    /// estructura principal visual
    return Scaffold(

      /// =========================================================
      /// BODY
      /// =========================================================

      body: GradientBackground(

        /// =======================================================
        /// STACK
        /// =======================================================

        /// Stack:
        /// permite superponer widgets
        child: Stack(

          children: [

            /// ===================================================
            /// CAPA TOQUE PANTALLA
            /// ===================================================

            /// GestureDetector:
            /// detecta taps del usuario
            GestureDetector(

              /// Acción al tocar pantalla
              onTap: () {

                /// Navegar hacia HomeView
                Navigator.pushReplacement(

                  context,

                  MaterialPageRoute(

                    builder: (context) => HomeView(),
                  ),
                );
              },

              /// =================================================
              /// CONTAINER TRANSPARENTE
              /// =================================================

              /// Este container ocupa
              /// toda la pantalla
              ///
              /// para detectar el tap
              child: Container(

                /// Transparente
                color: Colors.transparent,

                /// Ancho total
                width: double.infinity,

                /// Alto total
                height: double.infinity,
              ),
            ),


            /// ===================================================
            /// CONTENIDO VISUAL
            /// ===================================================

            /// IgnorePointer:
            ///
            /// evita bloquear los taps
            /// del GestureDetector
            IgnorePointer(

              child: Center(

                /// =================================================
                /// COLUMN
                /// =================================================

                child: Column(

                  /// Centrar verticalmente
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    /// =============================================
                    /// LOGO
                    /// =============================================

                    Image.asset(

                      /// Ruta imagen assets
                      'assets/images/Velisse-Logo.png',

                      /// Tamaño ancho
                      width: 200,

                      /// Tamaño alto
                      height: 200,
                    ),


                    /// =============================================
                    /// ESPACIO
                    /// =============================================

                    const SizedBox(height: 20),


                    /// =============================================
                    /// TEXTO
                    /// =============================================

                    const Text(

                      'Toca para entrar',

                      style: TextStyle(

                        /// Color gris
                        color: Colors.black54,

                        /// Tamaño fuente
                        fontSize: 18,

                        /// Negrilla
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}