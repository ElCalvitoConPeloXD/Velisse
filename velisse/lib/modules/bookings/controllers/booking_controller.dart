/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
library;

/// Importa el modelo BookingModel
///
/// Este modelo representa:
/// - una reserva
/// - los datos Firebase
/// - la estructura de información
///
/// Gracias a esto podemos:
/// - crear objetos BookingModel
/// - convertir datos
/// - enviar reservas al service
import '../models/booking_model.dart';


/// Importa el servicio Firebase
///
/// El service se encarga de:
/// - guardar reservas
/// - leer reservas
/// - eliminar reservas
/// - verificar disponibilidad
/// - obtener profesionales ocupados
///
/// Profesionalmente:
/// el controller usa el service
/// para NO mezclar UI con backend
import '../services/booking_service.dart';



/// ===============================================================
/// CONTROLADOR DE RESERVAS
/// ===============================================================

/// Esta clase se encarga de:
/// - crear reservas
/// - validar disponibilidad
/// - obtener profesionales ocupados
///
/// Profesionalmente:
/// el controller conecta:
///
/// UI ↔ Service ↔ Firebase
///
/// Este controller pertenece
/// al módulo:
/// bookings
class BookingController {

  /// =============================================================
  /// SERVICIO FIREBASE
  /// =============================================================

  /// Instancia del service
  ///
  /// Gracias a esto podemos usar:
  /// - _service.createBooking()
  /// - _service.isTimeBooked()
  /// - _service.getUnavailableProfessionals()
  final BookingService _service =

      /// Crear instancia service
      BookingService();



  /// =============================================================
  /// CREAR RESERVA
  /// =============================================================

  /// Future<void>
  ///
  /// Future:
  /// porque Firebase tarda tiempo
  ///
  /// void:
  /// porque no retorna datos
  Future<void> createBooking({

    /// Nombre del negocio
    required String negocio,

    /// Servicio seleccionado
    required String servicio,

    /// Profesional elegido
    required String profesional,

    /// Fecha seleccionada
    required String fecha,

    /// Hora elegida
    required String hora,

  }) async {

    /// ===========================================================
    /// CREAR OBJETO RESERVA
    /// ===========================================================

    /// Creamos el modelo BookingModel
    ///
    /// Este objeto representa
    /// toda la reserva completa
    BookingModel booking = BookingModel(

      /// ID vacío
      ///
      /// Firebase generará
      /// automáticamente el ID
      id: '',

      /// Nombre negocio
      negocio: negocio,

      /// Servicio elegido
      servicio: servicio,

      /// Profesional elegido
      profesional: profesional,

      /// Fecha seleccionada
      fecha: fecha,

      /// Hora elegida
      hora: hora,
    );



    /// ===========================================================
    /// GUARDAR EN FIREBASE
    /// ===========================================================

    /// await:
    /// espera hasta terminar
    ///
    /// createBooking():
    /// guarda documento en Firestore
    await _service.createBooking(

      /// Enviar reserva al service
      booking,

    );
  }



  /// =============================================================
  /// VERIFICAR DISPONIBILIDAD
  /// =============================================================

  /// Retorna:
  ///
  /// true  = horario ocupado
  /// false = disponible
  ///
  /// Future<bool>:
  /// porque Firebase tarda tiempo
  /// y devuelve true o false
  Future<bool> isTimeBooked({

    /// Fecha seleccionada
    required String fecha,

    /// Hora seleccionada
    required String hora,

    /// Profesional elegido
    required String profesional,

  }) async {

    /// ===========================================================
    /// LLAMAR AL SERVICE
    /// ===========================================================

    /// return:
    /// devuelve el resultado
    ///
    /// await:
    /// espera respuesta Firebase
    ///
    /// _service.isTimeBooked():
    /// consulta Firestore
    return await _service.isTimeBooked(

      /// Fecha enviada
      fecha: fecha,

      /// Hora enviada
      hora: hora,

      /// Profesional enviado
      profesional: profesional,
    );
  }



  /// =============================================================
  /// OBTENER PROFESIONALES OCUPADOS
  /// =============================================================

  /// Retorna lista de profesionales
  /// ocupados según:
  /// - fecha
  /// - hora
  ///
  /// Ejemplo retorno:
  ///
  /// [
  ///   'Maria',
  ///   'Amanda'
  /// ]
  Future<List<String>> getUnavailableProfessionals({

    /// Fecha seleccionada
    required String fecha,

    /// Hora seleccionada
    required String hora,

  }) async {

    /// ===========================================================
    /// LLAMAR AL SERVICE
    /// ===========================================================

    /// return:
    /// devuelve lista de profesionales
    ///
    /// await:
    /// espera respuesta Firebase
    return await _service.getUnavailableProfessionals(

      /// Fecha enviada
      fecha: fecha,

      /// Hora enviada
      hora: hora,
    );
  }
}