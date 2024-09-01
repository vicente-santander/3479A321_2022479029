import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/icons/8674409_ic_fluent_bot_regular_icon.svg',
              semanticsLabel: 'robot Logo',
              width: 100,
            ),
            const Text(
              'Has presionado el botón esta cantidad de veces:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      persistentFooterButtons: _buildPersistentFooterButtons(),
    );
  }

  List<Widget> _buildPersistentFooterButtons() {
    return [
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
    ];
  }
}
