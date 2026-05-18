import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusinessReservationView extends StatefulWidget {
  final String businessId;

  const BusinessReservationView({
    super.key,
    required this.businessId,
  });

  @override
  State<BusinessReservationView> createState() =>
      _BusinessReservationViewState();
}

class _BusinessReservationViewState extends State<BusinessReservationView> {

  String? selectedCategory;
  String? selectedHour;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservar")),

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('businesses')
            .doc(widget.businessId)
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final categories = data['categories'] ?? [];

          return Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const Text("Servicio"),

                DropdownButton<String>(
                  value: selectedCategory,
                  items: categories.map<DropdownMenuItem<String>>((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    );
                  }).toList(),

                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {

                    /// AQUÍ LUEGO GUARDAMOS RESERVA
                    await FirebaseFirestore.instance
                        .collection('reservations')
                        .add({
                      'businessId': widget.businessId,
                      'category': selectedCategory,
                      'createdAt': DateTime.now(),
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Reserva creada"),
                      ),
                    );
                  },
                  child: const Text("Confirmar reserva"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}