// ===============================================================
// IMPORTS
// ===============================================================

// Flutter UI
import 'package:flutter/material.dart';

// Firebase Auth (para cerrar sesión)
import 'package:firebase_auth/firebase_auth.dart';

// Widgets y pantallas del proyecto
import 'package:velisse/modules/home/widgets/home_content.dart';
import 'package:velisse/modules/calendar/views/calendar_view.dart';
import 'package:velisse/modules/dates/views/dates_view.dart';
import 'package:velisse/modules/home/views/home_view.dart';

// 🔥 IMPORTANTE: dashboard de reservas del cliente
import 'package:velisse/modules/dashboard/views/dashboard_bookings_view.dart';


// ===============================================================
// HOME USER VIEW (PANTALLA PRINCIPAL DEL CLIENTE)
// ===============================================================

class HomeUserView extends StatefulWidget {

  // constructor constante
  const HomeUserView({super.key});

  @override
  State<HomeUserView> createState() => _HomeUserViewState();
}


// ===============================================================
// ESTADO DE LA PANTALLA
// ===============================================================

class _HomeUserViewState extends State<HomeUserView> {

  // índice del bottom navigation (controla qué pantalla se muestra)
  int _index = 0;

  // =============================================================
  // LISTA DE PANTALLAS (SE USABA ANTES, PERO AQUÍ YA NO ES CLAVE)
  // =============================================================
  final List<Widget> _screens = const [
    HomeContent(), // pantalla principal
    HomeContent(), // placeholder (no se usa realmente)
    HomeContent(), // placeholder (no se usa realmente)
  ];


  // =============================================================
  // LOGOUT REAL (FIREBASE)
  // =============================================================
  Future<void> _logout() async {

    // cerrar sesión en Firebase Auth
    await FirebaseAuth.instance.signOut();

    // evitar errores si el widget ya no está en pantalla
    if (!mounted) return;

    // regresar a HomeView y borrar historial de navegación
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeView(),
      ),
      (route) => false,
    );
  }


  // =============================================================
  // CONFIRMACIÓN DE LOGOUT
  // =============================================================
  Future<void> _confirmLogout() async {

    // mostrar diálogo de confirmación
    final bool? salir = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(

          // título del popup
          title: const Text("Cerrar sesión"),

          // mensaje del popup
          content: const Text("¿Seguro que quieres salir?"),

          actions: [

            // botón cancelar
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),

            // botón confirmar
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Salir"),
            ),
          ],
        );
      },
    );

    // si el usuario confirma logout
    if (salir == true) {
      await _logout();
    }
  }


  // =============================================================
  // UI PRINCIPAL
  // =============================================================
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // =========================================================
      // CUERPO DE LA PANTALLA
      // =========================================================
      body: _screens[_index],

      // =========================================================
      // BOTTOM NAVIGATION BAR
      // =========================================================
      bottomNavigationBar: SafeArea(

        child: Container(

          // márgenes externos
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

          // padding interno
          padding: const EdgeInsets.symmetric(vertical: 12),

          // diseño del contenedor
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              )
            ],
          ),

          // fila de iconos
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [

              // =====================================================
              // BOTÓN HOME
              // =====================================================
              GestureDetector(
                onTap: () {
                  setState(() => _index = 0);
                },
                child: Icon(
                  Icons.home,
                  color: _index == 0 ? Colors.purple : Colors.black,
                ),
              ),


              // =====================================================
              // BOTÓN CALENDARIO (RESERVAS DEL CLIENTE)
              // =====================================================
              GestureDetector(
                onTap: () {

                  // 🔥 aquí abrimos el dashboard de reservas REAL
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardBookingsView(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
              ),


              // =====================================================
              // BOTÓN LOGOUT
              // =====================================================
              GestureDetector(
                onTap: _confirmLogout,
                child: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}