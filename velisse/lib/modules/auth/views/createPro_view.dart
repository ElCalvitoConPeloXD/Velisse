/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
library;

/// Importa todos los widgets Material Design
///
/// Gracias a esto podemos usar:
/// - Scaffold
/// - Text
/// - Column
/// - Checkbox
/// - ElevatedButton
/// - etc
import 'package:flutter/material.dart';


/// ===============================================================
/// IMPORTAR LOGIN VIEW
/// ===============================================================

/// Importa pantalla login clientes
///
/// Esta pantalla se abrirá:
/// cuando el usuario presione volver
import 'package:velisse/modules/auth/views/login_view.dart';


/// ===============================================================
/// IMPORTAR FONDO PERSONALIZADO
/// ===============================================================

/// Importa GradientBackground
///
/// Este widget crea:
/// - fondo degradado
/// - estilo visual global
import '../../../widgets/fondo.dart';

/// ===============================================================
/// REGISTER VIEW PROFESIONALES
/// ===============================================================

/// StatefulWidget:
///
/// usamos StatefulWidget porque:
/// - los checkboxes cambian estado
/// - usamos setState()
class RegisterViewPro extends StatefulWidget {

  /// Constructor
  const RegisterViewPro({super.key});



  /// =============================================================
  /// CREATE STATE
  /// =============================================================

  @override
  State<RegisterViewPro> createState() =>
      _RegisterViewStatePro();
}



/// ===============================================================
/// ESTADO REGISTER VIEW
/// ===============================================================

