import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            // BUSCADOR
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

            // CATEGORÍAS (ARREGLADO)
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

            CarouselSlider(
              options: CarouselOptions(
                height: 280,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.75,
              ),
              items: [
                _card('assets/images/img1.png', 'Magic Nails', 'Uñas', '4.8⭐'),
                _card('assets/images/img2.png', 'Esencia Spa', 'Facial', '4.9⭐'),
                _card('assets/images/img3.png', 'Clásico 21', 'Barbería', '4.8⭐'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // CATEGORÍAS (FIX)
  // =========================
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

  // =========================
  // CARD (FIX REAL)
  // =========================
  Widget _card(String img, String title, String desc, String rating) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 250, // 👈 TODOS IGUALES
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

          // IMAGEN FIJA
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
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