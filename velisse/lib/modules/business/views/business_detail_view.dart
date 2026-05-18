import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:velisse/modules/reservations/business_reservation_view.dart';
import 'package:velisse/modules/auth/views/login_view.dart'; 

class BusinessDetailView extends StatelessWidget {
  final String businessId;

  BusinessDetailView({
    super.key,
    required this.businessId,
  });

  Stream<DocumentSnapshot> getBusiness() {
    return FirebaseFirestore.instance
        .collection('businesses')
        .doc(businessId)
        .snapshots();
  }

  final List<String> orderedDays = const [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: getBusiness(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final name = data['name'] ?? '';
          final categories = List<dynamic>.from(data['categories'] ?? []);

          final Map<String, dynamic> schedule =
              Map<String, dynamic>.from(data['schedule'] ?? {});

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// ================= HEADER =================
                Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= CATEGORÍAS =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    children: categories.map<Widget>((c) {
                      return Chip(label: Text(c.toString()));
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 20),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Horarios disponibles",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// ================= HORARIOS =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: orderedDays.map((day) {

                      final value = Map<String, dynamic>.from(
                        schedule[day] ?? {},
                      );

                      final bool active = value['active'] ?? false;
                      final List slots = value['slots'] ?? [];

                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        constraints: const BoxConstraints(
                          minHeight: 90,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12,
                            )
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              day,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            if (!active)
                              const Text(
                                "Cerrado",
                                style: TextStyle(color: Colors.red),
                              ),

                            if (active)
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: slots.map<Widget>((slot) {
                                  final s =
                                      Map<String, dynamic>.from(slot);

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.purple.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "${s['start']} - ${s['end']}",
                                    ),
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      /// ================= BOTÓN RESERVAR =================
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),

              onPressed: () async {

                final user = FirebaseAuth.instance.currentUser;

                /// ❌ NO LOGEADO → LOGIN
                if (user == null) {
                  final goLogin = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Iniciar sesión"),
                        content: const Text(
                          "Debes iniciar sesión para reservar",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Iniciar sesión"),
                          ),
                        ],
                      );
                    },
                  );

                  if (goLogin == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LogginView(), 
                      ),
                    );
                  }

                  return;
                }

                /// ✅ LOGEADO → RESERVAR
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BusinessReservationView(
                      businessId: businessId,
                    ),
                  ),
                );
              },

              child: const Text(
                "Reservar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}