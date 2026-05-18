import 'package:flutter/material.dart';
import 'package:velisse/views/login_view.dart';
import 'package:velisse/widgets/fondo.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool acceptTerms = false;
  bool acceptMarketing = false;
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Back button
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LogginView()),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),

                const SizedBox(height: 40),

                // Title
                const Text(
                  'Crear cuenta',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle
                const Text(
                  '¡Ya casi lo logras! Crea tu nueva cuenta\ncompletando estos datos.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                // Nombre
                const Text(
                  'Nombre',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                _customInput(),

                const SizedBox(height: 20),

                // Apellido
                const Text(
                  'Apellido',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                _customInput(),

                const SizedBox(height: 20),

                // Contraseña
                const Text(
                  'Contraseña',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                _customInput(
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                // Número celular
                const Text(
                  'Número de celular',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Container(
                      width: 62,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '+57',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: _customInput(),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Checkbox 1
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: acceptTerms,
                      activeColor: Colors.deepPurple,
                      onChanged: (value) {
                        setState(() {
                          acceptTerms = value ?? false;
                        });
                      },
                    ),

                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(text: 'Acepto los '),
                            TextSpan(
                              text: 'Política de privacidad, ',
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                            ),
                            TextSpan(
                              text: 'Términos de uso ',
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                            ),
                            TextSpan(text: 'y '),
                            TextSpan(
                              text: 'Términos de servicio',
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
                const SizedBox(height: 10),
                // Checkbox 2
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: acceptMarketing,
                      activeColor: Colors.deepPurple,
                      onChanged: (value) {
                        setState(() {
                          acceptMarketing = value ?? false;
                        });
                      },
                    ),

                    const Expanded(
                      child: Text(
                        'Acepto recibir notificaciones de marketing con ofertas y noticias',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
    bool obscureText = false,
  }) {
    return SizedBox(
      height: 50,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }
}