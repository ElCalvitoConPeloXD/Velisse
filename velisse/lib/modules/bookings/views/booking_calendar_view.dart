/// ===============================================================
/// IMPORTACIONES
/// ===============================================================
library;

/// Importa widgets Material Design
///
/// Gracias a esto podemos usar:
/// - Scaffold
/// - AppBar
/// - Text
/// - ElevatedButton
/// - SnackBar
/// - DropdownButtonFormField
/// - etc
import 'package:flutter/material.dart';


/// Importa controller de reservas
///
/// El controller se encarga de:
/// - crear reservas
/// - verificar disponibilidad
/// - conectarse con Firebase
/// - obtener profesionales ocupados
import '../controllers/booking_controller.dart';



/// ===============================================================
/// PANTALLA CREAR RESERVA
/// ===============================================================

/// StatefulWidget:
/// porque la pantalla cambia dinámicamente
///
/// Cambia:
/// - fecha
/// - hora
/// - servicio
/// - profesional
class BookingCalendarView extends StatefulWidget {

  /// Constructor
  const BookingCalendarView({super.key});

  @override
  State<BookingCalendarView> createState() =>

      /// Retorna estado de la pantalla
      _BookingCalendarViewState();
}



/// ===============================================================
/// ESTADO DE LA PANTALLA
/// ===============================================================

