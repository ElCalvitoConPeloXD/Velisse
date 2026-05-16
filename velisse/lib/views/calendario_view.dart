// 👉 Importa Flutter (widgets, UI, navegación, etc.)
import 'package:flutter/material.dart';

// 👉 StatefulWidget porque necesitamos manejar:
// 👉 - estado de la barra inferior
// 👉 - fecha seleccionada
class CalendarioView extends StatefulWidget {

  // 👉 Constructor
  const CalendarioView({super.key});

  @override
  State<CalendarioView> createState() => _CalendarioViewState();
}


// 👉 Clase que maneja el estado (lógica interna)
class _CalendarioViewState extends State<CalendarioView> {

  // 👉 Índice activo de la barra inferior
  int _currentIndex = 1; // 👉 1 = calendario activo

  // 👉 Fecha seleccionada (por defecto: hoy)
  DateTime _selectedDate = DateTime.now();

  // 📅 FUNCIÓN: abrir selector de fecha
  Future<void> _pickDate() async {

    // 👉 Muestra calendario nativo de Flutter
    final DateTime? picked = await showDatePicker(
      context: context,                 // 👉 contexto actual
      initialDate: _selectedDate,       // 👉 fecha inicial
      firstDate: DateTime(2020),        // 👉 fecha mínima
      lastDate: DateTime(2100),         // 👉 fecha máxima
    );

    // 👉 Si el usuario selecciona una fecha válida
    if (picked != null && picked != _selectedDate) {

      setState(() {
        _selectedDate = picked; // 👉 actualiza estado
      });
    }
  }

  // 📆 FUNCIÓN: formatea la fecha a texto tipo "sáb 5 abr"
  String _formatDate(DateTime date) {

    // 👉 Meses abreviados
    const months = [
      'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
    ];

    // 👉 Días abreviados
    const days = [
      'lun', 'mar', 'mié', 'jue', 'vie', 'sáb', 'dom'
    ];

    // 👉 Obtiene día de la semana
    String dayName = days[date.weekday - 1];

    // 👉 Obtiene mes
    String monthName = months[date.month - 1];

    // 👉 Devuelve formato final
    return '$dayName ${date.day} $monthName';
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // 👉 Fondo lila claro (según diseño)
      backgroundColor: const Color(0xFFF3EFFA),

      body: SafeArea(
        // 👉 Evita notch / barra superior

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // 🔙 HEADER
            Padding(
              padding: const EdgeInsets.all(16),

              child: Row(
                children: [

                  // 🔙 BOTÓN ATRÁS
                  IconButton(
                    icon: const Icon(Icons.arrow_back),

                    onPressed: () {
                      Navigator.pop(context);
                      // 👉 vuelve al dashboard SIN cambiar estado
                    },
                  ),

                  const SizedBox(width: 10),

                  // 📅 SELECTOR DE FECHA
                  GestureDetector(
                    onTap: _pickDate, // 👉 abre calendario

                    child: Row(
                      children: [

                        // 👉 Fecha formateada dinámicamente
                        Text(
                          _formatDate(_selectedDate),

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 5),

                        // 👉 Icono de dropdown
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 📅 CONTENIDO PRINCIPAL
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: Row(
                  children: [

                    // ⏰ COLUMNA DE HORAS
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: const [

                        Text("11:00 am"),
                        SizedBox(height: 60),

                        Text("12:00 pm"),
                        SizedBox(height: 60),

                        Text("1:00 pm"),
                        SizedBox(height: 60),

                        Text("2:00 pm"),
                        SizedBox(height: 60),

                        Text("3:00 pm"),
                        SizedBox(height: 60),

                        Text("4:00 pm"),
                      ],
                    ),

                    const SizedBox(width: 10),

                    // 📋 AREA DE CITAS
                    Expanded(
                      child: Center(
                        child: Text(
                          "No hay citas aún",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 🔻 BARRA INFERIOR (igual al dashboard)
      bottomNavigationBar: SafeArea(
        // 👉 Evita que se superponga con botones del sistema

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

              // 🏠 HOME
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 0; // 👉 cambia visualmente
                  });

                  Navigator.pop(context, 0);
                  // 👉 🔥 CLAVE:
                  // 👉 Regresa al dashboard Y le envía el index 0 (HOME)
                },
                child: Icon(
                  Icons.home,
                  color: _currentIndex == 0 ? Colors.purple : Colors.black,
                ),
              ),

              // 📅 CALENDARIO (activo)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Icon(
                  Icons.calendar_today,
                  color: _currentIndex == 1 ? Colors.purple : Colors.black,
                ),
              ),

              // ✏️ EDITAR
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Icon(
                  Icons.edit,
                  color: _currentIndex == 2 ? Colors.purple : Colors.black,
                ),
              ),

              // 🔔 NOTIFICACIONES
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                child: Icon(
                  Icons.notifications_none,
                  color: _currentIndex == 3 ? Colors.purple : Colors.black,
                ),
              ),

              // 👤 PERFIL
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 4;
                  });
                },
                child: Icon(
                  Icons.person,
                  color: _currentIndex == 4 ? Colors.purple : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}