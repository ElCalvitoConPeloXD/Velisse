/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
library;

/// Importa Material Design
///
/// Gracias a esto podemos usar:
/// - Scaffold
/// - Text
/// - Column
/// - TextField
/// - ElevatedButton
/// - Navigator
/// - etc
import 'package:flutter/material.dart';


/// ===============================================================
/// IMPORTAR HOME
/// ===============================================================

/// Pantalla principal Home
///
/// Se usa cuando:
/// - el usuario presiona atrás
import 'package:velisse/modules/home/views/home_view.dart';


/// ===============================================================
/// IMPORTAR REGISTRO USUARIO
/// ===============================================================

/// Pantalla para registrar usuarios/clientes
import 'package:velisse/modules/auth/views/createUser_view.dart';


/// ===============================================================
/// IMPORTAR WIDGET FONDO
/// ===============================================================

/// Widget reutilizable del fondo degradado
///
/// Está en:
/// lib/widgets/fondo.dart
import '../../../widgets/fondo.dart';


/// ===============================================================
/// IMPORTAR LOGIN PROFESIONAL
/// ===============================================================

/// Pantalla login para profesionales
import 'package:velisse/modules/auth/views/loginPro_view.dart';


/// ===============================================================
/// LOGIN VIEW
/// ===============================================================

/// StatelessWidget:
///
/// esta pantalla NO necesita setState()
///
/// solo renderiza UI
class LogginView extends StatelessWidget {

  /// Constructor
  const LogginView({super.key});


  /// =============================================================
  /// BUILD
  /// =============================================================

