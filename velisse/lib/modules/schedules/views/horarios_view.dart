/// ===============================================================
/// IMPORTS
/// ===============================================================

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../location/views/ubicacion_view.dart';

/// ===============================================================
/// HORARIOS VIEW
/// ===============================================================
/// 👉 Guarda horarios en Firestore
/// 👉 Luego pasa a ubicación
class HorariosView extends StatefulWidget {

  final String businessId;

  const HorariosView({
    super.key,
    required this.businessId,
  });

  @override
  State<HorariosView> createState() => _HorariosViewState();
}

/// ===============================================================
/// STATE
/// ===============================================================
class _HorariosViewState extends State<HorariosView> {

  /// 🧠 ESTRUCTURA HORARIOS
  Map<String, Map<String, dynamic>> days = {
    "Lunes": {
      "active": true,
      "slots": [
        {"start": "09:00", "end": "13:00"},
        {"start": "15:00", "end": "19:00"}
      ]
    },
    "Martes": {
      "active": true,
      "slots": [
        {"start": "09:00", "end": "18:00"}
      ]
    },
    "Miércoles": {
      "active": true,
      "slots": [
        {"start": "09:00", "end": "18:00"}
      ]
    },
    "Jueves": {
      "active": true,
      "slots": [
        {"start": "09:00", "end": "18:00"}
      ]
    },
    "Viernes": {
      "active": true,
      "slots": [
        {"start": "09:00", "end": "18:00"}
      ]
    },
    "Sábado": {
      "active": false,
      "slots": [
        {"start": "09:00", "end": "13:00"}
      ]
    },
    "Domingo": {
      "active": false,
      "slots": [
        {"start": "09:00", "end": "13:00"}
      ]
    },
  };

  bool isLoading = false;

  /// ===============================================================
  /// GUARDAR HORARIOS
  /// ===============================================================
  Future<void> saveSchedule() async {

    bool hasActiveDay =
        days.values.any((day) => day["active"] == true);

    if (!hasActiveDay) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Activa al menos un día")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {

      await FirebaseFirestore.instance
          .collection('businesses')
          .doc(widget.businessId)
          .update({
        "schedule": days,
        "step": "location",
      });

      /// 👉 SIGUIENTE PASO (IMPORTANTE PASAR ID)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UbicacionView(
            businessId: widget.businessId,
          ),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );

    } finally {
      setState(() => isLoading = false);
    }
  }

  /// ===============================================================
  /// UI
  /// ===============================================================
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFEDEAF3),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: Column(
            children: [

              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 10),

              const Text(
                "Configura horarios",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: days.keys.map((day) {
                    return _buildDayItem(day);
                  }).toList(),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : saveSchedule,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Continuar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// ===============================================================
  /// ITEM DÍA
  /// ===============================================================
  Widget _buildDayItem(String day) {

    bool isActive = days[day]!["active"];

    List<Map<String, String>> slots =
        List<Map<String, String>>.from(days[day]!["slots"]);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(day),
              Switch(
                value: isActive,
                onChanged: (v) {
                  setState(() {
                    days[day]!["active"] = v;
                  });
                },
              )
            ],
          ),

          if (isActive)
            Column(
              children: List.generate(slots.length, (index) {

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    GestureDetector(
                      onTap: () => _selectTime(day, index, true),
                      child: Text(slots[index]["start"]!),
                    ),

                    const Text(" - "),

                    GestureDetector(
                      onTap: () => _selectTime(day, index, false),
                      child: Text(slots[index]["end"]!),
                    ),

                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _removeSlot(day, index),
                    ),
                  ],
                );
              }),
            ),

          if (isActive)
            TextButton(
              onPressed: () => _addSlot(day),
              child: const Text("Agregar horario"),
            )
        ],
      ),
    );
  }

  Future<void> _selectTime(String day, int index, bool isStart) async {

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {

      setState(() {

        final formatted =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";

        if (isStart) {
          days[day]!["slots"][index]["start"] = formatted;
        } else {
          days[day]!["slots"][index]["end"] = formatted;
        }
      });
    }
  }

  void _addSlot(String day) {
    setState(() {
      days[day]!["slots"].add({"start": "09:00", "end": "18:00"});
    });
  }

  void _removeSlot(String day, int index) {
    setState(() {
      days[day]!["slots"].removeAt(index);
    });
  }
}