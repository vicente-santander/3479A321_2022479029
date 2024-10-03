import 'package:flutter/material.dart';
import 'about_page.dart'; // Importar AboutPage

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
            horizontal: 32.0,
            vertical: 16.0), // Aumentar el padding horizontal y vertical
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navegar de regreso a MyHomePage
              },
              child: const Text('Go Back to Home'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                ); // Navegar a About Page
              },
              child: const Text('Go to About Page'),
            ),
          ],
        ),
      ),
    );
  }
}
