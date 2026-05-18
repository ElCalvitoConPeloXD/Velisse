import 'package:flutter/material.dart';
// 👉 Importa todo el sistema visual de Flutter (widgets, botones, layouts, etc)

import '../../location/views/ubicacion_view.dart';
// 👉 Importa la pantalla de ubicación (siguiente paso del flujo)


// 👉 Widget principal de la pantalla de horarios
// 👉 StatefulWidget porque aquí el usuario cambia datos (días, horas, etc)
class HorariosView extends StatefulWidget {

  const HorariosView({super.key}); 
  // 👉 Constructor del widget

  @override
  State<HorariosView> createState() => _HorariosViewState(); 
  // 👉 Crea el estado asociado
}


// 👉 Clase que maneja toda la lógica y estado
class _HorariosViewState extends State<HorariosView> {

  // 🧠 ESTRUCTURA DE DATOS
  // 👉 Cada día tiene:
  // - active → si el día está habilitado
  // - slots → lista de horarios (inicio / fin)
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


  // 🔥 FUNCIÓN PARA SELECCIONAR HORA
  Future<void> _selectTime(String day, int index, bool isStart) async {

    // 👉 Abre el selector de hora nativo
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    // 👉 Si el usuario seleccionó una hora
    if (picked != null) {

      setState(() {

        // 👉 Formato 24h (ej: 09:00)
        final formatted =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";

        // 👉 Guarda inicio o fin
        if (isStart) {
          days[day]!["slots"][index]["start"] = formatted;
        } else {
          days[day]!["slots"][index]["end"] = formatted;
        }
      });
    }
  }


  // ➕ AGREGAR NUEVO HORARIO
  void _addSlot(String day) {

    setState(() {
      days[day]!["slots"].add({
        "start": "09:00",
        "end": "18:00"
      });
    });
  }


  // ❌ ELIMINAR HORARIO
  void _removeSlot(String day, int index) {

    setState(() {
      days[day]!["slots"].removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // 👉 Estructura base

      backgroundColor: const Color(0xFFEDEAF3),
      // 👉 Fondo claro (luego puedes poner imagen como hiciste en otras pantallas)

      body: SafeArea(
        // 👉 Evita notch

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // 👉 Espaciado lateral

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // 👉 Alineación a la izquierda

            children: [

              // 🔙 BOTÓN ATRÁS
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 10),

              // 📝 SUBTÍTULO
              const Text(
                "Configuración de cuenta",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 8),

              // 🧠 TÍTULO
              const Text(
                "Configura los días y horarios en los que atiendes a tus clientes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // 🔥 LISTA DE DÍAS
              Expanded(
                child: ListView(
                  children: days.keys.map((day) {
                    return _buildDayItem(day);
                  }).toList(),
                ),
              ),

              // 🔘 BOTÓN CONTINUAR
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),

                child: ElevatedButton(

                  // 👉 ESTILO (igual que tus otras pantallas)
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  onPressed: () {

                    // ❌ VALIDACIÓN PRO
                    // 👉 Verifica si al menos un día está activo
                    bool hasActiveDay =
                        days.values.any((day) => day["active"] == true);

                    if (!hasActiveDay) {

                      // 👉 Muestra mensaje si no hay días activos
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Activa al menos un día de atención"),
                        ),
                      );

                      return; // 👉 Bloquea navegación
                    }

                    // ✅ SI TODO ESTÁ BIEN → IR A UBICACIÓN
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UbicacionView(),
                      ),
                    );
                  },

                  child: const Text(
                    "Continuar",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  // 🔥 WIDGET DE CADA DÍA
  Widget _buildDayItem(String day) {

    bool isActive = days[day]!["active"];
    // 👉 Estado del día

    // 👉 Convertimos slots correctamente
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
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // 🔝 DÍA + SWITCH
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                day,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

              Switch(
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    days[day]!["active"] = value;
                  });
                },
              )
            ],
          ),

          // 👉 SOLO SI ESTÁ ACTIVO
          if (isActive) ...[

            const SizedBox(height: 10),

            // 🔥 LISTA DE HORARIOS
            Column(
              children: List.generate(slots.length, (index) {

                String start = slots[index]["start"]!;
                String end = slots[index]["end"]!;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // 👉 HORAS EDITABLES
                      Row(
                        children: [

                          GestureDetector(
                            onTap: () => _selectTime(day, index, true),
                            child: Text(start),
                          ),

                          const Text(" - "),

                          GestureDetector(
                            onTap: () => _selectTime(day, index, false),
                            child: Text(end),
                          ),
                        ],
                      ),

                      // ❌ ELIMINAR
                      IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () => _removeSlot(day, index),
                      )
                    ],
                  ),
                );
              }),
            ),

            // ➕ AGREGAR HORARIO
            TextButton.icon(
              onPressed: () => _addSlot(day),
              icon: const Icon(Icons.add),
              label: const Text("Agregar horario"),
            )
          ]
        ],
      ),
    );
  }
}