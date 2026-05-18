library;

import 'package:flutter/material.dart';

import 'package:velisse/modules/calendar/views/calendar_view.dart';
import 'package:velisse/modules/dates/views/dates_view.dart';
import 'package:velisse/modules/notifications/views/notifications_view.dart';

import 'package:velisse/modules/home/widgets/home_content.dart';
import 'package:velisse/modules/auth/views/login_view.dart';

class HomeUserView extends StatefulWidget {
  const HomeUserView({super.key});

  @override
  State<HomeUserView> createState() => _HomeUserViewState();
}

class _HomeUserViewState extends State<HomeUserView> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeContent(),
    CalendarContent(),
    DatesContent(),
    NotificationsContent(),
    LogginView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),

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