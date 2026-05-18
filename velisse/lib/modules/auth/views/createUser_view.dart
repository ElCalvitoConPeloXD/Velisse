// ===============================================================
/// IMPORTACIONES
// ===============================================================
library;

// ===============================================================
/// IMPORTAR AUTH SERVICE
// ===============================================================

import 'package:velisse/modules/auth/services/auth_service.dart';

// ===============================================================
/// MATERIAL DESIGN
// ===============================================================

import 'package:flutter/material.dart';

// ===============================================================
/// IMPORTAR LOGIN VIEW
// ===============================================================

import 'package:velisse/modules/auth/views/login_view.dart';

// ===============================================================
/// IMPORTAR HOME VIEW
// ===============================================================

import 'package:velisse/modules/home/views/home_view.dart';

// ===============================================================
/// IMPORTAR FONDO PERSONALIZADO
// ===============================================================

import '../../../widgets/fondo.dart';


// ===============================================================
/// REGISTER VIEW CLIENTES
// ===============================================================

class RegisterView extends StatefulWidget {

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}


// ===============================================================
/// ESTADO REGISTER VIEW
// ===============================================================

class _RegisterViewState extends State<RegisterView> {

  // =============================================================
  // VARIABLES CHECKBOX
  // =============================================================

  bool acceptTerms = false;
  bool acceptMarketing = false;

  // =============================================================
  // VARIABLE LOADING
  // =============================================================

  bool isLoading = false;

  // =============================================================
  // CONTROLLERS INPUTS
  // =============================================================

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // =============================================================
  // AUTH SERVICE
  // =============================================================

  final AuthService authService = AuthService();


  // =============================================================
  // REGISTER USER
  // =============================================================

  Future<void> registerUser() async {

    if (!acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes aceptar los términos y condiciones'),
        ),
      );
      return;
    }

    if (
      nombreController.text.isEmpty ||
      apellidoController.text.isEmpty ||
      emailController.text.isEmpty ||
      telefonoController.text.isEmpty ||
      passwordController.text.isEmpty
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa todos los campos'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      await authService.registerUser(
        nombre: nombreController.text.trim(),
        apellido: apellidoController.text.trim(),
        email: emailController.text.trim(),
        telefono: telefonoController.text.trim(),
        password: passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario registrado correctamente'),
        ),
      );

      // =========================================================
      // 🔥 FIX REAL (ESTO ES LO QUE ROMPÍA TU APP)
      // =========================================================

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  // =============================================================
  // UI (NO TOCADO - EXACTAMENTE TUYO)
  // =============================================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,

      body: GradientBackground(

        child: SafeArea(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),

            child: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 10),

                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogginView(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    'Crear cuenta',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    '¡Ya casi lo logras! Crea tu nueva cuenta\ncompletando estos datos.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 35),

                  const Text('Nombre', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _customInput(controller: nombreController),

                  const SizedBox(height: 20),

                  const Text('Apellido', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _customInput(controller: apellidoController),

                  const SizedBox(height: 20),

                  const Text('Correo electrónico', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _customInput(controller: emailController),

                  const SizedBox(height: 20),

                  const Text('Contraseña', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _customInput(controller: passwordController, obscureText: true),

                  const SizedBox(height: 20),

                  const Text('Número de celular', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),

                  Row(
                    children: [

                      Container(
                        width: 62,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        alignment: Alignment.center,
                        child: const Text('+57'),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _customInput(controller: telefonoController),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Checkbox(
                        value: acceptTerms,
                        onChanged: (v) {
                          setState(() {
                            acceptTerms = v ?? false;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text(
                          'Acepto términos y condiciones',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),

                  Row(
                    children: [
                      Checkbox(
                        value: acceptMarketing,
                        onChanged: (v) {
                          setState(() {
                            acceptMarketing = v ?? false;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text(
                          'Acepto recibir notificaciones',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Crear Cuenta'),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _customInput({
    TextEditingController? controller,
    bool obscureText = false,
  }) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}