import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'detail_page.dart'; // Importar DetailPage

final logger = Logger();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _hasLogged = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
      logger.d("Counter incremented to $_counter");
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
      logger.d("Counter decremented to $_counter");
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      logger.d("Counter reset to $_counter");
    });
  }

  // Función para determinar el mensaje y el ícono a mostrar
  Widget _getGameStatus() {
    String message;
    Widget icon;

    // Asignar mensaje e ícono dependiendo del valor del contador
    if (_counter == 10) {
      message = "¡Victoria!";
      icon = SvgPicture.asset(
        'assets/icons/8664871_thumbs_up_icon.svg',
        width: 100,
        height: 100,
        semanticsLabel: 'Victoria Icon',
      );
    } else if (_counter == 5) {
      message = "Derrota";
      icon = SvgPicture.asset(
        'assets/icons/8666595_x_icon.svg',
        width: 100,
        height: 100,
        semanticsLabel: 'Derrota Icon',
      );
    } else {
      message = "¡Sigue jugando!";
      icon = SvgPicture.asset(
        'assets/icons/8674409_ic_fluent_bot_regular_icon.svg',
        width: 100,
        height: 100,
        semanticsLabel: 'bot_icon',
      );
    }

    // Devolver tanto el mensaje como el ícono en una columna
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon, // Mostrar el ícono
        const SizedBox(height: 16),
        Text(
          message,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasLogged) {
      logger.i("Building MyHomePage");
      _hasLogged = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Card con el estado del juego y el contador
            Card(
              color: const Color.fromARGB(0, 0, 0, 0), // Color de la Card
              elevation: 1, // Elevación de la Card
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Mensaje del juego (Victoria, Derrota o Sigue jugando)
                    _getGameStatus(),
                    const SizedBox(height: 16),
                    Text(
                      '$_counter',
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Botones para incrementar, decrementar y resetear
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _decrementCounter,
                          icon: const Icon(Icons.arrow_downward),
                        ),
                        IconButton(
                          onPressed: _resetCounter,
                          icon: const Icon(Icons.refresh),
                        ),
                        IconButton(
                          onPressed: _incrementCounter,
                          icon: const Icon(Icons.arrow_upward),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Botón fuera de la Card
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(),
                  ),
                ); // Navegar a DetailPage
              },
              child: const Text('Go to Detail Page'),
            ),
          ],
        ),
      ),
    );
  }
}
