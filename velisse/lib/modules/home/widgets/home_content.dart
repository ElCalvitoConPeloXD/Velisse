/// ===============================================================
/// HOME CONTENT - DINÁMICO (FIRESTORE)
/// ===============================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:velisse/modules/business/views/business_detail_view.dart';

/// ===============================================================
/// WIDGET PRINCIPAL
/// ===============================================================
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Stream<QuerySnapshot> getBusinesses() {
    return FirebaseFirestore.instance.collection('businesses').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 20),

            /// BUSCADOR
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Categorías',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _category('assets/images/barberia.png', 'Barbería'),
                _category('assets/images/uñas.png', 'Uñas'),
                _category('assets/images/peluqueria.png', 'Peluquería'),
                _category('assets/images/Facial.png', 'Facial'),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Salones Recomendados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            StreamBuilder<QuerySnapshot>(
              stream: getBusinesses(),

              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return const Text("No se pudieron cargar negocios");
                }

                final docs = snapshot.data!.docs;

                if (docs.isEmpty) {
                  return const Text("No hay negocios registrados");
                }

                return CarouselSlider(
                  options: CarouselOptions(
                    height: 280,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.75,
                  ),

                  items: docs.map((doc) {

                    final data = doc.data() as Map<String, dynamic>;

                    final name = data['name'] ?? 'Sin nombre';
                    final categories =
                        data['categories'] as List<dynamic>? ?? [];
                    final image = data['image'] ?? '';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BusinessDetailView(
                              businessId: doc.id,
                            ),
                          ),
                        );
                      },

                      child: _card(
                        image,
                        name,
                        categories.isNotEmpty
                            ? categories.first
                            : 'Servicio',
                        '⭐ 4.8',
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// =============================================================
  /// CATEGORÍA
  /// =============================================================
  Widget _category(String img, String label) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            img,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  /// =============================================================
  /// CARD LIMPIO (SIN HORARIOS)
  /// =============================================================
  Widget _card(
    String img,
    String title,
    String desc,
    String rating,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 250,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black12,
            offset: Offset(0, 3),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),

            child: img.startsWith('http')
                ? Image.network(
                    img,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    img,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  rating,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}