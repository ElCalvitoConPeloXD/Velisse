/// ===============================================================
/// OWNER SETUP VIEW
/// ===============================================================

library;

import 'package:flutter/material.dart';

class OwnerSetupView extends StatelessWidget {
  const OwnerSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const Text(
                  "¿Cómo quieres configurar tu negocio?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                /// =========================
                /// CREAR NEGOCIO
                /// =========================
                _optionCard(
                  context,
                  title: "Crear nuevo negocio",
                  subtitle: "Empieza desde cero tu salón o empresa",
                  icon: Icons.add_business,
                  onTap: () {
                    // luego conectas Firebase business create
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Crear negocio")),
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// =========================
                /// EDITAR NEGOCIO
                /// =========================
                _optionCard(
                  context,
                  title: "Ya tengo un negocio",
                  subtitle: "Editar información existente",
                  icon: Icons.edit,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Editar negocio")),
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// =========================
                /// ASIGNAR PROFESIONALES
                /// =========================
                _optionCard(
                  context,
                  title: "Asignar profesionales",
                  subtitle: "Gestiona tu equipo de trabajo",
                  icon: Icons.people,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Asignar profesionales")),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _optionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.purple),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}