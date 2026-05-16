/// =======================================================
/// MODELO PROFESIONAL DE RESERVA
/// =======================================================
///
/// Este modelo representa exactamente cómo se guarda
/// una reserva dentro de Firebase Firestore.
///
/// También permite:
/// - convertir Firebase -> Dart
/// - convertir Dart -> Firebase
///
/// =======================================================
library;

class BookingModel {
  /// ID único del documento en Firebase
  final String id;

  /// Nombre del negocio
  final String businessName;

  /// Nombre del servicio
  final String serviceName;

  /// Imagen del negocio o servicio
  final String imageUrl;

  /// Fecha de la reserva
  final DateTime bookingDate;

  /// Estado de la reserva:
  /// upcoming | completed | cancelled
  final String status;

  BookingModel({
    required this.id,
    required this.businessName,
    required this.serviceName,
    required this.imageUrl,
    required this.bookingDate,
    required this.status,
  });

  /// =======================================================
  /// CONVERTIR FIREBASE -> OBJETO DART
  /// =======================================================
  factory BookingModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return BookingModel(
      id: documentId,
      businessName: map['businessName'] ?? '',
      serviceName: map['serviceName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      bookingDate: DateTime.parse(map['bookingDate']),
      status: map['status'] ?? '',
    );
  }

  /// =======================================================
  /// CONVERTIR OBJETO DART -> FIREBASE
  /// =======================================================
  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'serviceName': serviceName,
      'imageUrl': imageUrl,
      'bookingDate': bookingDate.toIso8601String(),
      'status': status,
    };
  }
}