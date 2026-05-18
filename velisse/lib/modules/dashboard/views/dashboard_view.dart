// ===============================================================
// IMPORTS (librerías necesarias)
// ===============================================================

import 'package:flutter/material.dart'; // UI de Flutter
import 'package:firebase_auth/firebase_auth.dart'; // usuario logueado
import 'package:cloud_firestore/cloud_firestore.dart'; // base de datos Firebase

import 'package:velisse/modules/business_settings/views/configuracion_negocio_view.dart'; // pantalla config negocio
import 'package:velisse/modules/calendar/views/calendario_view.dart'; // calendario
import 'package:velisse/modules/home/views/home_view.dart'; // home principal

// ===============================================================
// DASHBOARD PRINCIPAL
// ===============================================================

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

// ===============================================================
// ESTADO DEL DASHBOARD
// ===============================================================

class _DashboardViewState extends State<DashboardView> {

  // índice del bottom navigation (controla iconos activos)
  int _currentIndex = 0;

  // =============================================================
  // OBTENER ID DEL NEGOCIO DEL OWNER LOGUEADO
  // =============================================================
  Future<String?> getBusinessId() async {

    // usuario actual logueado en Firebase Auth
    final user = FirebaseAuth.instance.currentUser;

    // si no hay usuario → no hay negocio
    if (user == null) return null;

    // buscamos en Firestore el negocio cuyo ownerId sea este usuario
    final query = await FirebaseFirestore.instance
        .collection('businesses')
        .where('ownerId', isEqualTo: user.uid)
        .limit(1) // solo un negocio
        .get();

    // si no existe negocio
    if (query.docs.isEmpty) return null;

    // retornamos el ID del negocio
    return query.docs.first.id;
  }

  // =============================================================
  // STREAM: RESERVAS EN TIEMPO REAL
  // =============================================================
  Stream<QuerySnapshot> getReservations(String businessId) {

    // escuchamos la colección "reservations"
    return FirebaseFirestore.instance
        .collection('reservations')

        // filtramos SOLO las reservas de este negocio
        .where('businessId', isEqualTo: businessId)

        // ordenamos por fecha (más recientes primero)
        .orderBy('createdAt', descending: true)

        // stream en tiempo real (se actualiza solo)
        .snapshots();
  }

  // =============================================================
  // CERRAR SESIÓN
  // =============================================================
  Future<void> _confirmLogout() async {

    // mostramos alerta de confirmación
    final bool? salir = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(

          // título del popup
          title: const Text("Cerrar sesión"),

          // mensaje del popup
          content: const Text("¿Seguro que quieres salir?"),

          actions: [

            // botón cancelar
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),

            // botón confirmar logout
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Salir"),
            ),
          ],
        );
      },
    );

    // si confirma salida
    if (salir == true) {

      // cerrar sesión Firebase
      await FirebaseAuth.instance.signOut();

      // evitar errores de contexto
      if (!mounted) return;

      // volver al home y limpiar historial
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
        (route) => false,
      );
    }
  }

  // =============================================================
  // UI PRINCIPAL
  // =============================================================
  @override
  Widget build(BuildContext context) {

    // FutureBuilder porque primero necesitamos el businessId
    return FutureBuilder<String?>(
      future: getBusinessId(),

      builder: (context, businessSnap) {

        // resultado del negocio
        final businessId = businessSnap.data;

        return Scaffold(

          // =====================================================
          // CUERPO DEL DASHBOARD
          // =====================================================
          body: Stack(

            children: [

              // fondo imagen
              Positioned.fill(
                child: Image.asset(
                  'assets/images/Velisse.png',
                  fit: BoxFit.cover,
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      const SizedBox(height: 10),

                      // título pantalla
                      const Text(
                        "Inicio",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // =================================================
                      // BLOQUE: RESERVAS EN TIEMPO REAL
                      // =================================================

                      // si no hay negocio
                      if (businessId == null)
                        const Text("No tienes negocio creado")

                      // si hay negocio
                      else
                        StreamBuilder<QuerySnapshot>(

                          // escuchamos reservas en vivo
                          stream: getReservations(businessId),

                          builder: (context, snapshot) {

                            // loading
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            // lista de reservas
                            final docs = snapshot.data!.docs;

                            // si no hay reservas
                            if (docs.isEmpty) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text("No hay reservas aún"),
                              );
                            }

                            // SI HAY RESERVAS
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // título sección
                                  const Text(
                                    "Próximas citas",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // mostrar máximo 5 reservas
                                  ...docs.take(5).map((doc) {

                                    // convertir datos
                                    final data =
                                        doc.data() as Map<String, dynamic>;

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [

                                          // día reservado
                                          Text("📅 ${data['day']}"),

                                          // hora reservada
                                          Text("⏰ ${data['slot']}"),

                                          // servicio
                                          Text("💅 ${data['service']}"),

                                          // profesional asignado
                                          Text("👤 ${data['professional']}"),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          },
                        ),

                      const SizedBox(height: 20),

                      // =================================================
                      // BLOQUE ACTIVIDAD (UI ESTÁTICA)
                      // =================================================
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Actividad de citas",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            SizedBox(height: 20),

                            Center(
                              child: Column(
                                children: [

                                  Icon(
                                    Icons.event_note,
                                    size: 40,
                                    color: Colors.grey,
                                  ),

                                  SizedBox(height: 10),

                                  Text(
                                    "Aún no tienes actividad",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),

                                  SizedBox(height: 5),

                                  Text(
                                    "Cuando recibas citas, aparecerán aquí",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // =====================================================
          // BOTTOM NAVIGATION
          // =====================================================
          bottomNavigationBar: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 12),

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  )
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [

                  // HOME
                  GestureDetector(
                    onTap: () => setState(() => _currentIndex = 0),
                    child: Icon(
                      Icons.home,
                      color: _currentIndex == 0
                          ? Colors.purple
                          : Colors.black,
                    ),
                  ),

                  // CALENDARIO
                  GestureDetector(
                    onTap: () {
                      setState(() => _currentIndex = 1);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CalendarioView(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.calendar_today,
                      color: _currentIndex == 1
                          ? Colors.purple
                          : Colors.black,
                    ),
                  ),

                  // CONFIGURACIÓN NEGOCIO
                  GestureDetector(
                    onTap: () async {
                      setState(() => _currentIndex = 2);

                      final businessId = await getBusinessId();

                      if (businessId == null) return;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConfiguracionNegocioView(
                            businessId: businessId,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      color: _currentIndex == 2
                          ? Colors.purple
                          : Colors.black,
                    ),
                  ),

                  // LOGOUT
                  GestureDetector(
                    onTap: _confirmLogout,
                    child: const Icon(Icons.logout),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}