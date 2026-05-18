/// ===============================================================
/// IMPORTACIONES
/// ===============================================================

/// library;
///
/// Opcional.
/// Flutter normalmente NO necesita esto
/// pero puedes dejarlo sin problema.
library;


/// ===============================================================
/// IMPORTAR FIRST VIEW
/// ===============================================================

/// Pantalla onboarding/splash inicial
///
/// Esta será la primera pantalla
/// que verá el usuario
import 'package:velisse/modules/onboarding/views/first_view.dart';




/// ===============================================================
/// IMPORTAR FLUTTER MATERIAL
/// ===============================================================

/// Material Design Flutter
///
/// Gracias a esto podemos usar:
/// - MaterialApp
/// - Scaffold
/// - AppBar
/// - Text
/// - Colors
/// - etc
import 'package:flutter/material.dart';


/// ===============================================================
/// IMPORTAR FIREBASE
/// ===============================================================

/// Firebase Core
///
/// Necesario para inicializar Firebase
///
/// Sin esto:
/// Firebase.initializeApp()
/// NO funcionará
import 'package:firebase_core/firebase_core.dart';





/// ===============================================================
/// MAIN
/// ===============================================================

/// main():
///
/// Punto de entrada principal Flutter
void main() async {

  /// =============================================================
  /// INICIALIZAR FLUTTER
  /// =============================================================

  /// Necesario antes de:
  /// - Firebase
  /// - plugins
  /// - código async
  WidgetsFlutterBinding.ensureInitialized();



  /// =============================================================
  /// INICIALIZAR FIREBASE
  /// =============================================================

  /// Esperar inicialización Firebase
  await Firebase.initializeApp();



  /// =============================================================
  /// EJECUTAR APP
  /// =============================================================

  /// Iniciar aplicación Flutter
  runApp(

    /// Widget raíz principal
    const MyApp(),
  );
}



/// ===============================================================
/// APP PRINCIPAL
/// ===============================================================

/// StatelessWidget:
///
/// Se usa porque:
/// la configuración principal
/// NO cambia dinámicamente
class MyApp extends StatelessWidget {

  /// Constructor
  const MyApp({super.key});



  /// =============================================================
  /// BUILD
  /// =============================================================

  /// build():
  ///
  /// construye toda la aplicación
  @override
  Widget build(BuildContext context) {

    /// ===========================================================
    /// MATERIAL APP
    /// ===========================================================

    /// MaterialApp:
    ///
    /// estructura principal Flutter
    return MaterialApp(

      /// =========================================================
      /// TÍTULO APP
      /// =========================================================

      /// Nombre interno aplicación
      title: 'Velisse',



      /// =========================================================
      /// OCULTAR BANNER DEBUG
      /// =========================================================

      /// Elimina banner rojo DEBUG
      debugShowCheckedModeBanner: false,



      /// =========================================================
      /// TEMA GLOBAL
      /// =========================================================

      /// Configuración visual global
      theme: ThemeData(

        /// Color principal Material
        primarySwatch: Colors.blue,
      ),



      /// =========================================================
      /// HOME
      /// =========================================================

      /// Pantalla inicial aplicación
      ///
      /// Actualmente:
      /// onboarding/splash
      home: FirstView(),




      /// =========================================================
      /// OPCIONES TEMPORALES
      /// =========================================================

      /// Para pruebas puedes usar:
      ///

      /// Pantalla reservas
      // home: BookingCalendarView(),

      /// Dashboard reservas
      // home: DashboardBookingsView(),
    );
  }
}