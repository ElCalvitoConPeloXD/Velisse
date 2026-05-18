/// ===============================================================
/// IMPORTACIONES
/// ===============================================================

library;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:velisse/modules/auth/views/login_view.dart';

/// 👇 AQUÍ IMPORTAS TU HOME CON BARRA COMPLETA
import 'package:velisse/modules/home/views/home_user_view.dart';

import '../../../widgets/fondo.dart';

/// ===============================================================
/// REGISTER VIEW PROFESIONAL
/// ===============================================================

class RegisterViewPro extends StatefulWidget {
  const RegisterViewPro({super.key});

  @override
  State<RegisterViewPro> createState() => _RegisterViewStatePro();
}

/// ===============================================================
/// STATE
/// ===============================================================

class _RegisterViewStatePro extends State<RegisterViewPro> {

  bool acceptTerms = false;
  bool acceptMarketing = false;

  bool isLoading = false;

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// =============================================================
  /// REGISTRO OWNER
  /// =============================================================

  Future<void> registerOwner() async {

    if (!acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes aceptar los términos')),
      );
      return;
    }

    if (nombreController.text.isEmpty ||
        apellidoController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {

      /// 1. CREAR USUARIO AUTH
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      /// 2. GUARDAR EN FIRESTORE
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        "uid": uid,
        "nombre": nombreController.text.trim(),
        "apellido": apellidoController.text.trim(),
        "email": emailController.text.trim(),
        "telefono": telefonoController.text.trim(),
        "role": "owner",
        "createdAt": DateTime.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada correctamente')),
      );

      /// =========================================================
      /// 
      /// =========================================================

      final user = FirebaseAuth.instance.currentUser;

      /// SI YA ESTÁ LOGEADO → HOME CON BARRA COMPLETA
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeUserView(),
          ),
        );
      } else {
        /// fallback por seguridad
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LogginView(),
          ),
        );
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// =============================================================
  /// 
  /// =============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 30),

                const Text(
                  'Crear cuenta de propietario',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                _input("Nombre", nombreController),
                _input("Apellido", apellidoController),
                _input("Correo electrónico", emailController),
                _input("Contraseña", passwordController, obscure: true),
                _input("Teléfono", telefonoController),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(
                      value: acceptTerms,
                      onChanged: (v) =>
                          setState(() => acceptTerms = v ?? false),
                    ),
                    const Expanded(
                      child: Text("Acepto términos y condiciones"),
                    )
                  ],
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : registerOwner,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Continuar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// =============================================================
  /// INPUT
  /// =============================================================

  Widget _input(String label, TextEditingController controller,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}