  /// build():
  /// construye toda la interfaz visual
  @override
  Widget build(BuildContext context) {

    /// GradientBackground:
    /// widget personalizado con fondo degradado
    return GradientBackground(

      /// =========================================================
      /// CHILD
      /// =========================================================

      child: SafeArea(

        /// SafeArea:
        /// evita notch/status bar
        child: SingleChildScrollView(

          /// =====================================================
          /// PADDING
          /// =====================================================

          /// Espaciado horizontal
          ///
          /// viewInsets.bottom:
          /// evita que teclado tape contenido
          padding: EdgeInsets.only(

            left: 24,
            right: 24,

            bottom:
                MediaQuery.of(context).viewInsets.bottom,
          ),

          /// =====================================================
          /// CONSTRAINED BOX
          /// =====================================================

          child: ConstrainedBox(

            /// Altura mínima pantalla
            constraints: BoxConstraints(

              minHeight:
                  MediaQuery.of(context).size.height,
            ),

            /// ===================================================
            /// INTRINSIC HEIGHT
            /// ===================================================

            child: IntrinsicHeight(

              /// =================================================
              /// COLUMN
              /// =================================================

              child: Column(

                /// Centrado horizontal
                crossAxisAlignment:
                    CrossAxisAlignment.center,

                children: [

                  /// =============================================
                  /// ESPACIO SUPERIOR
                  /// =============================================

                  const SizedBox(height: 10),


                  /// =============================================
                  /// BOTÓN ATRÁS
                  /// =============================================

                  Align(

                    /// Alinear izquierda
                    alignment: Alignment.centerLeft,

                    child: IconButton(

                      /// Acción botón
                      onPressed: () {

                        /// Navegar Home
                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder: (context) =>
                                HomeView(),
                          ),
                        );
                      },

                      /// Icono
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),


                  /// =============================================
                  /// ESPACIO
                  /// =============================================

                  const SizedBox(height: 40),


                  /// =============================================
                  /// TÍTULO
                  /// =============================================

                  const Text(

                    '¡Bienvenido de\nnuevo!',

                    /// Centrar texto
                    textAlign: TextAlign.center,

                    style: TextStyle(

                      /// Tamaño fuente
                      fontSize: 38,

                      /// Negrilla
                      fontWeight: FontWeight.bold,

                      /// Color
                      color: Colors.black,
                    ),
                  ),


                  /// =============================================
                  /// ESPACIO
                  /// =============================================

                  const SizedBox(height: 20),


                  /// =============================================
                  /// SUBTÍTULO
                  /// =============================================

                  const Text(

                    'Crea una cuenta o inicia sesión para reservar y\nadministrar tus citas',

                    textAlign: TextAlign.center,

                    style: TextStyle(

                      fontSize: 15,

                      color: Colors.black54,

                      /// Espaciado vertical texto
                      height: 1.5,
                    ),
                  ),


                  /// =============================================
                  /// ESPACIO
                  /// =============================================

                  const SizedBox(height: 30),


                  /// =============================================
                  /// INPUT EMAIL
                  /// =============================================

                  TextField(

                    decoration: InputDecoration(

                      /// Texto placeholder
                      hintText:
                          'correoelectrónico@dominio.com',

                      /// Fondo activo
                      filled: true,

                      /// Color fondo
                      fillColor: Colors.white,

                      /// Padding interno
                      contentPadding:
                          const EdgeInsets.symmetric(

                        horizontal: 16,
                        vertical: 14,
                      ),

                      /// Borde principal
                      border: OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(10),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),


                  /// =============================================
                  /// ESPACIO
                  /// =============================================

                  const SizedBox(height: 16),


                  /// =============================================
                  /// BOTÓN CONTINUAR
                  /// =============================================

                  SizedBox(

                    width: double.infinity,

                    height: 52,

                    child: ElevatedButton(

                      /// Acción botón
                      onPressed: () {

                        /// Navegar registro usuario
                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder: (context) =>

                                /// IMPORTANTE:
                                /// usa el nombre REAL
                                /// de tu clase
                                RegisterView(),
                          ),
                        );
                      },

                      /// Estilos botón
                      style: ElevatedButton.styleFrom(

                        backgroundColor: Colors.black,

                        shape: RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),

                      /// Texto botón
                      child: const Text(

                        'Continuar',

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),


                  /// =============================================
                  /// ESPACIO
                  /// =============================================

                  const SizedBox(height: 30),


                  /// =============================================
                  /// DIVIDER CON "O"
                  /// =============================================

                  Row(

                    children: [

                      /// Línea izquierda
                      Expanded(

                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),

                      /// Texto centro
                      const Padding(

                        padding:
                            EdgeInsets.symmetric(
                          horizontal: 10,
                        ),

                        child: Text('o'),
                      ),

                      /// Línea derecha
                      Expanded(

                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),


                  /// =============================================
                  /// ESPACIO
                  /// =============================================

                  const SizedBox(height: 25),


                  /// =============================================
                  /// TEXTO TÉRMINOS
                  /// =============================================

                  RichText(

                    textAlign: TextAlign.center,

                    text: const TextSpan(

                      style: TextStyle(

                        color: Colors.black54,

                        fontSize: 12,
                      ),

                      children: [

                        TextSpan(

                          text:
                              'Al hacer clic en continuar, aceptas nuestros ',
                        ),

                        TextSpan(

                          text:
                              'Términos de\nservicio',

                          style: TextStyle(

                            fontWeight:
                                FontWeight.bold,

                            color: Colors.black87,
                          ),
                        ),

                        TextSpan(
                          text: ' y ',
                        ),

                        TextSpan(

                          text:
                              'Política de privacidad',

                          style: TextStyle(

                            fontWeight:
                                FontWeight.bold,

                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),


                  /// =============================================
                  /// ESPACIO
                  /// =============================================

                  const SizedBox(height: 50),


                  /// =============================================
                  /// TEXTO PROFESIONALES
                  /// =============================================

                  const Text(

                    '¿Tienes una cuenta de empresa?',

                    style: TextStyle(

                      fontSize: 15,

                      fontWeight: FontWeight.w500,
                    ),
                  ),


                  /// =============================================
                  /// ESPACIO
                  /// =============================================

                  const SizedBox(height: 8),


                  /// =============================================
                  /// LOGIN PROFESIONAL
                  /// =============================================

                  GestureDetector(

                    onTap: () {

                      /// Navegar login profesional
                      Navigator.pushReplacement(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              const LogginProView(),
                        ),
                      );
                    },

                    child: const Text(

                      'Inicia sesión como profesional',

                      style: TextStyle(

                        color: Colors.purple,

                        fontSize: 15,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),


                  /// =============================================
                  /// ESPACIO FINAL
                  /// =============================================

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}