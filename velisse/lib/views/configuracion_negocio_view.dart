import 'package:flutter/material.dart'; 
// 👉 Importa todo el sistema visual de Flutter (botones, textos, layouts, etc)

import 'horarios_view.dart'; 
// 👉 Importa la pantalla a la que vamos a navegar cuando el usuario presione "Continuar"


// 👉 Definimos el widget principal de esta pantalla
// 👉 Es StatefulWidget porque necesitamos manejar estado (selecciones dinámicas)
class ConfiguracionNegocioView extends StatefulWidget {

  const ConfiguracionNegocioView({super.key}); 
  // 👉 Constructor del widget (permite usar key si es necesario)

  @override
  State<ConfiguracionNegocioView> createState() => _ConfiguracionNegocioViewState();
  // 👉 Crea el estado asociado a este widget
}


// 👉 Clase que maneja toda la lógica y el estado de la pantalla
class _ConfiguracionNegocioViewState extends State<ConfiguracionNegocioView> {

  List<String> selectedCategories = []; 
  // 👉 Lista donde se guardan las categorías seleccionadas por el usuario

  @override
  Widget build(BuildContext context) { 
  // 👉 Método que construye la UI (se ejecuta cada vez que cambia el estado)

    return Scaffold( 
    // 👉 Estructura base de la pantalla

      body: Stack( 
      // 👉 Stack permite superponer elementos (fondo + contenido encima)

        children: [

          // 🖼️ CAPA 1: IMAGEN DE FONDO
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Velisse_Fondo_General.png"), 
                // 👉 Ruta de la imagen de fondo

                fit: BoxFit.cover, 
                // 👉 Hace que la imagen cubra toda la pantalla
              ),
            ),
          ),

          // 🌑 CAPA 2: OVERLAY OSCURO
          Container(
            color: Colors.black.withOpacity(0.2), 
            // 👉 Capa semitransparente para mejorar la visibilidad del texto
          ),

          // 🔝 CAPA 3: CONTENIDO PRINCIPAL
          SafeArea( 
          // 👉 Evita que el contenido se meta en el notch o barra superior

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20), 
              // 👉 Espaciado a los lados

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                // 👉 Alinea todo a la izquierda

                children: [

                  // 🔙 BOTÓN DE REGRESO
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black), 
                    // 

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
                    // 👉 Color claro para que se vea sobre fondo oscuro
                  ),

                  const SizedBox(height: 8),

                  // 🧠 TÍTULO PRINCIPAL
                  const Text(
                    "Selecciona las categorías que mejor describen tu negocio",
                    style: TextStyle(
                      fontSize: 20, 
                      // 👉 Tamaño del texto
                      fontWeight: FontWeight.bold, 
                      // 👉 Negrita
                      color: Colors.black, 
                      // 
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 📄 DESCRIPCIÓN
                  const Text(
                    "Elige tu tipo de servicio principal y hasta 3 servicios relacionados",
                    style: TextStyle(color: Colors.white60),
                  ),

                  const SizedBox(height: 20),

                  // 🧱 GRID DE CATEGORÍAS
                  Expanded(
                  // 👉 Hace que el grid ocupe el espacio disponible

                    child: GridView.count(
                      crossAxisCount: 2, 
                      // 👉 2 columnas

                      mainAxisSpacing: 15, 
                      // 👉 Espacio vertical

                      crossAxisSpacing: 15, 
                      // 👉 Espacio horizontal

                      children: [

                        // 👉 Cada elemento es una categoría
                        _buildCategory("Peluquería", Icons.cut),
                        _buildCategory("Salón de uñas", Icons.brush),
                        _buildCategory("Barbería", Icons.content_cut),
                        _buildCategory("Centro facial", Icons.face),
                        _buildCategory("Cejas y pestañas", Icons.visibility),
                        _buildCategory("Depilación", Icons.spa),
                      ],
                    ),
                  ),

                  // 🔘 BOTÓN CONTINUAR
                  Container(
                    width: double.infinity, 
                    // 👉 Ocupa todo el ancho

                    margin: const EdgeInsets.only(bottom: 20), 
                    // 👉 Espacio inferior

                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, 
                        // 👉 Fondo negro

                        foregroundColor: Colors.white, 
                        // 👉 Texto blanco

                        padding: const EdgeInsets.symmetric(vertical: 18), 
                        // 👉 Botón alto (mejor UX)

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), 
                          // 👉 Bordes redondeados
                        ),
                      ),

                      onPressed: () {

                        // ❌ VALIDACIÓN
                        if (selectedCategories.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Selecciona al menos una categoría"),
                            ),
                          );
                          return; 
                          // 👉 Detiene la ejecución (no navega)
                        }

                        // ✅ NAVEGACIÓN
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HorariosView(),
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
        ],
      ),
    );
  }


  // 🔥 FUNCIÓN PARA CREAR CADA TARJETA DE CATEGORÍA
  Widget _buildCategory(String title, IconData icon) {

    final isSelected = selectedCategories.contains(title); 
    // 👉 Verifica si esta categoría ya está seleccionada

    return GestureDetector(
    // 👉 Detecta el toque del usuario

      onTap: () {
        setState(() { 
        // 👉 Actualiza la UI

          if (isSelected) {
            selectedCategories.remove(title); 
            // 👉 Si ya estaba seleccionada → la quitamos
          } else {
            if (selectedCategories.length < 3) {
              selectedCategories.add(title); 
              // 👉 Solo permite máximo 3 selecciones
            }
          }
        });
      },

      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white, 
          // 👉 Cambia color si está seleccionada

          borderRadius: BorderRadius.circular(15), 
          // 👉 Bordes redondeados

          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300, 
            // 👉 Borde dinámico
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          // 👉 Centra contenido verticalmente

          children: [

            // 👉 ICONO
            Icon(
              icon,
              size: 30,
              color: isSelected ? Colors.white : Colors.black,
            ),

            const SizedBox(height: 8),

            // 👉 TEXTO
            Text(
              title,
              textAlign: TextAlign.center,

              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}