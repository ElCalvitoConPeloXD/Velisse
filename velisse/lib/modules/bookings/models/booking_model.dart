// Modelo de una reserva
// Representa cómo se guarda la información
// en Firebase y cómo se usa en Flutter

class BookingModel {

  // ID del documento Firebase
  final String id;

  // Nombre del negocio
  final String negocio;

  // Servicio elegido
  final String servicio;

  // Profesional seleccionado
  final String profesional;

  // Fecha reserva
  final String fecha;

  // Hora reserva
  final String hora;

  // Constructor
  BookingModel({
    required this.id,
    required this.negocio,
    required this.servicio,
    required this.profesional,
    required this.fecha,
    required this.hora,
  });

  /// Convertir Firebase → Flutter
  factory BookingModel.fromMap(Map<String, dynamic> map, String docId) {

    return BookingModel(
      id: docId,
      negocio: map['negocio'] ?? '',
      servicio: map['servicio'] ?? '',
      profesional: map['profesional'] ?? '',
      fecha: map['fecha'] ?? '',
      hora: map['hora'] ?? '',
    );
  }

  /// Convertir Flutter → Firebase
  Map<String, dynamic> toMap() {

    return {
      'negocio': negocio,
      'servicio': servicio,
      'profesional': profesional,
      'fecha': fecha,
      'hora': hora,
    };
  }
}