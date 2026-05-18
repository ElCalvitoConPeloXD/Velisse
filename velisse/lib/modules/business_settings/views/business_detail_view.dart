import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:velisse/modules/business/views/business_reservation_view.dart';

class BusinessDetailView extends StatelessWidget {
  final String businessId;

  const BusinessDetailView({
    super.key,
    required this.businessId,
  });

  Stream<DocumentSnapshot> getBusiness() {
    return FirebaseFirestore.instance
        .collection('businesses')
        .doc(businessId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: getBusiness(),
        builder: (context, snapshot) {

          // ================= LOADING =================
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ================= ERROR =================
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          // ================= SIN DATA =================
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('Negocio no encontrado'),
            );
          }

          // ================= DATA =================
          final data =
              snapshot.data!.data() as Map<String, dynamic>;

          final String name = data['name'] ?? '';

          final List<dynamic> categories =
              List<dynamic>.from(data['categories'] ?? []);

          final Map<String, dynamic> schedule =
              Map<String, dynamic>.from(
            data['schedule'] ?? {},
          );

          // ================= ORDEN DÍAS =================
          final orderedDays = [
            'Lunes',
            'Martes',
            'Miércoles',
            'Jueves',
            'Viernes',
            'Sábado',
            'Domingo',
          ];

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // ================= HEADER =================
                  Container(
                    height: 220,
                    width: double.infinity,
                    color: Colors.grey.shade300,

                    child: Center(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= CATEGORÍAS =================
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,

                      children: categories.map<Widget>((category) {
                        return Chip(
                          label: Text(category.toString()),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ================= TITLE =================
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Horarios disponibles",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ================= HORARIOS =================
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: orderedDays.map((day) {

                        final value =
                            Map<String, dynamic>.from(
                          schedule[day] ?? {},
                        );

                        final bool active =
                            value['active'] == true;

                        final List slots =
                            List.from(value['slots'] ?? []);

                        // ================= CERRADO =================
                        if (!active) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 8,
                            ),

                            child: Row(
                              children: [

                                Expanded(
                                  child: Text(
                                    day,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const Text(
                                  "Cerrado",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight:
                                        FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // ================= ABIERTO =================
                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: 18),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(
                                day,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Wrap(
                                spacing: 8,
                                runSpacing: 8,

                                children:
                                    slots.map<Widget>((slot) {

                                  final Map<String, dynamic> s =
                                      Map<String, dynamic>.from(
                                    slot,
                                  );

                                  final start =
                                      s['start'] ?? '';

                                  final end =
                                      s['end'] ?? '';

                                  return Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),

                                    decoration: BoxDecoration(
                                      color: Colors.purple
                                          .withOpacity(0.1),

                                      borderRadius:
                                          BorderRadius.circular(
                                        20,
                                      ),

                                      border: Border.all(
                                        color: Colors.purple,
                                      ),
                                    ),

                                    child: Text(
                                      "$start - $end",
                                      style: const TextStyle(
                                        fontWeight:
                                            FontWeight.w500,
                                      ),
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

                  const SizedBox(height: 30),

                  // ================= BOTÓN =================
                  Padding(
                    padding: const EdgeInsets.all(16),

                    child: SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  BusinessReservationView(
                                businessId: businessId,
                              ),
                            ),
                          );
                        },

                        child: const Text(
                          "Reservar",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}