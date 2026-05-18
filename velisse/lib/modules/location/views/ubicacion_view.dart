import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../dashboard/views/dashboard_bookings_view.dart';

class UbicacionView extends StatefulWidget {

  final String businessId; // 👈 NECESARIO

  const UbicacionView({
    super.key,
    required this.businessId,
  });

  @override
  State<UbicacionView> createState() => _UbicacionViewState();
}

class _UbicacionViewState extends State<UbicacionView> {

  final TextEditingController locationController = TextEditingController();

  bool isLoading = false;

  Future<void> saveLocation() async {

    if (locationController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingresa una ubicación"),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {

      /// 🔥 ACTUALIZAR NEGOCIO
      await FirebaseFirestore.instance
          .collection('businesses')
          .doc(widget.businessId)
          .update({

        "location": {
          "address": locationController.text.trim(),
        },

        "step": "done",
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Negocio configurado correctamente"),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardBookingsView(),
        ),
        (route) => false,
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Velisse_Fondo_General.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.2),
          ),

          SafeArea(

            child: Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Ubicación del negocio",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        hintText: "Ingresa tu ubicación",
                        border: InputBorder.none,
                        icon: Icon(Icons.location_on),
                      ),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(

                      onPressed: isLoading ? null : saveLocation,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB39DDB),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),

                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Guardar y salir",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}