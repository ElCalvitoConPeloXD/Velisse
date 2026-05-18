/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
library;


/// ===============================================================
/// MATERIAL DESIGN
/// ===============================================================

/// Flutter Material
///
/// Permite usar:
/// - Scaffold
/// - TextField
/// - ElevatedButton
/// - Navigator
/// - Column
/// - Text
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
/// IMPORTAR REGISTRO PROFESIONALES
/// ===============================================================

/// Pantalla para crear cuenta profesional
///
/// Ejemplos:
/// - barberías
/// - nail studios
/// - spas
/// - peluquerías
import 'package:velisse/modules/auth/views/createPro_view.dart';


/// ===============================================================
/// IMPORTAR LOGIN CLIENTES
/// ===============================================================

/// Login normal usuarios/clientes
import 'package:velisse/modules/auth/views/login_view.dart';


/// ===============================================================
/// IMPORTAR FONDO PERSONALIZADO
/// ===============================================================

/// Widget reutilizable fondo degradado
///
/// Ruta:
/// lib/widgets/fondo.dart
import '../../../widgets/fondo.dart';



/// ===============================================================
/// LOGIN PROFESIONALES
/// ===============================================================

/// Pantalla para:
/// - login negocios
/// - acceso profesionales
/// - onboarding negocios
///
/// Esta pantalla está diseñada para:
/// - barberías
/// - peluquerías
/// - spas
/// - estudios de uñas
class LogginProView extends StatelessWidget {

  /// Constructor
  const LogginProView({super.key});



  /// =============================================================
  /// BUILD
  /// =============================================================

  @override
  Widget build(BuildContext context) {

    /// ===========================================================
    /// SCAFFOLD
    /// ===========================================================

    /// Scaffold:
    /// crea estructura Material Design
    ///
    /// IMPORTANTE:
    /// esto arregla el error:
    ///
    /// "No Material widget found"
    ///
    /// porque TextField necesita un ancestro Material
    return Scaffold(

      /// Hace transparente el Scaffold
      ///
      /// para dejar visible el gradient background
      backgroundColor: Colors.transparent,



      /// =========================================================
      /// BODY
      /// =========================================================

      body: GradientBackground(

        /// =======================================================
        /// SAFE AREA
        /// =======================================================

        /// Evita notch
        /// y zonas inseguras del celular
        child: SafeArea(

          /// =====================================================
          /// SINGLE CHILD SCROLL VIEW
          /// =====================================================

          /// Permite scroll vertical
          ///
          /// útil cuando aparece teclado
          child: SingleChildScrollView(

            /// Padding dinámico
            ///
            /// viewInsets.bottom:
            /// evita que teclado tape inputs
            padding: EdgeInsets.only(

              left: 24,
              right: 24,

              bottom:
                  MediaQuery.of(context)
                      .viewInsets
                      .bottom,
            ),



            /// ===================================================
            /// CONSTRAINED BOX
            /// ===================================================

            /// Fuerza altura mínima
            child: ConstrainedBox(

              constraints: BoxConstraints(

                minHeight:
                    MediaQuery.of(context)
                        .size
                        .height,
              ),



              /// =================================================
              /// INTRINSIC HEIGHT
              /// =================================================

              /// Ajusta altura automáticamente
              child: IntrinsicHeight(



                /// ===============================================
                /// COLUMN PRINCIPAL
                /// ===============================================

                child: Column(

                  /// Centrado horizontal
                  crossAxisAlignment:
                      CrossAxisAlignment.center,

                  children: [



                    /// ===========================================
                    /// ESPACIO SUPERIOR
                    /// ===========================================

                    const SizedBox(height: 10),



                    /// ===========================================
                    /// BOTÓN ATRÁS
                    /// ===========================================

                    Align(

                      /// Alinear izquierda
                      alignment: Alignment.centerLeft,

                      child: IconButton(

                        /// Acción botón
                        onPressed: () {

                          /// Navega Home
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



                    /// ===========================================
                    /// ESPACIO
                    /// ===========================================

                    const SizedBox(height: 40),



                    /// ===========================================
                    /// TÍTULO
                    /// ===========================================

                    const Text(

                      'Velisse para profesionales',

                      /// Centrar texto
                      textAlign: TextAlign.center,

                      style: TextStyle(

                        /// Tamaño título
                        fontSize: 38,

                        /// Negrilla
                        fontWeight: FontWeight.bold,

                        /// Color
                        color: Colors.black,
                      ),
                    ),



                    /// ===========================================
                    /// ESPACIO
                    /// ===========================================

                    const SizedBox(height: 20),



                    /// ===========================================
                    /// SUBTÍTULO
                    /// ===========================================

                    const Text(

                      'Crea una cuenta o inicia sesión '
                      'para gestionar tu negocio.',

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontSize: 15,

                        color: Colors.black54,

                        /// Altura líneas
                        height: 1.5,
                      ),
                    ),



                    /// ===========================================
                    /// ESPACIO
                    /// ===========================================

                    const SizedBox(height: 30),



                    /// ===========================================
                    /// INPUT EMAIL
                    /// ===========================================

                    TextField(

                      decoration: InputDecoration(

                        /// Placeholder
                        hintText:
                            'correoelectronico@dominio.com',

                        /// Activar fondo
                        filled: true,

                        /// Fondo blanco
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



                    /// ===========================================
                    /// ESPACIO
                    /// ===========================================

                    const SizedBox(height: 16),



                    /// ===========================================
                    /// BOTÓN CONTINUAR
                    /// ===========================================

                    SizedBox(

                      /// Ancho completo
                      width: double.infinity,

                      /// Alto botón
                      height: 52,

                      child: ElevatedButton(

                        /// Acción botón
                        onPressed: () {

                          /// Navega registro profesional
                          Navigator.pushReplacement(

                            context,

                            MaterialPageRoute(

                              builder: (context) =>

                                  const RegisterViewPro(),
                            ),
                          );
                        },



                        /// Estilos botón
                        style:
                            ElevatedButton.styleFrom(

                          /// Fondo negro
                          backgroundColor:
                              Colors.black,

                          /// Bordes redondos
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



                    /// ===========================================
                    /// ESPACIO
                    /// ===========================================

                    const SizedBox(height: 30),



                    /// ===========================================
                    /// DIVIDER CON "O"
                    /// ===========================================

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



                    /// ===========================================
                    /// ESPACIO
                    /// ===========================================

                    const SizedBox(height: 25),



                    /// ===========================================
                    /// TEXTO TÉRMINOS
                    /// ===========================================

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
                                'Al hacer clic en continuar, '
                                'aceptas nuestros ',
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



                    /// ===========================================
                    /// ESPACIO
                    /// ===========================================

                    const SizedBox(height: 50),



                    /// ===========================================
                    /// TEXTO CLIENTES
                    /// ===========================================

                    const Text(

                      '¿Eres cliente y quieres reservar una cita?',

                      style: TextStyle(

                        fontSize: 15,

                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),



                    /// ===========================================
                    /// ESPACIO
                    /// ===========================================

                    const SizedBox(height: 8),



                    /// ===========================================
                    /// IR A LOGIN CLIENTES
                    /// ===========================================

                    GestureDetector(

                      onTap: () {

                        /// Navega login clientes
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



                    /// ===========================================
                    /// ESPACIO FINAL
                    /// ===========================================

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}