/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
library;

/// Flutter Material Design
///
/// Permite usar:
/// - Scaffold
/// - Text
/// - Column
/// - Navigator
/// - ElevatedButton
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
/// IMPORTAR REGISTRO PROFESIONAL
/// ===============================================================

/// Pantalla para registrar profesionales
///
/// Ejemplos:
/// - barberías
/// - nail studios
/// - spas
/// - peluquerías
import 'package:velisse/modules/auth/views/createPro_view.dart';


/// ===============================================================
/// IMPORTAR FONDO
/// ===============================================================

/// Widget reutilizable del fondo degradado
///
/// Ubicación:
/// lib/widgets/fondo.dart
import '../../../widgets/fondo.dart';


/// ===============================================================
/// IMPORTAR LOGIN CLIENTES
/// ===============================================================

/// Pantalla login normal para clientes
import 'package:velisse/modules/auth/views/login_view.dart';



/// ===============================================================
/// LOGIN PROFESIONALES
/// ===============================================================

/// Pantalla para:
/// - login profesional
/// - acceso negocios
/// - registro negocios
///
/// Esta pantalla está pensada para:
/// - barberías
/// - salones
/// - spas
/// - manicuristas
class LogginProView extends StatelessWidget {

  /// Constructor
  const LogginProView({super.key});



  /// =============================================================
  /// BUILD
  /// =============================================================

  /// build():
  /// construye toda la interfaz visual
  @override
  Widget build(BuildContext context) {

    /// GradientBackground:
    /// fondo degradado reutilizable
    return GradientBackground(

      /// =========================================================
      /// SAFE AREA
      /// =========================================================

      child: SafeArea(

        /// =======================================================
        /// SCROLL VIEW
        /// =======================================================

        child: SingleChildScrollView(

          /// Padding dinámico
          ///
          /// viewInsets.bottom:
          /// evita que el teclado tape contenido
          padding: EdgeInsets.only(

            left: 24,
            right: 24,

            bottom:
                MediaQuery.of(context)
                    .viewInsets
                    .bottom,
          ),

          /// =====================================================
          /// CONSTRAINED BOX
          /// =====================================================

          child: ConstrainedBox(

            /// Altura mínima pantalla
            constraints: BoxConstraints(

              minHeight:
                  MediaQuery.of(context)
                      .size
                      .height,
            ),

            /// ===================================================
            /// INTRINSIC HEIGHT
            /// ===================================================

            child: IntrinsicHeight(

              /// =================================================
              /// COLUMN PRINCIPAL
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

                                /// Home principal
                                const HomeView(),
                          ),
                        );
                      },

                      /// Icono flecha atrás
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

                    'Velisse para profesionales',

                    /// Centrar texto
                    textAlign: TextAlign.center,

                    style: TextStyle(

                      /// Tamaño
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

                    'Crea una cuenta o inicia sesión para gestionar tu negocio.',

                    textAlign: TextAlign.center,

                    style: TextStyle(

                      fontSize: 15,

                      color: Colors.black54,

                      /// Espaciado vertical
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

                      /// Placeholder
                      hintText:
                          'correoelectronico@dominio.com',

                      /// Activar fondo
                      filled: true,

                      /// Color fondo
                      fillColor: Colors.white,

                      /// Padding interno
                      contentPadding:
                          const EdgeInsets.symmetric(

                        horizontal: 16,
                        vertical: 14,
                      ),

                      /// Borde
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

                    /// Ancho completo
                    width: double.infinity,

                    /// Altura botón
                    height: 52,

                    child: ElevatedButton(

                      /// Acción botón
                      onPressed: () {

                        /// Navegar registro profesional
                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder: (context) =>

                                /// Registro profesional
                                const RegisterViewPro(),
                          ),
                        );
                      },

                      /// Estilos botón
                      style:
                          ElevatedButton.styleFrom(

                        backgroundColor:
                            Colors.black,

                        shape:
                            RoundedRectangleBorder(

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

                      /// Texto central
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
                  /// TÉRMINOS
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
                  /// TEXTO CLIENTES
                  /// =============================================

                  const Text(

                    '¿Eres cliente y quieres reservar una cita?',

                    style: TextStyle(

                      fontSize: 15,

                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),


                  /// =============================================
                  /// ESPACIO
                  /// =============================================

                  const SizedBox(height: 8),


                  /// =============================================
                  /// CAMBIAR A LOGIN CLIENTES
                  /// =============================================

                  GestureDetector(

                    onTap: () {

                      /// Navegar login clientes
                      Navigator.pushReplacement(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>

                              const LogginView(),
                        ),
                      );
                    },

                    child: const Text(

                      'Ir a Velisse para clientes',

                      style: TextStyle(

                        color: Colors.purple,

                        fontSize: 15,

                        fontWeight:
                            FontWeight.bold,
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