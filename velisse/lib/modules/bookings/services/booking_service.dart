/// ===============================================================
/// IMPORTACIONES
/// ===============================================================

/// Importa Firebase Firestore
///
/// Gracias a esto podemos usar:
/// - FirebaseFirestore
/// - CollectionReference
/// - snapshots()
/// - add()
/// - delete()
/// - where()
/// - get()
import 'package:cloud_firestore/cloud_firestore.dart';


/// Importa el modelo BookingModel
///
/// Este modelo representa:
/// - cómo se guarda una reserva
/// - cómo se lee desde Firebase
/// - cómo se convierte Map ↔ Objeto
import '../models/booking_model.dart';



/// ===============================================================
/// SERVICIO DE RESERVAS
/// ===============================================================

/// Esta clase se encarga de:
/// - conectarse con Firebase
/// - guardar reservas
/// - leer reservas
/// - verificar disponibilidad
/// - obtener profesionales ocupados
/// - eliminar reservas
///
/// Profesionalmente:
/// aquí NO hacemos interfaz.
///
/// SOLO lógica backend.
class BookingService {

  /// =============================================================
  /// REFERENCIA FIREBASE
  /// =============================================================

  /// CollectionReference:
  /// referencia a una colección Firestore
  ///
  /// FirebaseFirestore.instance:
  /// instancia principal Firebase
  ///
  /// collection('reservas'):
  /// colección llamada:
  /// reservas
  ///
  /// En Firebase aparecerá:
  ///
  /// reservas
  ///   ├── documento1
  ///   ├── documento2
  ///   ├── documento3
  final CollectionReference bookingsRef =

      /// Accede a Firebase
      FirebaseFirestore.instance

          /// Accede a colección "reservas"
          .collection('reservas');



  /// =============================================================
  /// CREAR RESERVA
  /// =============================================================

  /// Future<void>
  ///
  /// Future:
  /// porque Firebase tarda tiempo
  ///
  /// void:
  /// porque no devuelve datos
  Future<void> createBooking(

    /// Reserva que recibimos
    BookingModel booking,

  ) async {

    /// ===========================================================
    /// AGREGAR DOCUMENTO FIREBASE
    /// ===========================================================

    /// add():
    /// crea automáticamente un documento
    ///
    /// Firebase genera:
    ///
    /// a82jd92jd92
    ///
    /// como ID único
    ///
    /// booking.toMap():
    /// convierte Flutter → Firebase
    await bookingsRef.add(

      /// Datos de la reserva
      booking.toMap(),

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
  /// required:
  /// obliga a enviar los parámetros
  Future<bool> isTimeBooked({

    /// Fecha de la reserva
    required String fecha,

    /// Hora de la reserva
    required String hora,

    /// Profesional seleccionado
    required String profesional,

  }) async {

    /// ===========================================================
    /// CONSULTA FIREBASE
    /// ===========================================================

    /// query:
    /// guardará el resultado de búsqueda
    final query =

        /// Espera respuesta Firebase
        await bookingsRef

            /// Buscar misma fecha
            .where(
              'fecha',
              isEqualTo: fecha,
            )

            /// Buscar misma hora
            .where(
              'hora',
              isEqualTo: hora,
            )

            /// Buscar mismo profesional
            .where(
              'profesional',
              isEqualTo: profesional,
            )

            /// Ejecutar consulta
            .get();

    /// ===========================================================
    /// VALIDAR RESULTADOS
    /// ===========================================================

    /// query.docs:
    /// lista de documentos encontrados
    ///
    /// isNotEmpty:
    /// true si encontró reservas
    ///
    /// Si existe al menos 1:
    /// significa ocupado
    return query.docs.isNotEmpty;
  }



  /// =============================================================
  /// OBTENER PROFESIONALES OCUPADOS
  /// =============================================================

  /// Retorna lista de profesionales
  /// ocupados en:
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
    /// CONSULTAR FIREBASE
    /// ===========================================================

    /// query:
    /// guardará resultados Firebase
    final query =

        /// Esperar respuesta Firebase
        await bookingsRef

            /// Buscar misma fecha
            .where(
              'fecha',
              isEqualTo: fecha,
            )

            /// Buscar misma hora
            .where(
              'hora',
              isEqualTo: hora,
            )

            /// Ejecutar consulta
            .get();



    /// ===========================================================
    /// EXTRAER PROFESIONALES
    /// ===========================================================

    /// unavailable:
    /// lista profesionales ocupados
    List<String> unavailable =

        /// Recorrer documentos encontrados
        query.docs.map((doc) {

      /// doc['profesional']
      /// obtiene nombre profesional
      return doc['profesional'] as String;

      /// Convertir iterable → lista
    }).toList();



    /// ===========================================================
    /// RETORNAR LISTA
    /// ===========================================================

    /// Devuelve lista ocupados
    return unavailable;
  }



  /// =============================================================
  /// OBTENER RESERVAS REALTIME
  /// =============================================================

  /// Stream<List<BookingModel>>
  ///
  /// Stream:
  /// escucha cambios en tiempo real
  ///
  /// List<BookingModel>:
  /// devuelve lista de reservas
  ///
  /// Cada vez que Firebase cambie:
  /// - crear
  /// - eliminar
  /// - editar
  ///
  /// la UI se actualizará automáticamente
  Stream<List<BookingModel>> getBookings() {

    /// snapshots():
    /// escucha realtime Firestore
    return bookingsRef.snapshots().map(

      /// snapshot:
      /// contiene TODOS los documentos
      (snapshot) {

        /// snapshot.docs:
        /// lista documentos Firebase
        ///
        /// map():
        /// transforma documentos Firebase
        /// en BookingModel Flutter
        return snapshot.docs.map(

          /// doc:
          /// documento individual Firebase
          (doc) {

            /// ===================================================
            /// CONVERTIR FIREBASE → FLUTTER
            /// ===================================================

            return BookingModel.fromMap(

              /// data():
              /// obtiene datos del documento
              ///
              /// as Map<String, dynamic>
              /// convierte al tipo correcto
              doc.data() as Map<String, dynamic>,

              /// doc.id:
              /// ID documento Firebase
              ///
              /// NECESARIO para:
              /// - eliminar
              /// - editar
              doc.id,

            );

          },

          /// Convierte iterable → lista
        ).toList();
      },
    );
  }



  /// =============================================================
  /// ELIMINAR RESERVA
  /// =============================================================

  /// bookingId:
  /// ID documento Firebase
  ///
  /// Ejemplo:
  ///
  /// ajs82js92jd
  Future<void> deleteBooking(

    /// ID del documento
    String bookingId,

  ) async {

    /// ===========================================================
    /// ELIMINAR DOCUMENTO FIREBASE
    /// ===========================================================

    await bookingsRef

        /// Buscar documento específico
        .doc(bookingId)

        /// Eliminar documento
        .delete();
  }
}