import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/booking_model.dart';

/// =======================================================
/// REPOSITORY PROFESIONAL DE RESERVAS
/// =======================================================
///
/// Este archivo es el encargado de:
///
/// - Crear reservas
/// - Obtener reservas
/// - Escuchar cambios realtime
/// - Cancelar reservas
///
/// La UI NUNCA debe acceder directamente a Firebase.
///
/// =======================================================

class BookingRepository {
  /// =======================================================
  /// REFERENCIAS FIREBASE
  /// =======================================================

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// =======================================================
  /// OBTENER RESERVAS DEL USUARIO ACTUAL
  /// =======================================================
  ///
  /// Stream:
  /// escucha cambios en tiempo real desde Firebase.
  ///
  Stream<List<BookingModel>> getUserBookings() {
    /// Usuario autenticado actualmente
    final currentUser = _auth.currentUser;

    /// Si no hay usuario logueado
    if (currentUser == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('bookings')

        /// Solo reservas del usuario actual
        .where('userId', isEqualTo: currentUser.uid)

        /// Ordenar por fecha
        .orderBy('bookingDate', descending: false)

        /// Escuchar cambios realtime
        .snapshots()

        /// Convertir Firebase -> Lista Dart
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return BookingModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }

  /// =======================================================
  /// CREAR RESERVA
  /// =======================================================
  Future<void> createBooking({
    required String businessId,
    required String serviceId,
    required String businessName,
    required String serviceName,
    required String imageUrl,
    required DateTime bookingDate,
  }) async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) return;

    await _firestore.collection('bookings').add({
      'userId': currentUser.uid,
      'businessId': businessId,
      'serviceId': serviceId,
      'businessName': businessName,
      'serviceName': serviceName,
      'imageUrl': imageUrl,

      /// Fecha de la reserva
      'bookingDate': bookingDate.toIso8601String(),

      /// Estado inicial
      'status': 'upcoming',

      /// Fecha creación
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// =======================================================
  /// CANCELAR RESERVA
  /// =======================================================
  Future<void> cancelBooking(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).update({
      'status': 'cancelled',
    });
  }
}