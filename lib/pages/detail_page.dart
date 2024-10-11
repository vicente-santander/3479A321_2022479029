import 'package:flutter/material.dart';
import 'about_page.dart';
import 'package:flutter_application_1/models/app_data.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(
            32.0), // Aumentar el padding alrededor del contenido del cuerpo
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment
                .center, // Asegurar que los hijos estén centrados horizontalmente
            children: [
              Text(
                'Al presionar la flecha hacia arriba aumenta el contador, al presionar la flecha hacia abajo disminuye y el otro botón reinicia el contador',
                textAlign: TextAlign
                    .center, // Centrar el texto dentro de su propio contenedor
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                  height:
                      40), // Aumentar el espacio entre el texto y los botones
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0), // Ajustar el padding horizontal y vertical
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navegar de regreso a MyHomePage
                  context.read<AppData>().addAction(
                      "Regresó a la página de inicio desde 'Detalle'");
                },
                child: const Text('Go Back to Home'),
              ),
            ),
            const SizedBox(width: 16), // Añadir espacio entre los botones
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  ); // Navegar a About Page
                  context.read<AppData>().addAction("Acceso a 'Sobre'");
                },
                child: const Text('Go to About Page'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
