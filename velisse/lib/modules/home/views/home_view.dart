/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
library;

/// Flutter Material Design
///
/// Permite usar:
/// - Scaffold
/// - AppBar
/// - BottomNavigationBar
/// - Text
/// - Column
/// - etc
import 'package:flutter/material.dart';


/// Carrusel de imágenes
///
/// Librería externa:
/// carousel_slider
import 'package:carousel_slider/carousel_slider.dart';


/// ===============================================================
/// IMPORTS MODULARES
/// ===============================================================

/// Vista calendario
import 'package:velisse/modules/calendar/views/calendar_view.dart';


/// Vista fechas
import 'package:velisse/modules/dates/views/dates_view.dart';


/// Vista notificaciones
import 'package:velisse/modules/notifications/views/notifications_view.dart';


/// Vista login
///
/// TEMPORAL:
/// luego puede reemplazarse por:
/// ProfileView()
import 'package:velisse/modules/auth/views/login_view.dart';



/// ===============================================================
/// HOME VIEW
/// ===============================================================

/// StatefulWidget:
///
/// usamos Stateful porque:
/// el BottomNavigationBar cambia dinámicamente
///
/// cuando el usuario cambia de pestaña
class HomeView extends StatefulWidget {

  /// Constructor
  const HomeView({super.key});

  @override
  State<HomeView> createState() =>
      _HomeViewState();
}



/// ===============================================================
/// STATE HOME VIEW
/// ===============================================================