class _RegisterViewStatePro
    extends State<RegisterViewPro> {

  /// =============================================================
  /// VARIABLES CHECKBOXES
  /// =============================================================

  /// Checkbox términos y condiciones
  bool acceptTerms = false;

  /// Checkbox marketing
  bool acceptMarketing = false;



  /// =============================================================
  /// BUILD
  /// =============================================================

  @override
  Widget build(BuildContext context) {

    /// GradientBackground:
    /// fondo degradado personalizado
    return GradientBackground(

      child: Scaffold(

        /// Hace transparente Scaffold
        backgroundColor: Colors.transparent,



        /// =======================================================
        /// BODY
        /// =======================================================

        body: SafeArea(

          child: Padding(

            /// Padding horizontal pantalla
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),

            child: SingleChildScrollView(

              /// Permite scroll vertical
              child: Column(

                /// Alinear widgets izquierda
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  /// Espacio superior
                  const SizedBox(height: 10),



                  /// =================================================
                  /// BOTÓN VOLVER
                  /// =================================================

                  IconButton(

                    /// Acción botón
                    onPressed: () {

                      /// Navega al login clientes
                      Navigator.pushReplacement(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              const LogginView(),
                        ),
                      );
                    },

                    /// Icono flecha atrás
                    icon: const Icon(
                      Icons.arrow_back,
                    ),

                    /// Elimina padding interno
                    padding: EdgeInsets.zero,

                    /// Alinear izquierda
                    alignment: Alignment.centerLeft,
                  ),



                  /// Espacio
                  const SizedBox(height: 40),



                  /// =================================================
                  /// TÍTULO
                  /// =================================================

                  const Text(

                    'Crear cuenta',

                    style: TextStyle(

                      /// Tamaño fuente
                      fontSize: 32,

                      /// Negrilla
                      fontWeight: FontWeight.bold,
                    ),
                  ),



                  /// Espacio
                  const SizedBox(height: 10),



                  /// =================================================
                  /// SUBTÍTULO
                  /// =================================================

                  const Text(

                    '¡Ya casi lo logras! '
                    'Crea tu nueva cuenta\n'
                    'completando estos datos.',

                    style: TextStyle(

                      /// Tamaño texto
                      fontSize: 15,

                      /// Color gris
                      color: Colors.black54,

                      /// Altura líneas
                      height: 1.5,
                    ),
                  ),



                  /// Espacio
                  const SizedBox(height: 35),



                  /// =================================================
                  /// NOMBRE
                  /// =================================================

                  const Text(

                    'Nombre',

                    style: TextStyle(

                      /// Semi bold
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  /// Espacio
                  const SizedBox(height: 8),

                  /// Input personalizado
                  _customInput(),



                  /// Espacio
                  const SizedBox(height: 20),



                  /// =================================================
                  /// APELLIDO
                  /// =================================================

                  const Text(

                    'Apellido',

                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  _customInput(),



                  /// Espacio
                  const SizedBox(height: 20),



                  /// =================================================
                  /// CONTRASEÑA
                  /// =================================================

                  const Text(

                    'Contraseña',

                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// obscureText:
                  /// oculta contraseña
                  _customInput(
                    obscureText: true,
                  ),



                  /// Espacio
                  const SizedBox(height: 20),



                  /// =================================================
                  /// NÚMERO CELULAR
                  /// =================================================

                  const Text(

                    'Número de celular',

                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),



                  /// =================================================
                  /// ROW TELÉFONO
                  /// =================================================

                  Row(

                    children: [

                      /// Código país
                      Container(

                        /// Ancho
                        width: 62,

                        /// Alto
                        height: 50,

                        decoration: BoxDecoration(

                          /// Fondo blanco
                          color: Colors.white,

                          /// Bordes redondos
                          borderRadius:
                              BorderRadius.circular(8),

                          /// Borde gris
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),

                        /// Centrar texto
                        alignment: Alignment.center,

                        child: const Text(

                          '+57',

                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),



                      /// Espacio horizontal
                      const SizedBox(width: 10),



                      /// Input ocupa espacio restante
                      Expanded(

                        child: _customInput(),
                      ),
                    ],
                  ),



                  /// Espacio
                  const SizedBox(height: 30),



                  /// =================================================
                  /// CHECKBOX TÉRMINOS
                  /// =================================================

                  Row(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      /// Checkbox
                      Checkbox(

                        /// Valor actual
                        value: acceptTerms,

                        /// Color activo
                        activeColor:
                            Colors.deepPurple,

                        /// Cambio valor
                        onChanged: (value) {

                          /// Actualizar UI
                          setState(() {

                            acceptTerms =
                                value ?? false;
                          });
                        },
                      ),



                      /// Texto flexible
                      Expanded(

                        child: RichText(

                          text: const TextSpan(

                            style: TextStyle(

                              color: Colors.black54,

                              fontSize: 12,
                            ),

                            children: [

                              TextSpan(
                                text: 'Acepto los ',
                              ),

                              TextSpan(

                                text:
                                    'Política de privacidad, ',

                                style: TextStyle(
                                  color: Colors.purple,
                                ),
                              ),

                              TextSpan(

                                text:
                                    'Términos de uso ',

                                style: TextStyle(
                                  color: Colors.purple,
                                ),
                              ),

                              TextSpan(
                                text: 'y ',
                              ),

                              TextSpan(

                                text:
                                    'Términos de servicio',

                                style: TextStyle(
                                  color: Colors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),



                  /// Espacio
                  const SizedBox(height: 10),



                  /// =================================================
                  /// CHECKBOX MARKETING
                  /// =================================================

                  Row(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Checkbox(

                        value: acceptMarketing,

                        activeColor:
                            Colors.deepPurple,

                        onChanged: (value) {

                          setState(() {

                            acceptMarketing =
                                value ?? false;
                          });
                        },
                      ),



                      const Expanded(

                        child: Text(

                          'Acepto recibir '
                          'notificaciones de marketing '
                          'con ofertas y noticias',

                          style: TextStyle(

                            fontSize: 12,

                            color: Colors.black54,

                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),



                  /// Espacio
                  const SizedBox(height: 40),



                  /// =================================================
                  /// BOTÓN CREAR CUENTA
                  /// =================================================

                  SizedBox(

                    /// Ocupa ancho completo
                    width: double.infinity,

                    /// Alto botón
                    height: 52,

                    child: ElevatedButton(

                      /// Acción botón
                      onPressed: () {

                        /// Más adelante:
                        /// registrar profesional Firebase
                      },

                      style: ElevatedButton.styleFrom(

                        /// Fondo negro
                        backgroundColor: Colors.black,

                        /// Bordes redondos
                        shape: RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),

                      child: const Text(

                        'Crear Cuenta',

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),



                  /// Espacio inferior
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  /// =============================================================
  /// INPUT PERSONALIZADO
  /// =============================================================

  /// Widget reutilizable TextField
  Widget _customInput({

    /// Ocultar texto
    bool obscureText = false,

  }) {

    return SizedBox(

      /// Alto input
      height: 50,

      child: TextField(

        /// Contraseña oculta
        obscureText: obscureText,

        decoration: InputDecoration(

          /// Fondo activo
          filled: true,

          /// Fondo blanco
          fillColor: Colors.white,

          /// Padding interno
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 14,
          ),

          /// Borde principal
          border: OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(8),

            borderSide: BorderSide(

              color: Colors.grey.shade300,
            ),
          ),

          /// Borde habilitado
          enabledBorder: OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(8),

            borderSide: BorderSide(

              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }
}