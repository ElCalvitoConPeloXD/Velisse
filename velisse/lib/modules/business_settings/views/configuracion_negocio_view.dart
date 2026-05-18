/// ===============================================================
/// IMPORTS
/// ===============================================================

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../schedules/views/horarios_view.dart';

/// ===============================================================
/// CONFIGURACIÓN NEGOCIO (PASO 2)
/// ===============================================================
/// 👉 Aquí se guardan categorías del negocio
/// 👉 El negocio YA existe (viene de CreateBusinessView)

class ConfiguracionNegocioView extends StatefulWidget {

  /// ID del negocio creado en Firestore
  final String businessId;

  const ConfiguracionNegocioView({
    super.key,
    required this.businessId,
  });

  @override
  State<ConfiguracionNegocioView> createState() =>
      _ConfiguracionNegocioViewState();
}

/// ===============================================================
/// STATE
/// ===============================================================

class _ConfiguracionNegocioViewState extends State<ConfiguracionNegocioView> {

  /// categorías seleccionadas
  List<String> selectedCategories = [];

  /// loading
  bool isLoading = false;

  /// =============================================================
  /// GUARDAR CATEGORÍAS EN FIRESTORE
  /// =============================================================
  Future<void> saveCategoriesAndContinue() async {

    if (selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona al menos una categoría")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {

      /// 🔥 actualizar business en Firestore
      await FirebaseFirestore.instance
          .collection('businesses')
          .doc(widget.businessId)
          .update({
        'categories': selectedCategories,
        'step': 'schedules',
      });

      /// ✅ siguiente paso (IMPORTANTE: pasar businessId)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HorariosView(
            businessId: widget.businessId,
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Velisse_Fondo_General.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.2),
          ),

          SafeArea(

            child: Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const SizedBox(height: 10),

                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Selecciona las categorías",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Elige hasta 3 servicios",
                    style: TextStyle(color: Colors.black54),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        _buildCategory("Peluquería", Icons.cut),
                        _buildCategory("Barbería", Icons.content_cut),
                        _buildCategory("Uñas", Icons.brush),
                        _buildCategory("Facial", Icons.face),
                        _buildCategory("Cejas", Icons.visibility),
                        _buildCategory("Depilación", Icons.spa),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : saveCategoriesAndContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Continuar"),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(String title, IconData icon) {

    final isSelected = selectedCategories.contains(title);

    return GestureDetector(

      onTap: () {
        setState(() {

          if (isSelected) {
            selectedCategories.remove(title);
          } else {
            if (selectedCategories.length < 3) {
              selectedCategories.add(title);
            }
          }
        });
      },

      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: isSelected ? Colors.white : Colors.black),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}