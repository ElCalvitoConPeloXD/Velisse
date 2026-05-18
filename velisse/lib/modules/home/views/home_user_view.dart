import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:velisse/modules/home/widgets/home_content.dart';
import 'package:velisse/modules/calendar/views/calendar_view.dart';
import 'package:velisse/modules/dates/views/dates_view.dart';
import 'package:velisse/modules/notifications/views/notifications_view.dart';
import 'package:velisse/modules/home/views/home_view.dart';

class HomeUserView extends StatefulWidget {
  const HomeUserView({super.key});

  @override
  State<HomeUserView> createState() => _HomeUserViewState();
}

class _HomeUserViewState extends State<HomeUserView> {
  int _index = 0;

  final List<Widget> _screens = const [
    HomeContent(),
    CalendarContent(),
    DatesContent(),
    NotificationsContent(),
    Center(child: Text("Perfil / Edit")),
  ];

  // ================================
  // LOGOUT
  // ================================
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeView(), // 🔥 FIX AQUÍ
      ),
      (route) => false,
    );
  }

  // ================================
  // CONFIRMACIÓN LOGOUT
  // ================================
  Future<void> _confirmLogout() async {
    final bool? salir = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Cerrar sesión"),
          content: const Text("¿Seguro que quieres salir?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Salir"),
            ),
          ],
        );
      },
    );

    if (salir == true) {
      await _logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,

        onTap: (i) {
          if (i == 4) {
            _confirmLogout();
            return;
          }

          setState(() => _index = i);
        },

        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.watch_later_outlined), label: 'Reloj'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Editar'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Salir'),
        ],
      ),
    );
  }
}