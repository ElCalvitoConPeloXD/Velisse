import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:velisse/modules/calendar/views/calendar_view.dart';
import 'package:velisse/modules/dates/views/dates_view.dart';
import 'package:velisse/modules/notifications/views/notifications_view.dart';
import 'package:velisse/modules/profile/views/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  // Las pantallas de cada tab
  final List<Widget> _screens = [
    HomeContent(), // Pantalla de inicio con todo el contenido
    CalendarContent(), // Pantalla de calendario (puedes personalizarla)
    DatesContent(), // Pantalla de fecha (puedes personalizarla)
    NotificationsContent(), // Pantalla de notificaciones (puedes personalizarla)
    ProfileContent(), // Pantalla de perfil (puedes personalizarla)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.watch_later_outlined), label: 'Fechas'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notificaciones'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

// Widget separado para el contenido de la pantalla de inicio
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Permite scroll cuando el contenido es grande
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Barra de Búsqueda
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
            SizedBox(height: 30),
            // Título de Categorías
            Text(
              'Categorías',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            // Categorías (4 imágenes en fila responsiva)
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildCategoryImage(
                          'assets/images/barberia.png',
                          'Barbería',
                          constraints.maxWidth * 0.2,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildCategoryImage(
                          'assets/images/uñas.png',
                          'Uñas',
                          constraints.maxWidth * 0.2,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildCategoryImage(
                          'assets/images/peluqueria.png',
                          'Peluquería',
                          constraints.maxWidth * 0.2,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildCategoryImage(
                          'assets/images/Facial.png',
                          'Facial',
                          constraints.maxWidth * 0.2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            // Título del Carrusel
            Text(
              'Salones Recomendados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            // Carrusel
            CarouselSlider(
              options: CarouselOptions(
                height: 270,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                viewportFraction: 0.8,
                enlargeCenterPage: true,
              ),
              items: [
                {'imagePath': 'assets/images/img1.png',
                'description': 'Uñas',
                'title': 'Magic Nails',
                'rating': '4.8⭐',
                },
                {'imagePath': 'assets/images/img2.png',
                'description': 'Facial',
                'title': 'Esencia Spa',
                'rating': '4.9⭐',
                },
                {'imagePath': 'assets/images/img3.png',
                'description': 'Barbería',
                'title': 'Clásico 21',
                'rating': '4.8⭐',
                },
              ].map((item) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagen
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.asset(
                          item['imagePath']!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Descripción
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['description']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item['title']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item['rating']!,
                              style: TextStyle(
                                fontSize: 12,
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
              }).toList(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir imágenes de categoría con texto
  Widget _buildCategoryImage(String imagePath, String label, double height) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            imagePath,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}