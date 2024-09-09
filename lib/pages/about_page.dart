import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Mover el contenido hacia arriba
              children: [
                const SizedBox(height: 60), // Espacio superior ajustado
                SvgPicture.asset(
                  'assets/icons/8666609_user_icon.svg',
                  semanticsLabel: 'user Logo',
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hola, soy Vicente, estudiante de Ingeniería en desarrollo de videojuegos y realidad virtual, para esta ocasión tuve que hacer este codigo para dispositivos moviles.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Go Back to Home'),
            ),
          ),
        ],
      ),
    );
  }
}