class _BookingCalendarViewState
    extends State<BookingCalendarView> {

  /// =============================================================
  /// CONTROLLER
  /// =============================================================

  /// Instancia controller
  ///
  /// Gracias a esto podemos usar:
  /// - createBooking()
  /// - isTimeBooked()
  /// - getUnavailableProfessionals()
  final BookingController _controller =

      /// Crear instancia controller
      BookingController();



  /// =============================================================
  /// VARIABLES
  /// =============================================================

  /// Fecha seleccionada
  ///
  /// DateTime.now():
  /// fecha actual del dispositivo
  DateTime selectedDate = DateTime.now();

  /// Hora seleccionada
  String selectedHour = '';

  /// Servicio seleccionado
  String selectedService = '';

  /// Profesional seleccionado
  String selectedProfessional = '';



  /// =============================================================
  /// PROFESIONALES OCUPADOS
  /// =============================================================

  /// Lista que guardará:
  /// - Maria
  /// - Amanda
  /// - Sofia
  ///
  /// dependiendo de la fecha/hora
  List<String> unavailableProfessionals = [];



  /// =============================================================
  /// LISTA HORAS
  /// =============================================================

  /// Horarios disponibles
  final List<String> hours = [

    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '2:00 PM',
    '3:00 PM',
  ];



  /// =============================================================
  /// LISTA SERVICIOS
  /// =============================================================

  /// Servicios disponibles
  final List<String> services = [

    'Pedicura',
    'Manicura',
    'Corte de cabello',
    'Limpieza facial',
  ];



  /// =============================================================
  /// LISTA PROFESIONALES
  /// =============================================================

  /// Profesionales disponibles
  final List<String> professionals = [

    'Amanda',
    'Maria',
    'Sofia',
  ];



  /// =============================================================
  /// CARGAR PROFESIONALES OCUPADOS
  /// =============================================================

  /// Consulta Firebase
  /// y obtiene profesionales ocupados
  Future<void> loadUnavailableProfessionals() async {

    /// ===========================================================
    /// VALIDAR HORA
    /// ===========================================================

    /// Si no hay hora seleccionada
    if (selectedHour.isEmpty) {

      /// Limpiar lista
      unavailableProfessionals = [];

      /// Detener función
      return;
    }



    /// ===========================================================
    /// CONSULTAR FIREBASE
    /// ===========================================================

    /// unavailable:
    /// lista que devuelve Firebase
    final unavailable =

        /// Esperar respuesta Firebase
        await _controller.getUnavailableProfessionals(

      /// Fecha seleccionada
      fecha:
          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',

      /// Hora seleccionada
      hora: selectedHour,
    );



    /// ===========================================================
    /// ACTUALIZAR INTERFAZ
    /// ===========================================================

    /// Refrescar UI
    setState(() {

      /// Guardar lista ocupados
      unavailableProfessionals = unavailable;



      /// Si el profesional actual
      /// ahora está ocupado
      if (unavailableProfessionals
          .contains(selectedProfessional)) {

        /// Limpiar selección
        selectedProfessional = '';
      }
    });
  }



  /// =============================================================
  /// MÉTODO CREAR RESERVA
  /// =============================================================

  /// Método que:
  /// - valida campos
  /// - verifica disponibilidad
  /// - guarda reserva
  /// - limpia formulario
  Future<void> createBooking() async {

    /// ===========================================================
    /// VALIDAR CAMPOS
    /// ===========================================================

    /// Si algún campo está vacío
    if (selectedHour.isEmpty ||
        selectedService.isEmpty ||
        selectedProfessional.isEmpty) {

      /// Mostrar mensaje error
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            'Completa todos los campos',
          ),
        ),
      );

      /// Detener función
      return;
    }



    /// ===========================================================
    /// VERIFICAR DISPONIBILIDAD
    /// ===========================================================

    /// alreadyBooked:
    /// guardará true o false
    final alreadyBooked =

        /// Esperar respuesta Firebase
        await _controller.isTimeBooked(

      /// Fecha seleccionada convertida a texto
      fecha:
          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',

      /// Hora elegida
      hora: selectedHour,

      /// Profesional elegido
      profesional: selectedProfessional,
    );



    /// ===========================================================
    /// SI YA ESTÁ OCUPADO
    /// ===========================================================

    /// Si ya existe reserva
    if (alreadyBooked) {

      /// Mostrar mensaje
      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          backgroundColor: Colors.red,

          content: Text(

            '$selectedProfessional ya tiene una reserva a esa hora',
          ),
        ),
      );

      /// Detener función
      return;
    }



    /// ===========================================================
    /// GUARDAR EN FIREBASE
    /// ===========================================================

    /// Crear reserva
    await _controller.createBooking(

      /// Nombre negocio
      negocio: 'Glow Nails',

      /// Servicio elegido
      servicio: selectedService,

      /// Profesional elegido
      profesional: selectedProfessional,

      /// Fecha convertida a texto
      fecha:
          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',

      /// Hora elegida
      hora: selectedHour,
    );



    /// ===========================================================
    /// MENSAJE ÉXITO
    /// ===========================================================

    /// Mostrar mensaje éxito
    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        backgroundColor: Colors.green,

        content: Text(
          'Reserva creada correctamente',
        ),
      ),
    );



    /// ===========================================================
    /// LIMPIAR FORMULARIO
    /// ===========================================================

    /// Actualizar interfaz
    setState(() {

      /// Volver fecha actual
      selectedDate = DateTime.now();

      /// Limpiar hora
      selectedHour = '';

      /// Limpiar servicio
      selectedService = '';

      /// Limpiar profesional
      selectedProfessional = '';

      /// Limpiar ocupados
      unavailableProfessionals = [];
    });



    /// ===========================================================
    /// NAVEGACIÓN
    /// ===========================================================

    /// Temporalmente comentado
    /// para evitar pantalla negra
    // Navigator.pop(context);
  }



  /// =============================================================
  /// BUILD
  /// =============================================================

  @override
  Widget build(BuildContext context) {

    /// Scaffold:
    /// estructura visual principal
    return Scaffold(

      /// Color fondo pantalla
      backgroundColor: const Color(0xFFF2ECF9),



      /// =========================================================
      /// APPBAR
      /// =========================================================

      appBar: AppBar(

        /// Color barra superior
        backgroundColor: const Color(0xFFF2ECF9),

        /// Quitar sombra
        elevation: 0,

        /// Título pantalla
        title: const Text(

          'Crear Reserva',

          style: TextStyle(

            /// Color texto
            color: Colors.black,

            /// Texto en negrita
            fontWeight: FontWeight.bold,
          ),
        ),
      ),



      /// =========================================================
      /// BODY
      /// =========================================================

      body: SingleChildScrollView(

        /// Espaciado general
        padding: const EdgeInsets.all(20),

        child: Column(

          /// Alinear elementos izquierda
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// ===================================================
            /// TEXTO FECHA
            /// ===================================================

            const Text(

              'Selecciona fecha',

              style: TextStyle(

                fontSize: 18,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),



            /// ===================================================
            /// BOTÓN FECHA
            /// ===================================================

            ElevatedButton(

              /// Acción botón
              onPressed: () async {

                /// Abrir calendario
                final pickedDate =
                    await showDatePicker(

                  /// Contexto actual
                  context: context,

                  /// Fecha mínima
                  firstDate: DateTime.now(),

                  /// Fecha máxima
                  lastDate: DateTime(2030),

                  /// Fecha inicial
                  initialDate: selectedDate,
                );

                /// Si eligió fecha
                if (pickedDate != null) {

                  /// Actualizar interfaz
                  setState(() {

                    /// Guardar fecha
                    selectedDate = pickedDate;
                  });

                  /// Cargar ocupados
                  loadUnavailableProfessionals();
                }
              },

              /// Texto botón
              child: Text(

                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              ),
            ),

            const SizedBox(height: 30),



            /// ===================================================
            /// TEXTO HORAS
            /// ===================================================

            const Text(

              'Selecciona hora',

              style: TextStyle(

                fontSize: 18,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),



            /// ===================================================
            /// WRAP HORAS
            /// ===================================================

            Wrap(

              /// Espacio horizontal
              spacing: 10,

              /// Recorrer horas
              children: hours.map((hour) {

                /// Verificar seleccionada
                final selected =
                    selectedHour == hour;

                return ChoiceChip(

                  /// Texto chip
                  label: Text(hour),

                  /// Estado seleccionado
                  selected: selected,

                  /// Acción seleccionar
                  onSelected: (_) {

                    /// Actualizar interfaz
                    setState(() {

                      /// Guardar hora
                      selectedHour = hour;
                    });

                    /// Consultar ocupados
                    loadUnavailableProfessionals();
                  },
                );

              }).toList(),
            ),

            const SizedBox(height: 30),



            /// ===================================================
            /// TEXTO SERVICIO
            /// ===================================================

            const Text(

              'Selecciona servicio',

              style: TextStyle(

                fontSize: 18,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),



            /// ===================================================
            /// DROPDOWN SERVICIOS
            /// ===================================================

            DropdownButtonFormField<String>(

              /// Valor actual seleccionado
              initialValue: selectedService.isEmpty
                  ? null
                  : selectedService,

              /// Opciones dropdown
              items: services.map((service) {

                return DropdownMenuItem(

                  /// Valor opción
                  value: service,

                  /// Texto visible
                  child: Text(service),
                );

              }).toList(),

              /// Acción cambiar opción
              onChanged: (value) {

                /// Actualizar interfaz
                setState(() {

                  /// Guardar servicio
                  selectedService = value!;
                });
              },
            ),

            const SizedBox(height: 30),



            /// ===================================================
            /// TEXTO PROFESIONAL
            /// ===================================================

            const Text(

              'Selecciona profesional',

              style: TextStyle(

                fontSize: 18,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),



            /// ===================================================
            /// DROPDOWN PROFESIONALES
            /// ===================================================

            DropdownButtonFormField<String>(

              /// Valor seleccionado
              initialValue: selectedProfessional.isEmpty
                  ? null
                  : selectedProfessional,

              /// Lista opciones
              items:
                  professionals.map((professional) {

                /// Verificar si está ocupado
                final isUnavailable =
                    unavailableProfessionals
                        .contains(professional);

                return DropdownMenuItem(

                  /// Valor opción
                  value: professional,

                  /// Texto visible
                  child: Row(

                    children: [

                      /// Nombre profesional
                      Text(professional),

                      /// Espacio
                      const SizedBox(width: 10),

                      /// Mostrar badge ocupado
                      if (isUnavailable)

                        Container(

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal: 8,
                            vertical: 4,
                          ),

                          decoration: BoxDecoration(

                            color: Colors.red.shade100,

                            borderRadius:
                                BorderRadius.circular(20),
                          ),

                          child: const Text(

                            'Ocupado',

                            style: TextStyle(

                              color: Colors.red,

                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                );

              }).toList(),

              /// Acción cambiar
              onChanged: (value) {

                /// Si está ocupado
                if (unavailableProfessionals
                    .contains(value)) {

                  return;
                }

                /// Actualizar interfaz
                setState(() {

                  /// Guardar profesional
                  selectedProfessional = value!;
                });
              },
            ),

            const SizedBox(height: 40),



            /// ===================================================
            /// BOTÓN CREAR RESERVA
            /// ===================================================

            SizedBox(

              /// Ocupar ancho completo
              width: double.infinity,

              child: ElevatedButton(

                /// Acción botón
                onPressed: createBooking,

                /// Texto botón
                child: const Text(
                  'Crear Reserva',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}