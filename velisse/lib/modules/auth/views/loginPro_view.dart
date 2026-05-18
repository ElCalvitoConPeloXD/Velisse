// ===============================================================
/// IMPORTACIONES
// ===============================================================
library;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:velisse/modules/home/views/home_view.dart';
import 'package:velisse/modules/home/views/home_user_view.dart';
import 'package:velisse/modules/dashboard/views/dashboard_view.dart';

import 'package:velisse/modules/auth/views/createPro_view.dart';
import 'package:velisse/modules/auth/views/login_view.dart';

import '../../../widgets/fondo.dart';

/// ===============================================================
/// LOGIN PROFESIONALES
/// ===============================================================
class LogginProView extends StatefulWidget {
  const LogginProView({super.key});

  @override
  State<LogginProView> createState() => _LogginProViewState();
}

class _LogginProViewState extends State<LogginProView> {

  /// =============================================================
  /// CONTROLLERS
  /// =============================================================
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  /// =============================================================
  /// LOGIN CON ROL
  /// =============================================================
  Future<void> login() async {
    try {
      setState(() => isLoading = true);

      /// 🔐 1. LOGIN AUTH
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = credential.user!.uid;

      /// 🔥 2. BUSCAR ROL EN FIRESTORE
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      final role = doc.data()?['role'];

      /// =========================================================
      /// 3. REDIRECCIÓN SEGÚN ROL
      /// =========================================================

      if (role == 'owner') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DashboardView(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeUserView(),
          ),
        );
      }

    } on FirebaseAuthException catch (e) {

      String msg = 'Error al iniciar sesión';

      if (e.code == 'user-not-found') {
        msg = 'Usuario no encontrado';
      }

      if (e.code == 'wrong-password') {
        msg = 'Contraseña incorrecta';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );

    } finally {
      setState(() => isLoading = false);
    }
  }

  /// =============================================================
  /// BUILD (TU DISEÑO SIN CAMBIOS)
  /// =============================================================
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

                    /// ===================================================
                    /// BOTÓN ATRÁS
                    /// ===================================================
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeView(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),

                    const SizedBox(height: 40),

                    const Text(
                      'Velisse para profesionales',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Crea una cuenta o inicia sesión para gestionar tu negocio.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// EMAIL
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'correo@dominio.com',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// PASSWORD
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Contraseña',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// BOTÓN LOGIN
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
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// DIVIDER
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('o'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Al hacer clic en continuar, aceptas nuestros términos',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),

                    const SizedBox(height: 50),

                    const Text(
                      '¿Eres cliente y quieres reservar una cita?',
                    ),

                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LogginView(),
                          ),
                        );
                      },
                      child: const Text(
                        'Ir a Velisse para clientes',
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterViewPro(),
                          ),
                        );
                      },
                      child: const Text(
                        '¿No tienes cuenta? Regístrate aquí',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
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