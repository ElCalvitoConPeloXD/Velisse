// ===============================================================
/// LOGIN VIEW
// ===============================================================

library;

// ===============================================================
/// IMPORTACIONES
// ===============================================================

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// DASHBOARD (CLIENTE LOGUEADO)
import 'package:velisse/modules/home/views/home_user_view.dart';

/// REGISTRO
import 'package:velisse/modules/auth/views/createUser_view.dart';

/// PROFESIONALES
import 'package:velisse/modules/auth/views/loginPro_view.dart';

/// FONDO
import '../../../widgets/fondo.dart';

/// ===============================================================
/// LOGIN VIEW
/// ===============================================================

class LogginView extends StatefulWidget {
  const LogginView({super.key});

  @override
  State<LogginView> createState() => _LogginViewState();
}

/// ===============================================================
/// STATE
/// ===============================================================

class _LogginViewState extends State<LogginView> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  /// ===============================================================
  /// LOGIN CON ROL
  /// ===============================================================
  Future<void> login() async {

    try {
      setState(() => isLoading = true);

      /// 1. LOGIN FIREBASE AUTH
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = cred.user!.uid;

      /// 2. BUSCAR USUARIO EN FIRESTORE
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      final role = doc.data()?['role'];

      /// 3. REDIRECCIÓN SEGÚN ROL
      if (role == 'owner') {

        /// 🚨 SI ES OWNER NO DEBERÍA ENTRAR AQUÍ
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Este login es solo para clientes'),
          ),
        );

        await FirebaseAuth.instance.signOut();

      } else {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeUserView(),
          ),
        );
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// ===============================================================
  /// UI
  /// ===============================================================
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,

      body: GradientBackground(

        child: SafeArea(

          child: SingleChildScrollView(

            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),

            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),

              child: IntrinsicHeight(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),

                    const SizedBox(height: 40),

                    const Text(
                      '¡Bienvenido de\nnuevo!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Inicia sesión para reservar y\nadministrar tus citas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'correo@dominio.com',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Contraseña',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : login,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Continuar',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterView(),
                          ),
                        );
                      },
                      child: const Text('Registrarse'),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.grey)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('o'),
                        ),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Al hacer clic en continuar, aceptas nuestros Términos de servicio y Política de privacidad',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 50),

                    const Text(
                      '¿Tienes una cuenta de empresa?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LogginProView(),
                          ),
                        );
                      },
                      child: const Text(
                        'Inicia sesión como profesional',
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

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