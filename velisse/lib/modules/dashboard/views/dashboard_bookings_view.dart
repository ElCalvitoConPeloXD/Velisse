/// ===============================================================
/// IMPORTACIONES
/// ===============================================================

/// Importa widgets Material Design
import 'package:flutter/material.dart';


/// Importa controller dashboard
///
/// Este controller maneja:
/// - obtener reservas
/// - cancelar reservas
import '../controllers/dashboard_controller.dart';


/// Importa card reutilizable
///
/// Esta card muestra:
/// - negocio
/// - servicio
/// - fecha
/// - hora
/// - botón cancelar
import '../widgets/booking_card.dart';



/// ===============================================================
/// PANTALLA DASHBOARD RESERVAS
/// ===============================================================

/// StatefulWidget:
/// porque necesitamos:
/// - cambiar tabs
/// - cambiar filtros
/// - actualizar UI dinámicamente
class DashboardBookingsView extends StatefulWidget {

  /// Constructor
  const DashboardBookingsView({super.key});

  @override
  State<DashboardBookingsView> createState() =>

      /// Crear estado
      _DashboardBookingsViewState();
}



/// ===============================================================
/// ESTADO DASHBOARD
/// ===============================================================

class _DashboardBookingsViewState
    extends State<DashboardBookingsView> {

  /// =============================================================
  /// CONTROLLER
  /// =============================================================

  /// Instancia controller
  final DashboardController _controller =

      /// Crear controller
      DashboardController();



  /// =============================================================
  /// TOGGLE PRÓXIMAS / PASADAS
  /// =============================================================

  /// true:
  /// mostrar próximas
  ///
  /// false:
  /// mostrar pasadas
  bool showUpcoming = true;



  /// =============================================================
  /// FILTRO PRINCIPAL
  /// =============================================================

  /// Puede ser:
  /// - Todas
  /// - Mes
  /// - Año
  String selectedMainFilter = 'Todas';



  /// =============================================================
  /// FILTRO SECUNDARIO
  /// =============================================================

  /// Guardará:
  /// - Enero
  /// - Febrero
  /// - 2026
  /// - etc
  String selectedSubFilter = '';



  /// =============================================================
  /// LISTA FILTROS PRINCIPALES
  /// =============================================================

  final List<String> mainFilters = [

    'Todas',
    'Mes',
    'Año',
  ];



  /// =============================================================
  /// LISTA MESES
  /// =============================================================

  final List<String> months = [

    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];



  /// =============================================================
  /// LISTA AÑOS
  /// =============================================================

  final List<String> years = [

    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
  ];



  /// =============================================================
  /// BUILD
  /// =============================================================

  @override
  Widget build(BuildContext context) {

    /// Scaffold:
    /// estructura principal
    return Scaffold(

      /// =========================================================
      /// COLOR FONDO
      /// =========================================================

      backgroundColor: const Color(0xFFF2ECF9),



      /// =========================================================
      /// APPBAR
      /// =========================================================

      appBar: AppBar(

        /// Color fondo
        backgroundColor: const Color(0xFFF2ECF9),

        /// Eliminar sombra
        elevation: 0,

        /// Título izquierda
        centerTitle: false,



        /// =======================================================
        /// TÍTULO
        /// =======================================================

        title: const Text(

          'Tus Reservas',

          style: TextStyle(

            /// Color texto
            color: Colors.black,

            /// Tamaño
            fontSize: 28,

            /// Negrilla
            fontWeight: FontWeight.bold,
          ),
        ),
      ),



      /// =========================================================
      /// BODY
      /// =========================================================

      body: Padding(

        /// Padding general
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            /// ===================================================
            /// TOGGLE PRÓXIMAS / PASADAS
            /// ===================================================

            Container(

              /// Padding interno
              padding: const EdgeInsets.all(4),

              /// Decoración barra
              decoration: BoxDecoration(

                /// Color fondo
                color: const Color(0xFFD7CFDF),

                /// Bordes redondeados
                borderRadius:
                    BorderRadius.circular(30),
              ),

              child: Row(

                children: [

                  /// =============================================
                  /// BOTÓN PRÓXIMAS
                  /// =============================================

                  Expanded(

                    child: GestureDetector(

                      onTap: () {

                        /// Actualizar interfaz
                        setState(() {

                          /// Mostrar próximas
                          showUpcoming = true;
                        });
                      },

                      child: Container(

                        /// Padding
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 12,
                        ),

                        /// Decoración
                        decoration: BoxDecoration(

                          /// Color dinámico
                          color: showUpcoming
                              ? Colors.white
                              : Colors.transparent,

                          /// Bordes redondeados
                          borderRadius:
                              BorderRadius.circular(25),
                        ),

                        child: Center(

                          child: Text(

                            'Próximas',

                            style: TextStyle(

                              /// Color dinámico
                              color: showUpcoming
                                  ? Colors.black
                                  : Colors.black54,

                              /// Negrilla
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),



                  /// =============================================
                  /// BOTÓN PASADAS
                  /// =============================================

                  Expanded(

                    child: GestureDetector(

                      onTap: () {

                        /// Actualizar UI
                        setState(() {

                          /// Mostrar pasadas
                          showUpcoming = false;
                        });
                      },

                      child: Container(

                        /// Padding
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 12,
                        ),

                        /// Decoración
                        decoration: BoxDecoration(

                          /// Color dinámico
                          color: !showUpcoming
                              ? Colors.white
                              : Colors.transparent,

                          /// Bordes redondeados
                          borderRadius:
                              BorderRadius.circular(25),
                        ),

                        child: Center(

                          child: Text(

                            'Pasadas',

                            style: TextStyle(

                              /// Color dinámico
                              color: !showUpcoming
                                  ? Colors.black
                                  : Colors.black54,

                              /// Negrilla
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),



            /// ===================================================
            /// FILTRO PRINCIPAL
            /// ===================================================

            DropdownButtonFormField<String>(

              /// Valor actual
              value: selectedMainFilter,

              /// Decoración
              decoration: InputDecoration(

                /// Label
                labelText: 'Filtrar por',

                /// Fondo blanco
                filled: true,

                /// Bordes
                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(18),
                ),
              ),

              /// Opciones
              items: mainFilters.map((filter) {

                return DropdownMenuItem(

                  /// Valor
                  value: filter,

                  /// Texto visible
                  child: Text(filter),
                );

              }).toList(),

              /// Cambiar filtro
              onChanged: (value) {

                setState(() {

                  /// Guardar filtro principal
                  selectedMainFilter = value!;

                  /// Reiniciar subfiltro
                  selectedSubFilter = '';
                });
              },
            ),


            /// Espacio
            const SizedBox(height: 15),



            /// ===================================================
            /// FILTRO SECUNDARIO MES
            /// ===================================================

            if (selectedMainFilter == 'Mes')

              DropdownButtonFormField<String>(

                /// Valor actual
                value: selectedSubFilter.isEmpty
                    ? null
                    : selectedSubFilter,

                /// Decoración
                decoration: InputDecoration(

                  /// Label
                  labelText: 'Selecciona mes',

                  /// Fondo blanco
                  filled: true,

                  /// Bordes
                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                ),

                /// Opciones meses
                items: months.map((month) {

                  return DropdownMenuItem(

                    /// Valor
                    value: month,

                    /// Texto
                    child: Text(month),
                  );

                }).toList(),

                /// Cambiar mes
                onChanged: (value) {

                  setState(() {

                    /// Guardar mes
                    selectedSubFilter = value!;
                  });
                },
              ),



            /// ===================================================
            /// FILTRO SECUNDARIO AÑO
            /// ===================================================

            if (selectedMainFilter == 'Año')

              DropdownButtonFormField<String>(

                /// Valor actual
                value: selectedSubFilter.isEmpty
                    ? null
                    : selectedSubFilter,

                /// Decoración
                decoration: InputDecoration(

                  /// Label
                  labelText: 'Selecciona año',

                  /// Fondo blanco
                  filled: true,

                  /// Bordes
                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                ),

                /// Lista años
                items: years.map((year) {

                  return DropdownMenuItem(

                    /// Valor
                    value: year,

                    /// Texto visible
                    child: Text(year),
                  );

                }).toList(),

                /// Cambiar año
                onChanged: (value) {

                  setState(() {

                    /// Guardar año
                    selectedSubFilter = value!;
                  });
                },
              ),

            const SizedBox(height: 20),



            /// ===================================================
            /// STREAMBUILDER
            /// ===================================================

            Expanded(

              child: StreamBuilder(

                /// Stream realtime Firebase
                stream: _controller.getBookings(),

                builder: (context, snapshot) {

                  /// ===============================================
                  /// LOADING
                  /// ===============================================

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {

                    return const Center(

                      child:
                          CircularProgressIndicator(),
                    );
                  }



                  /// ===============================================
                  /// ERROR
                  /// ===============================================

                  if (snapshot.hasError) {

                    return const Center(

                      child: Text(
                        'Ocurrió un error',
                      ),
                    );
                  }



                  /// ===============================================
                  /// LISTA RESERVAS
                  /// ===============================================

                  final bookings =
                      snapshot.data ?? [];



                  /// ===============================================
                  /// FECHA ACTUAL
                  /// ===============================================

                  final now = DateTime.now();



                  /// ===============================================
                  /// FILTRAR RESERVAS
                  /// ===============================================

                  final filteredBookings =
                      bookings.where((booking) {

                    /// =============================================
                    /// CONVERTIR FECHA
                    /// =============================================

                    final parts =
                        booking.fecha.split('/');

                    final bookingDate = DateTime(

                      int.parse(parts[2]),
                      int.parse(parts[1]),
                      int.parse(parts[0]),
                    );



                    /// =============================================
                    /// VALIDAR PRÓXIMAS / PASADAS
                    /// =============================================

                    bool passesUpcomingFilter;

                    if (showUpcoming) {

                      passesUpcomingFilter =
                          bookingDate.isAfter(

                            DateTime(
                              now.year,
                              now.month,
                              now.day,
                            ),
                          ) ||
                          bookingDate ==
                              DateTime(
                                now.year,
                                now.month,
                                now.day,
                              );

                    } else {

                      passesUpcomingFilter =
                          bookingDate.isBefore(

                        DateTime(
                          now.year,
                          now.month,
                          now.day,
                        ),
                      );
                    }



                    /// =============================================
                    /// FILTRO TODAS
                    /// =============================================

                    if (selectedMainFilter ==
                        'Todas') {

                      return passesUpcomingFilter;
                    }



                    /// =============================================
                    /// FILTRO MES
                    /// =============================================

                    if (selectedMainFilter ==
                            'Mes' &&
                        selectedSubFilter.isNotEmpty) {

                      /// Obtener índice mes
                      final selectedMonthIndex =
                          months.indexOf(
                                selectedSubFilter,
                              ) +
                              1;

                      return passesUpcomingFilter &&
                          bookingDate.month ==
                              selectedMonthIndex;
                    }



                    /// =============================================
                    /// FILTRO AÑO
                    /// =============================================

                    if (selectedMainFilter ==
                            'Año' &&
                        selectedSubFilter.isNotEmpty) {

                      return passesUpcomingFilter &&
                          bookingDate.year ==
                              int.parse(
                                selectedSubFilter,
                              );
                    }



                    return passesUpcomingFilter;

                  }).toList();



                  /// ===============================================
                  /// ORDENAR RESERVAS
                  /// ===============================================

                  filteredBookings.sort((a, b) {

                    /// Fecha A
                    final partsA =
                        a.fecha.split('/');

                    final dateA = DateTime(

                      int.parse(partsA[2]),
                      int.parse(partsA[1]),
                      int.parse(partsA[0]),
                    );

                    /// Fecha B
                    final partsB =
                        b.fecha.split('/');

                    final dateB = DateTime(

                      int.parse(partsB[2]),
                      int.parse(partsB[1]),
                      int.parse(partsB[0]),
                    );



                    /// Próximas:
                    /// ascendente
                    if (showUpcoming) {

                      return dateA.compareTo(
                        dateB,
                      );
                    }



                    /// Pasadas:
                    /// descendente
                    return dateB.compareTo(
                      dateA,
                    );
                  });



                  /// ===============================================
                  /// LISTA VACÍA
                  /// ===============================================

                  if (filteredBookings.isEmpty) {

                    return Center(

                      child: Text(

                        showUpcoming
                            ? 'No tienes reservas próximas'
                            : 'No tienes reservas pasadas',

                        style: const TextStyle(

                          /// Tamaño texto
                          fontSize: 18,

                          /// Color gris
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }



                  /// ===============================================
                  /// LISTVIEW
                  /// ===============================================

                  return ListView.builder(

                    /// Cantidad items
                    itemCount:
                        filteredBookings.length,

                    /// Builder items
                    itemBuilder: (context, index) {

                      /// Reserva actual
                      final booking =
                          filteredBookings[index];



                      /// ===========================================
                      /// CARD
                      /// ===========================================

                      return BookingCard(

                        /// Datos reserva
                        booking: booking,



                        /// =========================================
                        /// CANCELAR
                        /// =========================================

                        onCancel: () async {

                          /// Mostrar confirmación
                          final confirm =
                              await showDialog(

                            context: context,

                            builder: (context) {

                              return AlertDialog(

                                /// Título
                                title: const Text(
                                  'Cancelar reserva',
                                ),

                                /// Contenido
                                content: const Text(

                                  '¿Seguro que deseas cancelar esta reserva?',
                                ),

                                /// Botones
                                actions: [

                                  /// BOTÓN NO
                                  TextButton(

                                    onPressed: () {

                                      Navigator.pop(
                                        context,
                                        false,
                                      );
                                    },

                                    child: const Text(
                                      'No',
                                    ),
                                  ),



                                  /// BOTÓN SÍ
                                  ElevatedButton(

                                    onPressed: () {

                                      Navigator.pop(
                                        context,
                                        true,
                                      );
                                    },

                                    child: const Text(

                                      'Sí, cancelar',
                                    ),
                                  ),
                                ],
                              );
                            },
                          );



                          /// Si confirmó
                          if (confirm == true) {

                            /// Eliminar reserva
                            await _controller
                                .cancelBooking(

                              booking.id,
                            );



                            /// Mostrar mensaje
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(

                              const SnackBar(

                                content: Text(

                                  'Su reserva ha sido cancelada',
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}