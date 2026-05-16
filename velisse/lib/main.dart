/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
import 'package:velisse/modules/onboarding/views/first_view.dart';
import 'package:velisse/modules/dashboard/views/dashboard_bookings_view.dart';
/// Importa Flutter Material Design
///
/// Gracias a esto podemos usar:
/// - MaterialApp
/// - Scaffold
/// - Text
/// - AppBar
/// - Colors
/// - etc
import 'package:flutter/material.dart';


/// ===============================================================
/// FIREBASE
/// ===============================================================

/// Firebase Core
///
/// Necesario para inicializar Firebase
///
/// Sin esto:
/// Firebase.initializeApp()
/// no funcionará
import 'package:firebase_core/firebase_core.dart';


/// ===============================================================
/// IMPORTAR PANTALLAS
/// ===============================================================

/// Pantalla crear reservas
///
/// Esta pantalla:
/// - crea reservas
/// - verifica disponibilidad
/// - valida horarios ocupados
import 'package:velisse/modules/bookings/views/booking_calendar_view.dart';


/// ===============================================================
/// MAIN
/// ===============================================================

/// main():
/// punto de entrada principal Flutter
void main() async {

  /// =============================================================
  /// INICIALIZAR FLUTTER
  /// =============================================================

  /// Necesario antes de usar:
  /// - Firebase
  /// - plugins
  /// - async
  WidgetsFlutterBinding.ensureInitialized();



  /// =============================================================
  /// INICIALIZAR FIREBASE
  /// =============================================================

  /// Esperar conexión Firebase
  await Firebase.initializeApp();



  /// =============================================================
  /// INICIAR APP
  /// =============================================================

  /// Ejecutar aplicación
  runApp(const MyApp());
}



/// ===============================================================
/// APP PRINCIPAL
/// ===============================================================

/// StatelessWidget:
/// porque NO cambia dinámicamente
class MyApp extends StatelessWidget {

  /// Constructor
  const MyApp({super.key});



  /// =============================================================
  /// BUILD
  /// =============================================================

  @override
  Widget build(BuildContext context) {

    /// MaterialApp:
    /// estructura principal app
    return MaterialApp(

      /// =========================================================
      /// TÍTULO APP
      /// =========================================================

      /// Nombre interno aplicación
      title: 'Velisse',



      /// =========================================================
      /// QUITAR BANNER DEBUG
      /// =========================================================

      /// Oculta banner DEBUG rojo
      debugShowCheckedModeBanner: false,



      /// =========================================================
      /// TEMA GLOBAL
      /// =========================================================

      theme: ThemeData(

        /// Color principal
        primarySwatch: Colors.blue,
      ),



      /// =========================================================
      /// PANTALLA INICIAL
      /// =========================================================

      /// Abrir pantalla crear reserva
      ///
      /// Aquí podrás probar:
      /// - crear reservas
      /// - bloquear horarios repetidos
      /// - validar disponibilidad
      //home: const BookingCalendarView(),
      //home: DashboardBookingsView(),
      home: const FirstView(),
    );
  }
}
