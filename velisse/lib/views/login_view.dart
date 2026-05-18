import 'package:flutter/material.dart';
import 'package:velisse/views/home_view.dart';
import 'package:velisse/views/createUser_view.dart';
import 'package:velisse/widgets/fondo.dart';
import 'package:velisse/views/loginPro_view.dart';
class LogginView extends StatelessWidget {
  const LogginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                          );
                        },
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
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Crea una cuenta o inicia sesión para reservar y\nadministrar tus citas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextField(
                      decoration: InputDecoration(
                        hintText: 'correoelectrónico@dominio.com',
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

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterView()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Continuar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('o'),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

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
                            text: 'Términos de\nservicio',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(text: ' y '),
                          TextSpan(
                            text: 'Política de privacidad',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
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
                          MaterialPageRoute(builder: (context) => LogginProView()),
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