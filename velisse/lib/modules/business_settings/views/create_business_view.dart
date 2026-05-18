/// ===============================================================
/// IMPORTS
/// ===============================================================

library;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/fondo.dart';

/// 👉 PASO SIGUIENTE DEL FLUJO
import 'configuracion_negocio_view.dart';

/// 🚨 IMPORTANTE: DASHBOARD FINAL DEL OWNER
import 'package:velisse/modules/dashboard/views/dashboard_view.dart';

/// ===============================================================
/// CREATE BUSINESS VIEW (PASO 1 DEL FLUJO)
/// ===============================================================
/// 👉 Aquí el OWNER crea el negocio base
/// 👉 Se genera el businessId
/// 👉 Luego continúa el flujo de creación
/// ===============================================================

class CreateBusinessView extends StatefulWidget {
  const CreateBusinessView({super.key});

  @override
  State<CreateBusinessView> createState() => _CreateBusinessViewState();
}

/// ===============================================================
/// STATE
/// ===============================================================

class _CreateBusinessViewState extends State<CreateBusinessView> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  bool isLoading = false;

  /// =============================================================
  /// CREAR NEGOCIO
  /// =============================================================
  Future<void> createBusiness() async {

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario no autenticado')),
      );
      return;
    }

    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nombre obligatorio')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {

      /// 1. CREAR DOCUMENTO
      final businessRef = await FirebaseFirestore.instance
          .collection('businesses')
          .add({
        'ownerId': user.uid,
        'name': nameController.text.trim(),
        'website': websiteController.text.trim(),
        'categories': [],
        'schedule': {},
        'location': {},
        'step': 'categories',
        'createdAt': FieldValue.serverTimestamp(),
      });

      /// 2. GUARDAR businessId
      await FirebaseFirestore.instance
          .collection('businesses')
          .doc(businessRef.id)
          .update({
        'businessId': businessRef.id,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Negocio creado')),
      );

      /// =========================================================
      /// 3. SIGUIENTE PASO DEL FLUJO
      /// =========================================================
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ConfiguracionNegocioView(
            businessId: businessRef.id,
          ),
        ),
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
  /// UI
  /// =============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 20),

                const Text(
                  'Crea tu negocio',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                const Text('Nombre del negocio'),
                const SizedBox(height: 8),

                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text('Sitio web (opcional)'),
                const SizedBox(height: 8),

                TextField(
                  controller: websiteController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(
                    onPressed: isLoading ? null : createBusiness,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),

                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Continuar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}