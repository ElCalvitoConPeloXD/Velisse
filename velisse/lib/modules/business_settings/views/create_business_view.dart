/// ===============================================================
/// IMPORTS
/// ===============================================================

library; // 👉 Declara este archivo como una librería Dart

import 'package:flutter/material.dart'; 
// 👉 Importa el framework de UI de Flutter

import 'package:firebase_auth/firebase_auth.dart'; 
// 👉 Permite obtener el usuario logueado (owner)

import 'package:cloud_firestore/cloud_firestore.dart'; 
// 👉 Permite guardar datos en Firestore

import '../../../widgets/fondo.dart'; 
// 👉 Fondo degradado personalizado de la app

import 'configuracion_negocio_view.dart'; 
// 👉 Siguiente pantalla del flujo (categorías)

/// ===============================================================
/// CREATE BUSINESS VIEW (PASO 1 DEL FLUJO)
/// ===============================================================
/// 👉 Aquí el OWNER crea el negocio base
/// 👉 Se genera el businessId
/// 👉 Se inicia el documento en Firestore
/// 👉 Luego se continúa al siguiente paso (categorías)

class CreateBusinessView extends StatefulWidget {
  const CreateBusinessView({super.key}); 
  // 👉 Constructor del widget

  @override
  State<CreateBusinessView> createState() => _CreateBusinessViewState();
  // 👉 Crea el estado mutable
}

/// ===============================================================
/// STATE DEL WIDGET
/// ===============================================================

class _CreateBusinessViewState extends State<CreateBusinessView> {

  /// =============================================================
  /// CONTROLLERS (INPUTS)
  /// =============================================================

  final TextEditingController nameController = TextEditingController();
  // 👉 Controla el texto del nombre del negocio

  final TextEditingController websiteController = TextEditingController();
  // 👉 Controla el texto del sitio web (opcional)

  /// =============================================================
  /// ESTADO DE CARGA
  /// =============================================================

  bool isLoading = false;
  // 👉 Evita doble click mientras se guarda en Firebase

  /// =============================================================
  /// CREAR NEGOCIO EN FIREBASE
  /// =============================================================

  Future<void> createBusiness() async {

    /// 🔥 1. Obtener usuario logueado (OWNER)
    final user = FirebaseAuth.instance.currentUser;

    /// ⚠️ Si no hay usuario logueado
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: usuario no autenticado'),
        ),
      );
      return;
    }

    /// 🔴 2. Validar nombre obligatorio
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El nombre del negocio es obligatorio'),
        ),
      );
      return;
    }

    /// 🔄 3. Activar loading
    setState(() => isLoading = true);

    try {

      /// =========================================================
      /// 4. CREAR DOCUMENTO EN FIRESTORE
      /// =========================================================
      final businessRef = await FirebaseFirestore.instance
          .collection('businesses')
          .add({

        /// 👇 ID del dueño (relación con users)
        'ownerId': user.uid,

        /// 👇 Nombre del negocio
        'name': nameController.text.trim(),

        /// 👇 Sitio web opcional
        'website': websiteController.text.trim(),

        /// 👇 Campos iniciales del negocio (estructura base)
        'categories': [],
        'schedule': {},
        'location': {},

        /// 👇 estado del flujo
        'step': 'categories',

        /// 👇 fecha de creación del documento
        'createdAt': FieldValue.serverTimestamp(),
      });

      /// =========================================================
      /// 5. GUARDAR businessId dentro del mismo documento
      /// =========================================================
      await FirebaseFirestore.instance
          .collection('businesses')
          .doc(businessRef.id)
          .update({
        'businessId': businessRef.id,
      });

      /// =========================================================
      /// 6. MENSAJE DE ÉXITO
      /// =========================================================
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Negocio creado correctamente'),
        ),
      );

      /// =========================================================
      /// 7. NAVEGAR AL SIGUIENTE PASO (CATEGORÍAS)
      /// =========================================================
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ConfiguracionNegocioView(
            businessId: businessRef.id, // 👉 CLAVE del flujo
          ),
        ),
      );

    } catch (e) {

      /// ❌ ERROR EN FIREBASE
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );

    } finally {

      /// 🔄 DESACTIVAR LOADING
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

                /// =========================
                /// TÍTULO
                /// =========================
                const Text(
                  'Crea tu negocio',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                /// =========================
                /// SUBTÍTULO
                /// =========================
                const Text(
                  'Empecemos con lo básico de tu negocio.',
                  style: TextStyle(color: Colors.black54),
                ),

                const SizedBox(height: 30),

                /// =========================
                /// INPUT: NOMBRE
                /// =========================
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

                /// =========================
                /// INPUT: WEBSITE
                /// =========================
                const Text('Sitio web (opcional)'),
                const SizedBox(height: 8),

                TextField(
                  controller: websiteController,
                  decoration: InputDecoration(
                    hintText: 'https://mi-negocio.com',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// =========================
                /// BOTÓN CONTINUAR
                /// =========================
                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(

                    onPressed: isLoading ? null : createBusiness,
                    // 👉 desactiva si está cargando

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