class _HomeViewState
    extends State<HomeView> {

  /// =============================================================
  /// ÍNDICE TAB ACTUAL
  /// =============================================================

  /// Controla:
  /// qué pantalla se muestra
  ///
  /// 0 = inicio
  /// 1 = calendario
  /// etc
  int _currentIndex = 0;


  /// =============================================================
  /// LISTA PANTALLAS
  /// =============================================================

  /// Lista de widgets/pantallas
  ///
  /// Cada índice corresponde
  /// al BottomNavigationBar
  final List<Widget> _screens = [

    /// Pantalla inicio
    const HomeContent(),

    /// Pantalla calendario
    const CalendarContent(),

    /// Pantalla fechas
    const DatesContent(),

    /// Pantalla notificaciones
    const NotificationsContent(),

    /// TEMPORAL:
    /// login/perfil
    const LogginView(),
  ];


  /// =============================================================
  /// BUILD
  /// =============================================================

  @override
  Widget build(BuildContext context) {

    /// Scaffold:
    /// estructura principal visual
    return Scaffold(

      /// =========================================================
      /// BODY
      /// =========================================================

      /// Muestra la pantalla
      /// según el índice actual
      body: _screens[_currentIndex],


      /// =========================================================
      /// BOTTOM NAVIGATION BAR
      /// =========================================================

      bottomNavigationBar:
          BottomNavigationBar(

        /// Índice seleccionado
        currentIndex: _currentIndex,

        /// =======================================================
        /// CAMBIO DE TAB
        /// =======================================================

        /// onTap:
        /// se ejecuta cuando el usuario
        /// toca un ícono
        onTap: (index) {

          /// setState:
          /// redibuja la pantalla
          setState(() {

            /// Cambia pestaña actual
            _currentIndex = index;
          });
        },

        /// Color ícono seleccionado
        selectedItemColor:
            Colors.purple,

        /// Color ícono NO seleccionado
        unselectedItemColor:
            Colors.grey,

        /// =======================================================
        /// ITEMS
        /// =======================================================

        items: const [

          /// Inicio
          BottomNavigationBarItem(

            icon: Icon(Icons.home),

            label: 'Inicio',
          ),

          /// Calendario
          BottomNavigationBarItem(

            icon:
                Icon(Icons.calendar_month),

            label: 'Calendario',
          ),

          /// Fechas
          BottomNavigationBarItem(

            icon: Icon(
              Icons.watch_later_outlined,
            ),

            label: 'Fechas',
          ),

          /// Notificaciones
          BottomNavigationBarItem(

            icon:
                Icon(Icons.notifications),

            label: 'Notificaciones',
          ),

          /// Perfil/Login
          BottomNavigationBarItem(

            icon: Icon(Icons.person),

            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}



/// ===============================================================
/// CONTENIDO HOME
/// ===============================================================

/// StatelessWidget:
///
/// porque esta pantalla
/// no cambia dinámicamente
class HomeContent extends StatelessWidget {

  /// Constructor
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {

    /// SingleChildScrollView:
    /// permite scroll vertical
    return SingleChildScrollView(

      child: Padding(

        /// Padding general
        padding:
            const EdgeInsets.all(16),

        child: Column(

          /// Alineación izquierda
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// Espacio superior
            const SizedBox(height: 20),


            /// ===================================================
            /// BARRA BÚSQUEDA
            /// ===================================================

            TextField(

              decoration: InputDecoration(

                /// Texto placeholder
                hintText: 'Buscar...',

                /// Ícono izquierda
                prefixIcon:
                    const Icon(Icons.search),

                /// Bordes redondeados
                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(30),
                ),

                /// Fondo activo
                filled: true,

                /// Color fondo
                fillColor:
                    Colors.grey.shade200,
              ),
            ),

            const SizedBox(height: 30),


            /// ===================================================
            /// TÍTULO CATEGORÍAS
            /// ===================================================

            const Text(

              'Categorías',

              style: TextStyle(

                fontSize: 24,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),


            /// ===================================================
            /// CATEGORÍAS
            /// ===================================================

            LayoutBuilder(

              builder:
                  (context, constraints) {

                return Container(

                  padding:
                      const EdgeInsets.all(8),

                  decoration: BoxDecoration(

                    border: Border.all(

                      color: Colors.white,

                      width: 2,
                    ),

                    borderRadius:
                        BorderRadius.circular(16),
                  ),

                  child: Row(

                    children: [

                      Expanded(

                        child:
                            _buildCategoryImage(

                          'assets/images/barberia.png',

                          'Barbería',

                          constraints.maxWidth * 0.2,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(

                        child:
                            _buildCategoryImage(

                          'assets/images/uñas.png',

                          'Uñas',

                          constraints.maxWidth * 0.2,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(

                        child:
                            _buildCategoryImage(

                          'assets/images/peluqueria.png',

                          'Peluquería',

                          constraints.maxWidth * 0.2,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(

                        child:
                            _buildCategoryImage(

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

            const SizedBox(height: 30),


            /// ===================================================
            /// TÍTULO CARRUSEL
            /// ===================================================

            const Text(

              'Salones Recomendados',

              style: TextStyle(

                fontSize: 24,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),


            /// ===================================================
            /// CARRUSEL
            /// ===================================================

            CarouselSlider(

              options: CarouselOptions(

                /// Altura carrusel
                height: 270,

                /// Autoplay
                autoPlay: true,

                /// Tiempo autoplay
                autoPlayInterval:
                    const Duration(seconds: 3),

                /// Tamaño item visible
                viewportFraction: 0.8,

                /// Agranda item central
                enlargeCenterPage: true,
              ),

              /// =================================================
              /// ITEMS
              /// =================================================

              items: [

                {
                  'imagePath':
                      'assets/images/img1.png',

                  'description': 'Uñas',

                  'title': 'Magic Nails',

                  'rating': '4.8⭐',
                },

                {
                  'imagePath':
                      'assets/images/img2.png',

                  'description': 'Facial',

                  'title': 'Esencia Spa',

                  'rating': '4.9⭐',
                },

                {
                  'imagePath':
                      'assets/images/img3.png',

                  'description': 'Barbería',

                  'title': 'Clásico 21',

                  'rating': '4.8⭐',
                },

              ].map((item) {

                return Container(

                  decoration: BoxDecoration(

                    borderRadius:
                        BorderRadius.circular(16),

                    color: Colors.white,

                    boxShadow: [

                      BoxShadow(

                        color: Colors.grey
                            .withOpacity(0.3),

                        spreadRadius: 2,

                        blurRadius: 5,

                        offset:
                            const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      /// Imagen
                      ClipRRect(

                        borderRadius:
                            const BorderRadius.only(

                          topLeft:
                              Radius.circular(16),

                          topRight:
                              Radius.circular(16),
                        ),

                        child: Image.asset(

                          item['imagePath']!,

                          height: 150,

                          width: double.infinity,

                          fit: BoxFit.cover,
                        ),
                      ),

                      /// Textos
                      Padding(

                        padding:
                            const EdgeInsets.all(8),

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(

                              item['description']!,

                              style: TextStyle(

                                fontSize: 12,

                                color:
                                    Colors.grey[600],
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(

                              item['title']!,

                              style: const TextStyle(

                                fontSize: 16,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(

                              item['rating']!,

                              style: const TextStyle(

                                fontSize: 12,

                                color: Colors.amber,

                                fontWeight:
                                    FontWeight.bold,
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  /// =============================================================
  /// WIDGET CATEGORÍA
  /// =============================================================

  /// Widget reutilizable
  /// para categorías
  static Widget _buildCategoryImage(

    String imagePath,

    String label,

    double height,

  ) {

    return Column(

      children: [

        /// Imagen circular
        ClipRRect(

          borderRadius:
              BorderRadius.circular(50),

          child: Image.asset(

            imagePath,

            height: height,

            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 8),

        /// Texto categoría
        Text(

          label,

          style: const TextStyle(

            fontSize: 12,

            fontWeight:
                FontWeight.w500,
          ),

          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}