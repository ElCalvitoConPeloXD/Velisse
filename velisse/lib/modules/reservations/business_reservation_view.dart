// ===============================================================
// BUSINESS RESERVATION VIEW (PRO + FIX SAFE AREA)
// ===============================================================

import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore DB
import 'package:firebase_auth/firebase_auth.dart'; // usuario logueado
import 'package:flutter/material.dart'; // UI Flutter

// ===============================================================
// PANTALLA DE RESERVAS
// ===============================================================
class BusinessReservationView extends StatefulWidget {
  final String businessId; // id del negocio seleccionado

  const BusinessReservationView({
    super.key,
    required this.businessId,
  });

  @override
  State<BusinessReservationView> createState() =>
      _BusinessReservationViewState();
}

// ===============================================================
// ESTADO
// ===============================================================
class _BusinessReservationViewState extends State<BusinessReservationView> {

  // =============================================================
  // VARIABLES DE SELECCIÓN DEL USUARIO
  // =============================================================
  String? selectedDay; // día elegido
  String? selectedSlot; // hora elegida
  String? selectedService; // servicio elegido
  String? selectedProfessional; // profesional elegido

  // =============================================================
  // STREAM DEL NEGOCIO EN TIEMPO REAL
  // =============================================================
  Stream<DocumentSnapshot> getBusiness() {
    return FirebaseFirestore.instance
        .collection('businesses')
        .doc(widget.businessId)
        .snapshots();
  }

  // =============================================================
  // GENERADOR DE HORARIOS (9:00 - 18:00 -> bloques 1h)
  // =============================================================
  List<String> generateSlots(String start, String end) {

    final startHour = int.parse(start.split(":")[0]); // hora inicio
    final endHour = int.parse(end.split(":")[0]); // hora fin

    List<String> slots = []; // lista de slots

    for (int i = startHour; i < endHour; i++) {

      final from = "${i.toString().padLeft(2, '0')}:00";
      final to = "${(i + 1).toString().padLeft(2, '0')}:00";

      slots.add("$from - $to"); // bloque 1 hora
    }

    return slots; // retorno lista
  }

  // =============================================================
  // CREAR RESERVA EN FIRESTORE
  // =============================================================
  Future<void> createReservation(Map<String, dynamic> business) async {

    final user = FirebaseAuth.instance.currentUser; // usuario actual

    if (user == null) return; // si no hay usuario salir

    final businessName = business['name'] ?? ''; // nombre negocio
    final ownerId = business['ownerId']; // dueño negocio

    // ===========================================================
    // VALIDAR SI YA EXISTE ESA RESERVA
    // ===========================================================
    final existing = await FirebaseFirestore.instance
        .collection('reservations')
        .where('businessId', isEqualTo: widget.businessId)
        .where('day', isEqualTo: selectedDay)
        .where('slot', isEqualTo: selectedSlot)
        .where('professional', isEqualTo: selectedProfessional)
        .get();

    if (existing.docs.isNotEmpty) {

      // si ya existe bloqueado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ese horario ya está reservado"),
        ),
      );

      return;
    }

    // ===========================================================
    // GUARDAR RESERVA COMPLETA
    // ===========================================================
    await FirebaseFirestore.instance.collection('reservations').add({

      "businessId": widget.businessId, // id negocio
      "businessName": businessName, // nombre negocio

      "ownerId": ownerId, // dueño del negocio

      "userId": user.uid, // cliente que reserva
      "userEmail": user.email, // email cliente

      "day": selectedDay, // día seleccionado
      "slot": selectedSlot, // hora seleccionada
      "service": selectedService, // servicio
      "professional": selectedProfessional, // profesional

      "status": "confirmed", // estado de reserva

      "createdAt": FieldValue.serverTimestamp(), // fecha creación
    });

    // si widget destruido evitar crash
    if (!context.mounted) return;

    // mensaje éxito
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Reserva creada correctamente"),
      ),
    );

    // volver atrás
    Navigator.pop(context);
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
        title: const Text("Reservar cita"),
      ),

      // =========================================================
      // BODY
      // =========================================================
      body: StreamBuilder<DocumentSnapshot>(

        stream: getBusiness(), // escuchamos negocio

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final schedule =
              Map<String, dynamic>.from(data['schedule'] ?? {});

          return ListView(

            // 🔥 IMPORTANTE: padding extra abajo para no tapar botón
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),

            children: [

              const Text(
                "Selecciona día, hora, servicio y profesional",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // =================================================
              // DÍAS + HORARIOS
              // =================================================
              ...schedule.entries.map((entry) {

                final day = entry.key;
                final value = Map<String, dynamic>.from(entry.value);

                final bool active = value['active'] ?? false;
                final List slotsRaw = value['slots'] ?? [];

                if (!active) {

                  return ListTile(
                    title: Text(day),
                    subtitle: const Text("Cerrado"),
                  );
                }

                List<String> slots = [];

                for (var s in slotsRaw) {

                  final map = Map<String, dynamic>.from(s);

                  slots.addAll(
                    generateSlots(map['start'], map['end']),
                  );
                }

                return ExpansionTile(

                  title: Text(day),

                  children: slots.map((slot) {

                    final isSelected =
                        selectedDay == day && selectedSlot == slot;

                    return ListTile(

                      title: Text(slot),

                      trailing: isSelected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,

                      onTap: () {
                        setState(() {
                          selectedDay = day;
                          selectedSlot = slot;
                        });
                      },
                    );
                  }).toList(),
                );
              }),

              const SizedBox(height: 20),

              // =================================================
              // SERVICIOS (TEMPORAL)
              // =================================================
              const Text("Servicio"),

              Wrap(
                spacing: 8,
                children: ["Manicura", "Pedicura", "Corte"].map((s) {

                  return ChoiceChip(

                    label: Text(s),

                    selected: selectedService == s,

                    onSelected: (_) =>
                        setState(() => selectedService = s),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // =================================================
              // PROFESIONALES (TEMPORAL)
              // =================================================
              const Text("Profesional"),

              Wrap(
                spacing: 8,
                children: ["Maria", "Miguel"].map((p) {

                  return ChoiceChip(

                    label: Text(p),

                    selected: selectedProfessional == p,

                    onSelected: (_) =>
                        setState(() => selectedProfessional = p),
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),

              // =================================================
              // BOTÓN FINAL (SAFE AREA FIX)
              // =================================================
              SafeArea(

                child: SizedBox(

                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    onPressed: (selectedDay == null ||
                            selectedSlot == null ||
                            selectedService == null ||
                            selectedProfessional == null)
                        ? null
                        : () async {

                            final data =
                                (await getBusiness().first).data()
                                    as Map<String, dynamic>;

                            await createReservation(data);
                          },

                    child: const Text(
                      "Confirmar reserva",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}