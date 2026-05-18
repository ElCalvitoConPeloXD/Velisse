// ===============================================================
// DASHBOARD DE RESERVAS DEL CLIENTE (VERSIÓN PRO)
// ===============================================================

// Flutter UI
import 'package:flutter/material.dart';

// Firebase Auth (usuario logueado)
import 'package:firebase_auth/firebase_auth.dart';

// Firestore (base de datos)
import 'package:cloud_firestore/cloud_firestore.dart';


// ===============================================================
// PANTALLA PRINCIPAL
// ===============================================================

class DashboardBookingsView extends StatefulWidget {

  // constructor de la pantalla
  const DashboardBookingsView({super.key});

  @override
  State<DashboardBookingsView> createState() =>
      _DashboardBookingsViewState();
}


// ===============================================================
// ESTADO DEL DASHBOARD
// ===============================================================

class _DashboardBookingsViewState extends State<DashboardBookingsView> {

  // =============================================================
  // TAB SELECCIONADO
  // =============================================================
  // 0 = próximas
  // 1 = pasadas
  // 2 = todas
  int selectedTab = 0;


  // =============================================================
  // OBTENER RESERVAS DEL USUARIO
  // =============================================================
  Stream<QuerySnapshot> getUserReservations() {

    // usuario actual logueado
    final user = FirebaseAuth.instance.currentUser;

    // si no hay usuario → stream vacío
    if (user == null) return const Stream.empty();

    // consulta Firestore
    return FirebaseFirestore.instance
        .collection('reservations')

        // filtramos por usuario
        .where('userId', isEqualTo: user.uid)

        // escuchamos cambios en tiempo real
        .snapshots();
  }


  // =============================================================
  // CONVERTIR RESERVA A FECHA REAL (para filtros)
  // =============================================================
  DateTime? parseReservationDate(Map<String, dynamic> data) {

    try {

      // día de la semana (ej: Lunes)
      final day = data['day'];

      // horario (ej: 12:00 - 13:00)
      final slot = data['slot'];

      // si falta data → null
      if (day == null || slot == null) return null;

      // fecha actual
      final now = DateTime.now();

      // mapa de días
      final mapDays = {
        "Lunes": 1,
        "Martes": 2,
        "Miércoles": 3,
        "Jueves": 4,
        "Viernes": 5,
        "Sábado": 6,
        "Domingo": 7,
      };

      // convertir día a número
      int targetDay = mapDays[day] ?? now.weekday;

      // diferencia de días
      int diff = targetDay - now.weekday;

      // fecha base
      DateTime date = now.add(Duration(days: diff));

      // hora inicio
      final hour = int.parse(slot.split(":")[0]);

      // retornar fecha completa
      return DateTime(date.year, date.month, date.day, hour);

    } catch (e) {
      return null;
    }
  }


  // =============================================================
  // FILTRO DE RESERVAS
  // =============================================================
  List<QueryDocumentSnapshot> filterReservations(
      List<QueryDocumentSnapshot> docs) {

    // tiempo actual
    final now = DateTime.now();

    // si es "todas"
    if (selectedTab == 2) return docs;

    // filtramos lista
    return docs.where((doc) {

      // convertir data
      final data = doc.data() as Map<String, dynamic>;

      // obtener fecha real
      final date = parseReservationDate(data);

      if (date == null) return false;

      // próximas
      if (selectedTab == 0) {
        return date.isAfter(now);
      }

      // pasadas
      return date.isBefore(now);

    }).toList();
  }


  // =============================================================
  // UI PRINCIPAL
  // =============================================================
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // =========================================================
      // APPBAR
      // =========================================================
      appBar: AppBar(
        title: const Text(
          "Mis reservas",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),


      // =========================================================
      // CUERPO
      // =========================================================
      body: Column(

        children: [

          // =====================================================
          // TABS (PRÓXIMAS / PASADAS / TODAS)
          // =====================================================
          Padding(
            padding: const EdgeInsets.all(12),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [

                _tab("Próximas", 0),
                _tab("Pasadas", 1),
                _tab("Todas", 2),
              ],
            ),
          ),


          const SizedBox(height: 10),


          // =====================================================
          // LISTA DE RESERVAS
          // =====================================================
          Expanded(

            child: StreamBuilder<QuerySnapshot>(

              // stream en tiempo real
              stream: getUserReservations(),

              builder: (context, snapshot) {

                // loading
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                // datos
                final docs = snapshot.data!.docs;

                // filtrados
                final filtered = filterReservations(docs);

                // vacío
                if (filtered.isEmpty) {
                  return const Center(
                    child: Text(
                      "No tienes reservas aún",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                // lista
                return ListView.builder(

                  itemCount: filtered.length,

                  itemBuilder: (context, index) {

                    // data reserva
                    final data =
                        filtered[index].data() as Map<String, dynamic>;

                    // id doc para eliminar
                    final docId = filtered[index].id;


                    // =================================================
                    // CARD PRO
                    // =================================================
                    return Container(

                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),

                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(

                        // fondo blanco elegante
                        color: Colors.white.withOpacity(0.97),

                        borderRadius: BorderRadius.circular(18),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],

                        border: Border.all(
                          color: Colors.purple.withOpacity(0.08),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          // =================================================
                          // NOMBRE DEL NEGOCIO
                          // =================================================
                          Text(
                            data['businessName'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // =================================================
                          // BADGES
                          // =================================================
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,

                            children: [

                              _badge(data['day'] ?? '', Colors.purple),

                              _badge(data['slot'] ?? '', Colors.deepPurple),

                              _badge(data['service'] ?? '', Colors.black87),

                              // profesional visible PRO
                              _badge(data['professional'] ?? '', Colors.orange),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // =================================================
                          // BOTÓN CANCELAR
                          // =================================================
                          Align(
                            alignment: Alignment.centerRight,

                            child: TextButton.icon(

                              onPressed: () async {

                                // confirmación
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Cancelar cita"),
                                      content: const Text(
                                        "¿Seguro que quieres cancelar esta cita?",
                                      ),
                                      actions: [

                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text("No"),
                                        ),

                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text(
                                            "Sí, cancelar",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm != true) return;

                                // eliminar Firestore
                                await FirebaseFirestore.instance
                                    .collection('reservations')
                                    .doc(docId)
                                    .delete();

                                // feedback
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Cita cancelada"),
                                  ),
                                );
                              },

                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),

                              label: const Text(
                                "Cancelar",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  // =============================================================
  // TAB WIDGET
  // =============================================================
  Widget _tab(String text, int index) {

    return ChoiceChip(

      label: Text(text),

      selected: selectedTab == index,

      onSelected: (_) {
        setState(() => selectedTab = index);
      },

      selectedColor: Colors.purple.withOpacity(0.2),

      labelStyle: TextStyle(
        color: selectedTab == index ? Colors.purple : Colors.black,
      ),
    );
  }


  // =============================================================
  // BADGE WIDGET
  // =============================================================
  Widget _badge(String text, Color color) {

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),

      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}