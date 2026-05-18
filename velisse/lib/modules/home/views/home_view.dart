/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
library;

import 'package:flutter/material.dart';

/// 👇 ESTE IMPORT ES EL CLAVE (tu HomeContent real)
import 'package:velisse/modules/home/widgets/home_content.dart';

import 'package:velisse/modules/calendar/views/calendar_view.dart';
import 'package:velisse/modules/dates/views/dates_view.dart';
import 'package:velisse/modules/notifications/views/notifications_view.dart';
import 'package:velisse/modules/auth/views/login_view.dart';

/// ===============================================================
/// HOME VIEW (INVITADO / NO LOGEADO O BASE)
/// ===============================================================

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    this.isLoggedIn = false,
  });

  final bool isLoggedIn;

  @override
  State<HomeView> createState() => _HomeViewState();
}

/// ===============================================================
/// STATE
/// ===============================================================

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    isLoggedIn = widget.isLoggedIn;
  }

  /// =============================================================
  /// PANTALLAS DINÁMICAS
  /// =============================================================

  List<Widget> get _screens {
    if (isLoggedIn) {
      return [
        const HomeContent(),
        const CalendarContent(),
        const DatesContent(),
        const NotificationsContent(),
        const LogginView(),
      ];
    }

    return [
      const HomeContent(),
      const LogginView(),
    ];
  }

  /// =============================================================
  /// BUILD
  /// =============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,

        items: isLoggedIn
            ? const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Calendario',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.watch_later_outlined),
                  label: 'Fechas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notificaciones',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
              ]
            : const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Ingresar',
                ),
              ],
      ),
    );
  }
}