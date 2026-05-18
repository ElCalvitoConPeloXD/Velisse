/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
library;

/// Importa el modelo BookingModel
///
/// Este modelo representa:
/// - una reserva
/// - estructura datos Firebase
import '../../bookings/models/booking_model.dart';


/// Importa el servicio Firebase
///
/// Este service se comunica
/// directamente con Firestore
import '../../bookings/services/booking_service.dart';


/// ===============================================================
/// CONTROLADOR DASHBOARD
/// ===============================================================

/// Este controller se encarga de:
/// - mostrar reservas
/// - escuchar realtime
/// - cancelar reservas
///
/// Profesionalmente:
/// este controller pertenece
/// al módulo dashboard
class DashboardController {

  /// =============================================================
  /// SERVICIO FIREBASE
  /// =============================================================

  /// Instancia del service
  ///
  /// Gracias a esto podemos usar:
  /// - getBookings()
  /// - deleteBooking()
  final BookingService _service =
      BookingService();


  /// =============================================================
  /// OBTENER RESERVAS REALTIME
  /// =============================================================

  /// Stream<List<BookingModel>>
  ///
  /// Stream:
  /// escucha cambios en tiempo real
  ///
  /// List<BookingModel>:
  /// devuelve lista reservas
  Stream<List<BookingModel>> getBookings() {

    /// Retorna stream realtime
    /// desde Firebase Firestore
    return _service.getBookings();
  }


  /// =============================================================
  /// CANCELAR RESERVA
  /// =============================================================

  /// bookingId:
  /// ID documento Firebase
  ///
  /// Ejemplo:
  /// ajs82jd92jd92
  Future<void> cancelBooking(

    String bookingId,

  ) async {

    /// ===========================================================
    /// ELIMINAR DOCUMENTO FIREBASE
    /// ===========================================================

    /// deleteBooking():
    /// elimina documento Firestore
    await _service.deleteBooking(

      bookingId,
    );
  }
}