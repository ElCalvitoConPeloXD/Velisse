import 'package:flutter/material.dart';
// 👉 Importa todo el sistema visual de Flutter (widgets, botones, layouts, etc)

import '../modules/dashboard/views/dashboard_bookings_view.dart';
// 👉 Importa la pantalla Dashboard (a donde iremos después de guardar)


// 👉 Widget principal de la pantalla de ubicación
// 👉 StatefulWidget porque necesitamos manejar estado (lo que escribe el usuario)
class UbicacionView extends StatefulWidget {

  const UbicacionView({super.key}); 
  // 👉 Constructor del widget

  @override
  State<UbicacionView> createState() => _UbicacionViewState(); 
  // 👉 Crea el estado asociado
}


// 👉 Clase que maneja la lógica y el estado de la pantalla
class _UbicacionViewState extends State<UbicacionView> {

  // 👉 Controlador para capturar el texto que escribe el usuario
  final TextEditingController locationController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // 👉 Método que construye la interfaz (UI)

    return Scaffold(
      // 👉 Estructura base de la pantalla

      body: Stack(
        // 👉 Stack permite poner elementos uno encima de otro (fondo + contenido)

        children: [

          // 🖼️ FONDO (IMAGEN)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Velisse_Fondo_General.png"),
                // 👉 Imagen que agregaste en assets

                fit: BoxFit.cover,
                // 👉 Hace que la imagen cubra toda la pantalla
              ),
            ),
          ),

          // 🌑 CAPA OSCURA (OVERLAY)
          Container(
            color: Colors.black.withOpacity(0.2),
            // 👉 Oscurece un poco el fondo para mejorar visibilidad del texto
          ),

          // 🔝 CONTENIDO PRINCIPAL
          SafeArea(
            // 👉 Evita que el contenido se meta en el notch o barra superior

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // 👉 Espacio a los lados

              child: Column(
                // 👉 Organiza todo verticalmente

                crossAxisAlignment: CrossAxisAlignment.start,
                // 👉 Alinea a la izquierda

                children: [

                  // 🔙 BOTÓN ATRÁS
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),

                    onPressed: () {
                      Navigator.pop(context);
                      // 👉 Regresa a la pantalla anterior
                    },
                  ),

                  const SizedBox(height: 10),
                  // 👉 Espacio vertical

                  // 📝 SUBTÍTULO
                  const Text(
                    "Configuración de cuenta",
                    style: TextStyle(color: Colors.black45),
                  ),

                  const SizedBox(height: 8),

                  // 🧠 TÍTULO PRINCIPAL
                  const Text(
                    "Indica la ubicación física de tu establecimiento",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 📄 DESCRIPCIÓN
                  const Text(
                    "Añade la ubicación principal de tu negocio para que tus clientes puedan encontrarte fácilmente.",
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 20),

                  // 📍 INPUT DE UBICACIÓN
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Row(
                      // 👉 Fila con icono + input

                      children: [

                        const Icon(Icons.location_on, color: Colors.black54),
                        // 👉 Icono de ubicación

                        const SizedBox(width: 10),

                        // 👉 Campo de texto expandible
                        Expanded(
                          child: TextField(
                            controller: locationController,
                            // 👉 Captura lo que escribe el usuario

                            decoration: const InputDecoration(
                              hintText: "Ingresa tu ubicación",
                              border: InputBorder.none,
                              // 👉 Quita borde del input
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),
                  // 👉 Empuja el botón hasta abajo

                  // 🔘 BOTÓN "GUARDAR Y SALIR"
                  Container(
                    width: double.infinity,
                    // 👉 Ocupa todo el ancho

                    margin: const EdgeInsets.only(bottom: 20),
                    // 👉 Espacio inferior

                    child: ElevatedButton(

                      // 👉 ESTILO DEL BOTÓN
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB39DDB),
                        // 👉 Color morado suave

                        foregroundColor: Colors.black,
                        // 👉 Color del texto

                        padding: const EdgeInsets.symmetric(vertical: 18),
                        // 👉 Altura del botón

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // 👉 Bordes redondeados
                        ),
                      ),

                      // 👉 ACCIÓN AL PRESIONAR
                      onPressed: () {

                        // ❌ VALIDACIÓN: si el campo está vacío
                        if (locationController.text.isEmpty) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Ingresa una ubicación"),
                            ),
                          );

                          return; 
                          // 👉 Detiene ejecución (NO navega)
                        }

                        // 👉 Simulación de guardado
                        print(locationController.text);

                        // 🔥 NAVEGACIÓN AL DASHBOARD
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardBookingsView(),
                          ),
                        );
                        // 👉 Reemplaza la pantalla actual (flujo PRO)
                      },

                      // 👉 TEXTO DEL BOTÓN
                      child: const Text(
                        "Guardar y salir",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}