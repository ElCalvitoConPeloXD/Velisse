/// ===============================================================
/// IMPORTACIONES
/// ===============================================================

/// Widgets Material Design
import 'package:flutter/material.dart';


/// Modelo NUEVO de reservas
///
/// IMPORTANTE:
/// usamos SOLO este modelo
///
/// modules/bookings/models/booking_model.dart
///
/// Ya NO usamos:
/// data/models/booking_model.dart
import 'package:velisse/modules/bookings/models/booking_model.dart';


/// ===============================================================
/// TARJETA DE RESERVA
/// ===============================================================
///
/// Widget reutilizable que muestra:
///
/// - negocio
/// - servicio
/// - profesional
/// - fecha
/// - hora
/// - botón cancelar
///
/// ===============================================================

class BookingCard extends StatelessWidget {

  /// =============================================================
  /// MODELO RESERVA
  /// =============================================================

  /// Reserva recibida
  final BookingModel booking;

  /// =============================================================
  /// ACCIÓN CANCELAR
  /// =============================================================

  /// Función que se ejecuta
  /// al presionar cancelar
  final VoidCallback onCancel;


  /// =============================================================
  /// CONSTRUCTOR
  /// =============================================================

  const BookingCard({

    super.key,

    required this.booking,

    required this.onCancel,
  });


  /// =============================================================
  /// BUILD
  /// =============================================================

  @override
  Widget build(BuildContext context) {

    return Container(

      /// Margen inferior entre cards
      margin: const EdgeInsets.only(bottom: 20),

      /// Espaciado interno
      padding: const EdgeInsets.all(16),

      /// Diseño visual
      decoration: BoxDecoration(

        color: const Color(0xFFF4EDF7),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      /// =========================================================
      /// CONTENIDO
      /// =========================================================

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          /// =====================================================
          /// FECHA
          /// =====================================================

          Text(

            /// Fecha reserva
            booking.fecha,

            style: const TextStyle(

              fontWeight: FontWeight.w600,

              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 14),

          /// =====================================================
          /// ROW PRINCIPAL
          /// =====================================================

          Row(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              /// =================================================
              /// IMAGEN PLACEHOLDER
              /// =================================================

              /// Temporalmente usamos un contenedor
              ///
              /// Más adelante:
              /// Firebase Storage
              /// imágenes reales
              Container(

                width: 100,

                height: 100,

                decoration: BoxDecoration(

                  color: Colors.purple.shade100,

                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: const Icon(

                  Icons.spa,

                  size: 40,

                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 16),

              /// =================================================
              /// INFORMACIÓN
              /// =================================================

              Expanded(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    /// =============================================
                    /// NEGOCIO
                    /// =============================================

                    Text(

                      booking.negocio,

                      style: const TextStyle(

                        fontSize: 20,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// =============================================
                    /// SERVICIO
                    /// =============================================

                    Text(

                      booking.servicio,

                      style: const TextStyle(

                        fontSize: 16,

                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// =============================================
                    /// PROFESIONAL
                    /// =============================================

                    Text(

                      'Profesional: ${booking.profesional}',

                      style: const TextStyle(

                        fontSize: 15,

                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// =============================================
                    /// HORA
                    /// =============================================

                    Text(

                      'Hora: ${booking.hora}',

                      style: const TextStyle(

                        fontSize: 15,

                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// =============================================
                    /// BOTÓN CANCELAR
                    /// =============================================

                    Align(

                      alignment:
                          Alignment.centerRight,

                      child: ElevatedButton(

                        /// Acción cancelar
                        onPressed: onCancel,

                        /// Estilo botón
                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              const Color(0xFF7E57C2),

                          foregroundColor:
                              Colors.white,

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(30),
                          ),

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal: 24,

                            vertical: 12,
                          ),
                        ),

                        child: const Text(
                          'Cancelar',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}